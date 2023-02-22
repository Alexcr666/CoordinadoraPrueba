import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pruebaTest/data/models/GeSendModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  Future saveSend(BuildContext context, GetSendModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//  Map json = jsonDecode(model.toString());

    if (model != null) {
      // String user = jsonEncode(UserModel.fromJson(json));
      prefs.setString('shipping', jsonEncode(model.toJson()));
    }
  }

  Future getSend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("shipping") != null) {
      return prefs.getString("shipping");
    } else {
      return false;
    }
  }
}
