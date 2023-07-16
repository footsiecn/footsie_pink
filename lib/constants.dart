import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
const kPrimaryColor = Color.fromARGB(255, 62, 175, 226);
const kSecondaryColor = Color.fromARGB(255, 235, 79, 126);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const KSuccessColor = Color.fromARGB(255, 20, 237, 129);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

class Instances {
  static late SharedPreferences sp;

  static init() async {
    sp = await SharedPreferences.getInstance();

  }

  static clear() {
    
  }
}
