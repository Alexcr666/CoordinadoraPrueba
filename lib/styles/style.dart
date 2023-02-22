import 'package:pruebaTest/styles/colors.dart';

import 'package:flutter/material.dart';

styleText(double size, var color, bool bold) {
  return TextStyle(
    fontSize: size,
    color: color,
    //fontFamily: GoogleFonts.lato().fontFamily,
    // letterSpacing: 1,
    // height: 1,
    fontWeight: bold != true ? FontWeight.normal : FontWeight.bold,
  );
}

class AppStyle {
  styleText(double size, var color, bool bold, {bool bold2}) {
    return TextStyle(
      fontSize: size,
      color: color,
      height: 1,
      fontFamily: bold == true ? "ralewaiBold" : "ralewaiLight",
      fontWeight: bold2 == true
          ? FontWeight.bold
          : bold != true
              ? FontWeight.normal
              : FontWeight.bold,
    );
  }
}
