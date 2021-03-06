import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'screens/login.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage()
        // home: NoteList(),
        );
  }
}
