import 'package:flutter_demo/ui/views/home_view.dart';
import 'package:flutter_demo/ui/views/registration_view.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart';

void main() {
  //setup locator
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationView(),
    );
  }
}
