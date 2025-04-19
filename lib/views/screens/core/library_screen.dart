import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text("Library"),
        backgroundColor: colorBackground,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Library Screen", style: TextStyle(color: colorOnPrimary),),
      ),
    );
  }
}