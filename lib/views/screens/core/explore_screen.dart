import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text("Explore"),
        backgroundColor: colorBackground,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Explore Screen", style: TextStyle(color: colorOnPrimary),),
      ),
    );
  }
}