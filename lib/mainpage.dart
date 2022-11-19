import 'dart:ui';

import "package:flutter/material.dart";
import 'package:watchat_ui/chatListView.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.black,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: 
                  Image.asset("assets/images/logo.jpg"),
              ),
            ),
          ),
        ),
        Flexible(
            flex: 8,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: Image.asset(
                    "assets/images/bluewallpaper.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const ChatListView()
              ],
            ))
      ],
    );
  }
}
