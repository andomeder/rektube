import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text("Library"),
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Library Screen", style: TextStyle(color: extraColor),),
      ),
    );
  }
}