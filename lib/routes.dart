import 'package:flutter/material.dart';
import 'package:wingmaninctask/screens/complete_profile_screen/complete_profile_screen.dart';
import 'package:wingmaninctask/screens/auth/verify_otp_screen/verify_otp_screen.dart';
import 'package:wingmaninctask/screens/home_screen/home_screen.dart';

var customRoutes = <String, WidgetBuilder>{
  VerifyOtpScreen.routeName: (context) => const VerifyOtpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
