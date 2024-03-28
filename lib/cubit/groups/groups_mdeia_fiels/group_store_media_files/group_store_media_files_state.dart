part of 'group_store_media_files_cubit.dart';

@immutable
sealed class GroupStoreMediaFilesState {}

final class GroupStoreMediaFilesInitial extends GroupStoreMediaFilesState {}

final class GroupStoreMediaFilesLoading extends GroupStoreMediaFilesState {}

final class GroupStoreMediaFilessStoreMediaSuccess
    extends GroupStoreMediaFilesState {}

final class GroupStoreMediaFilesStoreFilesSuccess
    extends GroupStoreMediaFilesState {}

final class GroupStoreMediaFilessStoreLinksSuccess
    extends GroupStoreMediaFilesState {}

final class GroupStoreMediaFilessFailure extends GroupStoreMediaFilesState {
  final String errorMessage;

  GroupStoreMediaFilessFailure({required this.errorMessage});
}
