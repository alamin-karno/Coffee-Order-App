import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    letterSpacing: 1,
  ),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius:  BorderRadius.circular(10.0)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink[300], width: 2.0),
    borderRadius: BorderRadius.circular(12.0)),
);
