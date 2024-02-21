abstract class MessageState {}

final class MessageInitial extends MessageState {}

final class SendMessageSuccess extends MessageState {}

final class SendMessageFailure extends MessageState {
  final String errorMessage;

  SendMessageFailure({required this.errorMessage});
}

final class GetMessageSuccess extends MessageState {}

final class GetMessageFailure extends MessageState {
  final String errorMessage;

  GetMessageFailure({required this.errorMessage});
}

final class UploadMessageImageSuccess extends MessageState {}

final class UploadMessageImageFailure extends MessageState {
  final String errorMessage;

  UploadMessageImageFailure({required this.errorMessage});
}

final class UploadMessageFileSuccess extends MessageState {}

final class UploadMessageFileFailure extends MessageState {
  final String errorMessage;

  UploadMessageFileFailure({required this.errorMessage});
}

final class UploadMessageVideoSuccess extends MessageState {}

final class UploadMessageVideoFailure extends MessageState {
  final String errorMessage;

  UploadMessageVideoFailure({required this.errorMessage});
}

final class DeleteMessageSuccess extends MessageState {}

final class DeleteChatSuccess extends MessageState {}

final class TypingSuccess extends MessageState {
  final bool isTyping;

  TypingSuccess({required this.isTyping});
}
