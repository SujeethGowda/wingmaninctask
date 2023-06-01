import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wingmaninctask/models/otp_request_id.dart';
import 'package:wingmaninctask/models/response/send_otp_response.dart';
import 'package:wingmaninctask/providers/otp_provider.dart';
import 'package:wingmaninctask/screens/auth/verify_otp_screen/verify_otp_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "RegistrationScreen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset("assets/images/logo.png", height: 150),
          ),
          Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                  8.0,
                                ),
                                child: Icon(Icons.phone, size: 20),
                              ),
                              Text("+91")
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: "Phone Number",
                                isDense: true,
                                border: OutlineInputBorder()),
                            controller: _phoneNumberController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            child: const Text("Register"),
                            onPressed: () {
                              requestOtp();
                            },
                          ),
                        )
                ],
              ))
        ]),
      ]),
    );
  }

  void requestOtp() async {
    setState(() {
      _isLoading = true;
    });
    SendOtpResponse? response =
        await Provider.of<OtpProvider>(context, listen: false)
            .sendOtp(_phoneNumberController.text);
    setState(() {
      _isLoading = false;
    });
    if (response != null && response.status == true) {
      Navigator.of(context).pushNamed(VerifyOtpScreen.routeName,
          arguments:
              OtpMobile(_phoneNumberController.text, response.requestId));
    } else {}
  }
}
