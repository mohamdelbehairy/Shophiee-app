
final class GetFollowingState {}

final class GetFollowingInitial extends GetFollowingState {}

final class GetFollowingLoading extends GetFollowingState {}

final class GetFollowingSuccess extends GetFollowingState {
  final int numberOfFollowers;

  GetFollowingSuccess({required this.numberOfFollowers});
}

final class GetFollowingFailure extends GetFollowingState {
  final String errorMessage;

  GetFollowingFailure({required this.errorMessage});
}

