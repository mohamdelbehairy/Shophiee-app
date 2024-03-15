import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PickSoundPageSlider extends StatelessWidget {
  const PickSoundPageSlider(
      {super.key,
      required this.size,
      required this.duration,
      required this.position,
      required this.audioPlayer});

  final Size size;
  final Duration duration;
  final Duration position;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .8,
      child: Slider(
          min: 0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          activeColor: Colors.white,
          onChanged: (value) {
            final position = Duration(seconds: value.toInt());
            audioPlayer.seek(position);
            audioPlayer.resume();
          }),
    );
  }
}
