import 'dart:io';
import 'dart:math' as math;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:brisc_detector/core/utils/assets_manger.dart';
import 'package:brisc_detector/home/data/models/classification_result.dart';
import 'package:brisc_detector/home/data/models/brisc_status.dart';

class TFLiteService {
  static TFLiteService? _instance;
  static TFLiteService get instance => _instance ??= TFLiteService._();
  TFLiteService._();

  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  // Model input/output configurations
  static const int inputSize =
      224; // Common size for image classification models
  static const int numClasses = 4; // Glioma, Meningioma, Pituitary, No Tumor

  bool get isModelLoaded => _isModelLoaded;

  /// Initialize the TensorFlow Lite model
  Future<void> loadModel() async {
    try {
      // Load the model
      _interpreter = await Interpreter.fromAsset(AssetsManger.modelUnquant);

      _isModelLoaded = true;
      // Model loaded successfully
    } catch (e) {
      _isModelLoaded = false;
      rethrow;
    }
  }

  /// Preprocess image for model input
  List<List<List<List<double>>>> _preprocessImage(File imageFile) {
    try {
      // Verify file exists
      if (!imageFile.existsSync()) {
        throw Exception('Image file does not exist: ${imageFile.path}');
      }

      // Read and decode the image
      final bytes = imageFile.readAsBytesSync();

      if (bytes.isEmpty) {
        throw Exception('Image file is empty');
      }

      img.Image? image = img.decodeImage(bytes);

      if (image == null) {
        throw Exception(
          'Failed to decode image. The file may be corrupted or in an unsupported format.',
        );
      }

      // Resize image to model input size
      image = img.copyResize(image, width: inputSize, height: inputSize);

      // Convert to normalized float array [1, 224, 224, 3]
      final input = List.generate(
        1,
        (batch) => List.generate(
          inputSize,
          (y) => List.generate(
            inputSize,
            (x) => List.generate(3, (c) {
              final pixel = image!.getPixel(x, y);
              final red = pixel.r;
              final green = pixel.g;
              final blue = pixel.b;

              // Normalize pixel values to [0, 1]
              switch (c) {
                case 0:
                  return red / 255.0;
                case 1:
                  return green / 255.0;
                case 2:
                  return blue / 255.0;
                default:
                  return 0.0;
              }
            }),
          ),
        ),
      );

      return input;
    } catch (e) {
      throw Exception('Error preprocessing image: $e');
    }
  }

  /// Run inference on the image
  Future<ClassificationResult> classifyImage(File imageFile) async {
    if (!_isModelLoaded || _interpreter == null) {
      throw Exception('Model not loaded. Call loadModel() first.');
    }

    try {
      // Preprocess the image
      final input = _preprocessImage(imageFile);

      // Prepare output buffer
      final output = List.generate(1, (_) => List.filled(numClasses, 0.0));

      // Run inference
      _interpreter!.run(input, output);

      // Get predictions
      final predictions = output[0];

      // Apply softmax to get probabilities
      final probabilities = _softmax(predictions);

      // Find the class with highest probability
      int maxIndex = 0;
      double maxConfidence = probabilities[0];
      for (int i = 1; i < probabilities.length; i++) {
        if (probabilities[i] > maxConfidence) {
          maxConfidence = probabilities[i];
          maxIndex = i;
        }
      }

      // Map to BriscStatus enum
      final tumorTypes = [
        BriscStatus.glioma, // 0
        BriscStatus.meningioma, // 1
        BriscStatus.pituitary, // 2
        BriscStatus.noTumor, // 3
      ];

      final allPredictions = <BriscStatus, double>{};
      for (int i = 0; i < tumorTypes.length; i++) {
        allPredictions[tumorTypes[i]] = probabilities[i];
      }

      return ClassificationResult(
        tumorType: tumorTypes[maxIndex],
        confidence: maxConfidence,
        allPredictions: allPredictions,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Apply softmax activation function
  List<double> _softmax(List<double> logits) {
    final maxLogit = logits.reduce((a, b) => a > b ? a : b);
    final expValues = logits.map((x) => math.exp(x - maxLogit)).toList();
    final sumExp = expValues.reduce((a, b) => a + b);
    return expValues.map((x) => x / sumExp).toList();
  }

  /// Dispose resources
  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _isModelLoaded = false;
  }
}
