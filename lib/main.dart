import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programming_hero_task/root_bindings.dart';
import 'package:programming_hero_task/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      initialBinding: RootBindings(),
    );
  }
}
