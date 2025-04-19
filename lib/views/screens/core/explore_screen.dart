import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text("Explore"),
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Explore Screen", style: TextStyle(color: extraColor),),
      ),
    );
  }
}