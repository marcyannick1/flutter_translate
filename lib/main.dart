import 'package:flutter/material.dart';
import 'package:flutter_translate/pages/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main(){
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage()
    );
  }
}
