abstract class GroupMessageState {}

final class GroupMessageInitial extends GroupMessageState {}

final class SendMessageGroupSuccess extends GroupMessageState {}

final class SendMessageGroupFailure extends GroupMessageState {
  final String errorMessage;

  SendMessageGroupFailure({required this.errorMessage});
}

final class GetMessageGroupsSuccess extends GroupMessageState {}

final class GetMessageGroupFailure extends GroupMessageState {
  final String errorMessage;

  GetMessageGroupFailure({required this.errorMessage});
}

final class UploadGroupsMessageImageSuccess extends GroupMessageState {}

final class UploadGroupsMessageImageFailure extends GroupMessageState {
  final String errorMessage;

  UploadGroupsMessageImageFailure({required this.errorMessage});
}

final class UploadGroupsMessageVideoSuccess extends GroupMessageState {}

final class UploadGroupsMessageVideoFailure extends GroupMessageState {
  final String errorMessage;

  UploadGroupsMessageVideoFailure({required this.errorMessage});
}

final class UploadGroupsMessageFileSuccess extends GroupMessageState {}

final class UploadGroupsMessageFileFailure extends GroupMessageState {
  final String errorMessage;

  UploadGroupsMessageFileFailure({required this.errorMessage});
}
