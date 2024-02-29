import 'package:app/utils/navigation.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickContactBottomSheetButton extends StatelessWidget {
  const PickContactBottomSheetButton(
      {super.key,
      required this.phoneContactName,
      required this.phoneContactNumber,
      required this.user,
      required this.replayContactMessage});
  final String phoneContactName;
  final String phoneContactNumber;
  final UserModel user;
  final String replayContactMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final message = context.read<MessageCubit>();
    final pickContact = context.read<PickContactCubit>();
    navigation() {
      Navigation.navigationOnePop(context: context);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .04),
      child: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
        builder: (context, state) {
          if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              final userData = state.userModel
                  .firstWhere((element) => element.userID == currentUser.uid);
              return GestureDetector(
                onTap: () async {
                  navigation();
                  await message.sendMessage(
                      image: null,
                      file: null,
                      phoneContactName: phoneContactName,
                      phoneContactNumber: phoneContactNumber,
                      receiverID: user.userID,
                      messageText: '',
                      replayImageMessage: '',
                      replayTextMessage: '',
                      replayFileMessage: '',
                      replayContactMessage: replayContactMessage,
                      userName: user.userName,
                      profileImage: user.profileImage,
                      userID: user.userID,
                      myUserName: userData.userName,
                      myProfileImage: userData.profileImage,
                      context: context);
                  pickContact.phoneContact = null;
                },
                child: Container(
                  height: size.height * .07,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * .03),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      'Share Contact',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
