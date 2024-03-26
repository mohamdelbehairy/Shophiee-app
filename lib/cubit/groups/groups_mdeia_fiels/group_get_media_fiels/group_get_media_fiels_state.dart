part of 'group_get_media_fiels_cubit.dart';

@immutable
sealed class GroupGetMediaFielsState {}

final class GroupGetMediaFielsInitial extends GroupGetMediaFielsState {}

final class GroupGetMediaFielsLoading extends GroupGetMediaFielsState {}

final class GroupGetMediaSuccess extends GroupGetMediaFielsState {}

final class GroupGetMediaFielsFailure extends GroupGetMediaFielsState {
  final String errorMessage;

  GroupGetMediaFielsFailure({required this.errorMessage});
}
