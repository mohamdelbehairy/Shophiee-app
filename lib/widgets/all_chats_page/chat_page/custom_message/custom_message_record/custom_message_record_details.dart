import 'package:app/models/message_model.dart';
import 'package:app/utils/widget/slider_sound.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomMessageRecordDetails extends StatelessWidget {
  const CustomMessageRecordDetails(
      {super.key,
      required this.size,
      required this.message,
      required this.duration,
      required this.position,
      required this.audioPlayer,
      required this.recordTimer});
  final Size size;
  final MessageModel message;
  final Duration duration;
  final Duration position;
  final AudioPlayer audioPlayer;
  final String recordTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: size.width * .03),
            child: SliderSound(
                size: size,
                color:
                    message.senderID == FirebaseAuth.instance.currentUser!.uid
                        ? Colors.white
                        : Colors.grey,
                sliderHeight: size.width * .07,
                sliderWidth: size.width * .54,
                duration: duration,
                position: position,
                audioPlayer: audioPlayer)),
        Padding(
          padding:
              EdgeInsets.only(left: size.width * .06, top: size.width * .01),
          child: Text(recordTimer,
              style: TextStyle(
                  fontSize: size.width * .028,
                  color:
                      message.senderID == FirebaseAuth.instance.currentUser!.uid
                          ? Colors.white
                          : Colors.grey)),
        )
      ],
    );
  }
}
