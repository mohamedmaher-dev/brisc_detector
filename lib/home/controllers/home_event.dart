import 'dart:io';

abstract class HomeEvent {}

class LoadModelEvent extends HomeEvent {}

class PickImageFromGalleryEvent extends HomeEvent {}

class PickImageFromCameraEvent extends HomeEvent {}

class ClassifyImageEvent extends HomeEvent {
  final File imageFile;

  ClassifyImageEvent(this.imageFile);
}

class ClearResultsEvent extends HomeEvent {}
