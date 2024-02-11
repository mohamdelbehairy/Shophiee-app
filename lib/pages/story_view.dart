import 'package:app/cubit/story/story_cubit.dart';
import 'package:app/cubit/story/story_state.dart';
import 'package:app/models/story_model.dart';
import 'package:app/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({super.key, required this.user});
  final UserModel user;

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    context.read<StoryCubit>().getStory(friendId: widget.user.userID);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<StoryCubit, StoryState>(builder: (context, state) {
      if (state is GetStorySuccess) {
        List<StoryModel> stories = state.stories;
        return Scaffold(
          body: Material(
            child: Stack(
              children: [
                StoryView(
                  storyItems: stories
                      .map(
                        (url) => StoryItem.pageImage(
                          url: url.storyImage!,
                          caption: url.storyText,
                          controller: controller,
                        ),
                      )
                      .toList(),
                  controller: controller,
                  inline: true,
                  repeat: false,
                  onComplete: () => Navigator.pop(context),
                  onVerticalSwipeComplete: (dir) {
                    if (dir == Direction.down) {
                      Navigator.pop(context);
                    }
                  },
                ),
                Positioned(
                  top: size.height * .08,
                  left: size.width * .03,
                  child: SizedBox(
                    height: size.height * .08,
                    width: size.width,
                    child: ListTile(
                      title: Text(
                        widget.user.userName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(widget.user.profileImage),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
