import 'package:flutter/material.dart';

import 'MainScreen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        brightness: Brightness.dark,
        accentColor: Colors.indigoAccent
      ),
      title: "interest Calculator",
      home: MainScreen(),
    );
  }
}
