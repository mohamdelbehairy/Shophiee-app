abstract class CreateGroupsState {}

final class CreateGroupsInitial extends CreateGroupsState {}

final class CreateGroupsLoading extends CreateGroupsState {}

final class CreateGroupsSuccess extends CreateGroupsState {}

final class CreateGroupsFailure extends CreateGroupsState {
  final String errorMessage;

  CreateGroupsFailure({required this.errorMessage});
}

final class GetGroupSuccess extends CreateGroupsState {}

final class GetGroupsIDSuccess extends CreateGroupsState {}

final class GetGroupFailure extends CreateGroupsState {
  final String errorMessage;

  GetGroupFailure({required this.errorMessage});
}
