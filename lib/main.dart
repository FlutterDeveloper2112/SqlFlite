import 'package:flutter/material.dart';

import 'Homepage.dart';

void main() {
  runApp(
      new MaterialApp(
        home: new MyApp(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SnapWork Technical',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
