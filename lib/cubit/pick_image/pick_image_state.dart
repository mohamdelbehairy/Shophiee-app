import 'dart:io';

final class PickImageStates {}

final class PickImageInitial extends PickImageStates {}

final class PickImageLoading extends PickImageStates {}

final class PickImageScucccess extends PickImageStates {
  final File image;

  PickImageScucccess({required this.image});
}

final class PickImageFailure extends PickImageStates {
  final String errorMessage;

  PickImageFailure({required this.errorMessage});
}
