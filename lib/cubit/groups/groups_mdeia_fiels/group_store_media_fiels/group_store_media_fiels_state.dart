part of 'group_store_media_fiels_cubit.dart';

@immutable
sealed class GroupStoreMediaFielsState {}

final class GroupStoreMediaFielsInitial extends GroupStoreMediaFielsState {}

final class GroupStoreMediaFielsLoading extends GroupStoreMediaFielsState {}

final class GroupStoreMediaFielsStoreMediaSuccess
    extends GroupStoreMediaFielsState {}

final class GroupStoreMediaFielsFailure extends GroupStoreMediaFielsState {
  final String errorMessage;

  GroupStoreMediaFielsFailure({required this.errorMessage});
}
