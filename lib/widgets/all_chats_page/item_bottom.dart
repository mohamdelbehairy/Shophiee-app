import 'package:app/constants.dart';
import 'package:app/widgets/all_chats_page/stack_item_bottom.dart';
import 'package:flutter/material.dart';

class ChatItemBottom extends StatelessWidget {
  const ChatItemBottom({super.key, required this.name, required this.image});
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            StackItemBottom(
              image: image,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        CircleAvatar(
                          radius: 5,
                          backgroundColor: kPrimaryColor,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .20),
                        Text(
                          '3m ago',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(width: 20,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Introducing yours identity',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .19,
                      ),
                      Text(
                        'typing..',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .05,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
