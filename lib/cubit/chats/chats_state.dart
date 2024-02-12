import 'package:app/models/users_model.dart';

abstract class ChatsState {}

final class ChatsInitiail extends ChatsState {}

final class ChatsLoading extends ChatsState {}

final class ChatsSuccess extends ChatsState {
  final List<UserModel> users;

  ChatsSuccess({required this.users});
}

final class ChatsFailure extends ChatsState {
  final String errorMessage;

  ChatsFailure({required this.errorMessage});
}
