import 'package:flutter/material.dart';
import 'package:watchat_ui/mainpage.dart';
import 'package:watchat_ui/resultGallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchat',
      theme: ThemeData(
        fontFamily: "Lato",
      ),
      home: MainPage()
    );
  }
}
