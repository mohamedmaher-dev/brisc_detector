import 'package:brisc_detector/home/data/models/brisc_status.dart';

class ClassificationResult {
  final BriscStatus tumorType;
  final double confidence;
  final Map<BriscStatus, double> allPredictions;

  ClassificationResult({
    required this.tumorType,
    required this.confidence,
    required this.allPredictions,
  });

  @override
  String toString() {
    return 'ClassificationResult(tumorType: $tumorType, confidence: ${(confidence * 100).toStringAsFixed(1)}%)';
  }
}
