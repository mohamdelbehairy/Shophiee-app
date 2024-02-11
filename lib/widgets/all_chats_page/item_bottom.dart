import 'package:flutter/material.dart';

class ItemBottom extends StatelessWidget {
  const ItemBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mohamed'),
          Text('3m ago'),
        ],
      ),
      subtitle: Text('data'),
    );
  }
}
