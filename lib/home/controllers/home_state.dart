import 'dart:io';
import 'package:brisc_detector/home/data/models/classification_result.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class ModelLoadingState extends HomeState {}

class ModelLoadedState extends HomeState {}

class ModelLoadFailedState extends HomeState {
  final String error;

  ModelLoadFailedState(this.error);
}

class ImagePickingState extends HomeState {}

class ImagePickedState extends HomeState {
  final File imageFile;

  ImagePickedState(this.imageFile);
}

class ImageClassifyingState extends HomeState {
  final File imageFile;

  ImageClassifyingState(this.imageFile);
}

class ImageClassifiedState extends HomeState {
  final File imageFile;
  final ClassificationResult result;

  ImageClassifiedState(this.imageFile, this.result);
}

class ClassificationFailedState extends HomeState {
  final File imageFile;
  final String error;

  ClassificationFailedState(this.imageFile, this.error);
}
