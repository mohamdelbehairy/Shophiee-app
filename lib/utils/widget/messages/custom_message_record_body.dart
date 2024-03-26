import 'dart:async';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_play_icon.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_record/custom_message_record_details.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMessageRecordBody extends StatefulWidget {
  const CustomMessageRecordBody(
      {super.key,
      required this.size,
      required this.message,
      required this.messageTextColor,
      required this.user});
  final MessageModel message;
  final Size size;
  final Color messageTextColor;
  final UserModel user;

  @override
  State<CustomMessageRecordBody> createState() =>
      _CustomMessageRecordBodyState();
}

class _CustomMessageRecordBodyState extends State<CustomMessageRecordBody> {
  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayerStateChanged();

    audioPlayerDurationChanged();

    audioPlayerPositionChanged();

    audioPlayerComplete();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    return Container(
      width: widget.message.replaySoundMessage != ''
          ? widget.size.width * .8
          : widget.size.width * .7,
      child: Padding(
        padding: EdgeInsets.only(
            left: widget.size.width * .015,
            bottom: widget.size.width * .02,
            top: widget.size.width * .025),
        child: Row(
          children: [
            // if (widget.message.senderID ==
            //     FirebaseAuth.instance.currentUser!.uid)
            //   Padding(
            //     padding: EdgeInsets.only(bottom: widget.size.width * .01),
            //     child: CircleAvatar(
            //       radius: widget.size.height * .03,
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(30),
            //         child: FancyShimmerImage(
            //             boxFit: BoxFit.cover,
            //             shimmerBaseColor:
            //                 isDark ? Colors.white12 : Colors.grey.shade300,
            //             shimmerHighlightColor:
            //                 isDark ? Colors.white24 : Colors.grey.shade100,
            //             imageUrl: widget.user.profileImage),
            //       ),
            //     ),
            //   ),
            // SizedBox(width: widget.size.width * .015),
            Padding(
              padding: EdgeInsets.only(bottom: widget.size.width * .01),
              child: CustomMessageAudioIcon(
                  iconSize: widget.size.height * .025,
                  backgroungColor: Colors.transparent,
                  iconColor: widget.message.senderID ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? Colors.white
                      : Colors.grey,
                  size: widget.size,
                  message: widget.message,
                  onTap: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      audioPlayer.onPlayerComplete.listen((event) {
                        setState(() {
                          isPlaying = false;
                        });
                      });
                      await audioPlayer
                          .play(UrlSource(widget.message.messageRecord!));
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  icon: isPlaying
                      ? FontAwesomeIcons.pause
                      : FontAwesomeIcons.play),
            ),
            CustomMessageRecordDetails(
                isPlaying: isPlaying,
                size: widget.size,
                message: widget.message,
                duration: duration,
                position: position,
                audioPlayer: audioPlayer,
                recordTimer: isPlaying
                    ? formatTime(position.inSeconds)
                    : widget.message.messageRecordTime!),
            if (widget.message.senderID !=
                FirebaseAuth.instance.currentUser!.uid)
              Padding(
                padding: EdgeInsets.only(bottom: widget.size.width * .01),
                child: CircleAvatar(
                  radius: widget.size.height * .03,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FancyShimmerImage(
                        boxFit: BoxFit.cover,
                        shimmerBaseColor:
                            isDark ? Colors.white12 : Colors.grey.shade300,
                        shimmerHighlightColor:
                            isDark ? Colors.white24 : Colors.grey.shade100,
                        imageUrl: widget.user.profileImage),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  StreamSubscription<PlayerState> audioPlayerStateChanged() {
    return audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  void audioPlayerDurationChanged() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  void audioPlayerPositionChanged() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  StreamSubscription<void> audioPlayerComplete() {
    return audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
