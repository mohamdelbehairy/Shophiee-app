import 'package:app/cubit/all_users/all_users_state.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersCubit extends Cubit<GetUserStates> {
  AllUsersCubit() : super(GetUsesInitial());
  CollectionReference info = FirebaseFirestore.instance.collection('users');
  Future<void> allUsers() async {
    emit(GetUserLoading());
    try {
      info.snapshots().listen(
        (snapshot) {
          if (snapshot.docs.isNotEmpty) {
            List<UserModel> users = snapshot.docs
                .map((doc) =>
                    UserModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            if (users.isNotEmpty) {
              emit(GetUserSuccess(user: users));
            }
          }
        },
      );
    } catch (e) {
      print(e.toString());
      emit(GetUserFailure(errorMessage: e.toString()));
    }
  }
}
