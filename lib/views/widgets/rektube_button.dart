import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

Widget rektubeButton(VoidCallback work, {required label, color = colorOnPrimary}) {
  return MaterialButton(
    onPressed: work,
    color: color,
    minWidth: 150,
    height: 40,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(label),
  );
}