import 'package:flutter/material.dart';
import 'package:task_one_reg/firebase_options.dart';
import 'package:task_one_reg/screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      home: homePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
