import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wingmaninctask/providers/otp_provider.dart';
import 'package:wingmaninctask/routes.dart';
import 'package:wingmaninctask/screens/auth/registration_screen/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OtpProvider>(
          create: (context) => OtpProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wingman Inc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RegistrationScreen(),
        routes: customRoutes,
      ),
    );
  }
}
