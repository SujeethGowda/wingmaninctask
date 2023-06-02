import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingmaninctask/db/local_storage.dart';
import 'package:wingmaninctask/models/response/send_otp_response.dart';
import 'package:http/http.dart' as http;
import 'package:wingmaninctask/models/response/verify_otp_response.dart';

class OtpProvider extends ChangeNotifier {
  Future<SendOtpResponse?> sendOtp(String phoneNumber) async {
    try {
      var url = Uri.parse("https://test-otp-api.7474224.xyz/sendotp.php");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "mobile": phoneNumber,
          },
        ),
      );
      if (response.statusCode == 200) {
        SendOtpResponse responseData = SendOtpResponse.fromJson(response.body);
        return responseData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<VerifyOtpResponse?> verifyOtp(String requestId, String code) async {
    try {
      var url = Uri.parse("https://test-otp-api.7474224.xyz/verifyotp.php");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {"request_id": requestId, "code": code},
        ),
      );
      if (response.statusCode == 200) {
        VerifyOtpResponse? responseData =
            VerifyOtpResponse.fromJson(response.body);
        sharedPref.setTokenInfo(responseData.jwt!);
        return responseData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
