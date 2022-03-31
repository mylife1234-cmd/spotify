import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToQueueTile extends StatelessWidget {
  const AddToQueueTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      color:Colors.black,
      child: ListTile(
        title: const Text(
          'Add to queue',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const Icon(
          CupertinoIcons.text_badge_plus,
          size: 22,
        ),
        onTap: (){
        },
        // dense: true,
        horizontalTitleGap: 0,
      ),

    );
  }
}
