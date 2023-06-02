import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingmaninctask/db/local_storage.dart';
import 'package:wingmaninctask/models/response/profile_submit_response.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  Future<ProfileSubmitResponse?> updateProfile(
      String name, String email) async {
    try {
      String? token = await sharedPref.getToken();
      var url = Uri.parse("https://test-otp-api.7474224.xyz/profilesubmit.php");
      final response = await http.post(
        url,
        headers: {"Token": token, "Content-Type": "application/json"},
        body: json.encode(
          {"name": name, "email": email},
        ),
      );
      if (response.statusCode == 200) {
        ProfileSubmitResponse? responseData =
            ProfileSubmitResponse.fromJson(response.body);
        return responseData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
