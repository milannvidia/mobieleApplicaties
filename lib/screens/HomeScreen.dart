import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          "https://images.squarespace-cdn.com/content/v1/61b681e6a770c2057a323b92/3613edf1-65ae-4ea1-a441-534b449949c0/SwoletariatIconStrokev2.png",
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
  
}