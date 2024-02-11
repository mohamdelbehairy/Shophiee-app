import 'package:app/widgets/all_chats_page/calls_page_body.dart';
import 'package:flutter/material.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 15,
            itemBuilder: (context,index) {
          return CallsPageBody();
        }),
    );
  }
}