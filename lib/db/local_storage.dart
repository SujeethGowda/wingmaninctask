import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingmaninctask/models/token_model.dart';

final sharedPref = Prefs.instance;

class Keys {
  static const authToken = "authToken";
}

class Prefs {
  Prefs._();

  static Prefs get instance => Prefs._();

  static late SharedPreferences sharedPref;

  static Future<void> init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  Future<String> getToken() async {
    final info = sharedPref.getString(Keys.authToken) ?? '';
    return info;
  }

  void setTokenInfo(String value) =>
      sharedPref.setString(Keys.authToken, value);
}
