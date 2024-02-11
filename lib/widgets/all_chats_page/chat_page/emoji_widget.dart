import 'package:app/widgets/all_chats_page/chat_page/emoji_service.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomEmojiWidget extends StatefulWidget {
  const CustomEmojiWidget({super.key, required this.addEmoji});
  final Function addEmoji;

  @override
  State<CustomEmojiWidget> createState() => _CustomEmojiWidgetState();
}

class _CustomEmojiWidgetState extends State<CustomEmojiWidget>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  EmojisServices emojisServices = EmojisServices();
  List<Emoji> smileEmojis = [];
  List<Emoji> petEmojis = [];
  List<Emoji> foodEmojis = [];
  List<Emoji> sporteEmojis = [];
  List<Emoji> vehicleEmojis = [];
  List<Emoji> toolsEmojis = [];
  List<Emoji> objectEmojis = [];
  List<Emoji> flagEmojis = [];
  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    for (var emojisSet in defaultEmojiSet) {
      emojisServices.getCategoryEmojis(category: emojisSet).then((e) async =>
          await emojisServices.filterUnsupported(data: [e]).then((value) {
            for (var element in value) {
              switch (emojisSet.category) {
                case Category.RECENT:
                case Category.SMILEYS:
                  smileEmojis = element.emoji;
                  setState(() {});
                  break;

                case Category.ANIMALS:
                  petEmojis = element.emoji;
                  setState(() {});
                  break;

                case Category.FOODS:
                  foodEmojis = element.emoji;
                  setState(() {});
                  break;

                case Category.ACTIVITIES:
                  sporteEmojis = element.emoji;
                  setState(() {});
                  break;

                case Category.TRAVEL:
                  vehicleEmojis = element.emoji;
                  setState(() {});
                  break;

                case Category.OBJECTS:
                  objectEmojis = element.emoji;
                  setState(() {});
                  break;

                case Category.SYMBOLS:
                  toolsEmojis = element.emoji;
                  setState(() {});
                  break;

                case Category.FLAGS:
                  flagEmojis = element.emoji;
                  setState(() {});
                  break;
                default:
              }
            }
          }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            isScrollable: false,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.all(5),
            unselectedLabelColor: Colors.black.withOpacity(.4),
            tabs: [
              Icon(Icons.emoji_emotions),
              Icon(FontAwesomeIcons.paw),
              Icon(Icons.fastfood),
              Icon(Icons.sports_soccer),
              Icon(FontAwesomeIcons.ship),
              Icon(FontAwesomeIcons.solidLightbulb),
              Icon(Icons.emoji_symbols_rounded),
              Icon(FontAwesomeIcons.solidFlag),
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              buildEmojis(emojis: smileEmojis),
              buildEmojis(emojis: petEmojis),
              buildEmojis(emojis: foodEmojis),
              buildEmojis(emojis: sporteEmojis),
              buildEmojis(emojis: vehicleEmojis),
              buildEmojis(emojis: objectEmojis),
              buildEmojis(emojis: toolsEmojis),
              buildEmojis(emojis: flagEmojis),
            ],
          ))
        ],
      ),
    );
  }

  Widget buildEmojis({required List<Emoji> emojis}) {
    return emojis.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: emojis.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
            ),
            itemBuilder: (context, index) {
              Emoji emoji = emojis[index];
              return Center(
                child: GestureDetector(
                  onTap: () {
                    widget.addEmoji(emoji:emoji);
                  },
                  child: Text(
                    emoji.emoji,
                    style: TextStyle(color: Colors.black,
                    fontSize: 32),
                  ),
                ),
              );
            });
  }
}
