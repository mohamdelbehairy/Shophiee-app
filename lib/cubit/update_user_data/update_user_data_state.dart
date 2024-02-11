class UpdateUserInfoStates {}

class UpdateUserInitial extends UpdateUserInfoStates {}

class UpdateUserLoading extends UpdateUserInfoStates {
  final bool isSelected;

  UpdateUserLoading({required this.isSelected});
}

class UpdateUserSuccess extends UpdateUserInfoStates {}

class UpdateUserBioSuccess extends UpdateUserInfoStates {}

class UpdateUserUserNameSuccess extends UpdateUserInfoStates {}
class UpdateUserNickNameSuccess extends UpdateUserInfoStates {}

class UpdateUserFailure extends UpdateUserInfoStates {
  final String errorMessage;

  UpdateUserFailure({required this.errorMessage});
}

class UpdateProfileImageSuccess extends UpdateUserInfoStates {}

class UpdateProfileImageFailure extends UpdateUserInfoStates {
  final String errorMessage;

  UpdateProfileImageFailure({required this.errorMessage});
}
