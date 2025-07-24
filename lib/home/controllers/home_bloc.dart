import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brisc_detector/core/services/tflite_service.dart';
import 'package:brisc_detector/home/controllers/home_event.dart';
import 'package:brisc_detector/home/controllers/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TFLiteService _tfliteService = TFLiteService.instance;
  final ImagePicker _imagePicker = ImagePicker();

  HomeBloc() : super(HomeInitial()) {
    on<LoadModelEvent>(_onLoadModel);
    on<PickImageFromGalleryEvent>(_onPickImageFromGallery);
    on<PickImageFromCameraEvent>(_onPickImageFromCamera);
    on<ClassifyImageEvent>(_onClassifyImage);
    on<ClearResultsEvent>(_onClearResults);
  }

  Future<void> _onLoadModel(
    LoadModelEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ModelLoadingState());
    try {
      await _tfliteService.loadModel();
      emit(ModelLoadedState());
    } catch (e) {
      emit(ModelLoadFailedState(e.toString()));
    }
  }

  Future<void> _onPickImageFromGallery(
    PickImageFromGalleryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ImagePickingState());
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);

        // Verify the file exists and is readable
        if (!await imageFile.exists()) {
          emit(ModelLoadFailedState('Selected image file does not exist'));
          return;
        }

        emit(ImagePickedState(imageFile));

        // Small delay to ensure UI updates before classification
        await Future.delayed(const Duration(milliseconds: 500));

        // Automatically classify the picked image
        add(ClassifyImageEvent(imageFile));
      } else {
        // User cancelled, go back to previous state
        if (_tfliteService.isModelLoaded) {
          emit(ModelLoadedState());
        } else {
          emit(HomeInitial());
        }
      }
    } catch (e) {
      emit(ModelLoadFailedState('Failed to pick image: $e'));
    }
  }

  Future<void> _onPickImageFromCamera(
    PickImageFromCameraEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ImagePickingState());
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);

        // Verify the file exists and is readable
        if (!await imageFile.exists()) {
          emit(ModelLoadFailedState('Captured image file does not exist'));
          return;
        }

        emit(ImagePickedState(imageFile));

        // Small delay to ensure UI updates before classification
        await Future.delayed(const Duration(milliseconds: 500));

        // Automatically classify the picked image
        add(ClassifyImageEvent(imageFile));
      } else {
        // User cancelled, go back to previous state
        if (_tfliteService.isModelLoaded) {
          emit(ModelLoadedState());
        } else {
          emit(HomeInitial());
        }
      }
    } catch (e) {
      emit(ModelLoadFailedState('Failed to capture image: $e'));
    }
  }

  Future<void> _onClassifyImage(
    ClassifyImageEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ImageClassifyingState(event.imageFile));
    try {
      final result = await _tfliteService.classifyImage(event.imageFile);
      emit(ImageClassifiedState(event.imageFile, result));
    } catch (e) {
      emit(ClassificationFailedState(event.imageFile, e.toString()));
    }
  }

  Future<void> _onClearResults(
    ClearResultsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (_tfliteService.isModelLoaded) {
      emit(ModelLoadedState());
    } else {
      emit(HomeInitial());
    }
  }

  @override
  Future<void> close() {
    _tfliteService.dispose();
    return super.close();
  }
}
