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
