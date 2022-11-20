import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 236, 240, 241),
            width: MediaQuery.of(context).size.width / 350,
          ),
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 70),
          color: Colors.transparent),
      child: ClipRRect(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 40),
          child: Wrap(
              children: [
                Padding(padding: EdgeInsets.all(15),
                child: child,
                )])),
    );
  }
}
