import 'package:app/models/users_model.dart';

final class GetUserStates {}

final class GetUsesInitial extends GetUserStates {}

final class GetUserLoading extends GetUserStates {}

final class GetUserSuccess extends GetUserStates {
  final List <UserModel> user;

  GetUserSuccess({required this.user});
}

final class GetUserFailure extends GetUserStates {
  final String errorMessage;

  GetUserFailure({required this.errorMessage});
}
