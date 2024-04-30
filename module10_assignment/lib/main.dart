import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'SplashScreen.dart';


void main() {
  runApp(const PhotoGallery());
}

class PhotoGallery extends StatelessWidget{
  const PhotoGallery({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Gallery',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}