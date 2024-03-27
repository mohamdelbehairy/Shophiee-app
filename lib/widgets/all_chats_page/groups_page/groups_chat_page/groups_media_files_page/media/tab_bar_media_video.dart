import 'package:app/constants.dart';
import 'package:app/models/media_fiels_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

class TabBarMediaVideo extends StatefulWidget {
  const TabBarMediaVideo(
      {super.key, required this.mediaFiels, required this.size});
  final MediaFielsModel mediaFiels;
  final Size size;

  @override
  State<TabBarMediaVideo> createState() => _TabBarMediaVideoState();
}

class _TabBarMediaVideoState extends State<TabBarMediaVideo> {
  late VideoPlayerController _videoPlayerController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.mediaFiels.messageVideo!),
    )..initialize().then((value) {
        setState(() {
          _isLoading = false;
          // videoPlayerController.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: kPrimaryColor, size: widget.size.height * .04))
        : Stack(
            children: [
              VideoPlayer(_videoPlayerController),
              Positioned(
                  bottom: widget.size.height * .01,
                  left: widget.size.height * .01,
                  child: Icon(FontAwesomeIcons.expand,
                      color: Colors.white, size: widget.size.width * .035))
            ],
          );
  }
}
