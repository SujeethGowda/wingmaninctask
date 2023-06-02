import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wingmaninctask/models/otp_request_id.dart';
import 'package:wingmaninctask/models/response/verify_otp_response.dart';
import 'package:wingmaninctask/providers/otp_provider.dart';
import 'package:wingmaninctask/screens/complete_profile_screen/complete_profile_screen.dart';
import 'package:wingmaninctask/utils/globals.dart';

class VerifyOtpScreen extends StatefulWidget {
  static const routeName = "VerifyOtp";
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  bool _isLoading = false;
  OtpMobile? otpMobile;
  final TextEditingController _1stDigit = TextEditingController();
  final TextEditingController _2ndDigit = TextEditingController();
  final TextEditingController _3rdDigit = TextEditingController();
  final TextEditingController _4thDigit = TextEditingController();
  final TextEditingController _5thDigit = TextEditingController();
  final TextEditingController _6thDigit = TextEditingController();

  final FocusNode _1stDigitFocusNode = FocusNode();
  final FocusNode _2ndDigitFocusNode = FocusNode();
  final FocusNode _3rdDigitFocusNode = FocusNode();
  final FocusNode _4thDigitFocusNode = FocusNode();
  final FocusNode _5thDigitFocusNode = FocusNode();
  final FocusNode _6thDigitFocusNode = FocusNode();
  @override
  void didChangeDependencies() {
    otpMobile = ModalRoute.of(context)!.settings.arguments as OtpMobile;
    super.didChangeDependencies();
  }

  void handlePaste(String? text) async {
    setState(() {
      List<String> characters = text!.split('');
      _1stDigit.text = characters[0];
      _2ndDigit.text = characters[1];
      _3rdDigit.text = characters[2];
      _4thDigit.text = characters[3];
      _5thDigit.text = characters[4];
      _6thDigit.text = characters[5];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
        ),
        body: ListView(
          children: [
            Column(children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset("assets/images/logo.png", height: 150),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(
                                      8.0,
                                    ),
                                  ),
                                  Text(
                                      "OTP has been sent to +91-${otpMobile?.mobileNumber ?? ""} ")
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                digitTextBox(
                                    context, _1stDigit, _1stDigitFocusNode),
                                const SizedBox(
                                  width: 10,
                                ),
                                digitTextBox(
                                    context, _2ndDigit, _2ndDigitFocusNode),
                                const SizedBox(
                                  width: 10,
                                ),
                                digitTextBox(
                                    context, _3rdDigit, _3rdDigitFocusNode),
                                const SizedBox(
                                  width: 10,
                                ),
                                digitTextBox(
                                    context, _4thDigit, _4thDigitFocusNode),
                                const SizedBox(
                                  width: 10,
                                ),
                                digitTextBox(
                                    context, _5thDigit, _5thDigitFocusNode),
                                const SizedBox(
                                  width: 10,
                                ),
                                digitTextBox(
                                    context, _6thDigit, _6thDigitFocusNode),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      _isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator())
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ElevatedButton(
                                child: const Text("Verify"),
                                onPressed: () {
                                  if (_1stDigit.text != "" &&
                                      _2ndDigit.text != "" &&
                                      _3rdDigit.text != "" &&
                                      _4thDigit.text != "" &&
                                      _6thDigit.text != "") {
                                    verifyOtp();
                                  } else {
                                    showSnackbar("Enter Valid Otp", 2000,
                                        context, Colors.black);
                                  }
                                },
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Unable to receive OTP "),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Retry",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
            ]),
          ],
        ));
  }

  SizedBox digitTextBox(BuildContext context, TextEditingController controller,
      FocusNode focusNode) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.08,
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        decoration:
            const InputDecoration(isDense: true, border: OutlineInputBorder()),
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            focusNode.nextFocus();
          } else if (value.length > 1) {
            handlePaste(value);
          } else if (value.isEmpty) {
            focusNode.previousFocus();
          }
        },
      ),
    );
  }

  void verifyOtp() async {
    setState(() {
      _isLoading = true;
    });
    String code = _1stDigit.text +
        _2ndDigit.text +
        _3rdDigit.text +
        _4thDigit.text +
        _5thDigit.text +
        _6thDigit.text;
    VerifyOtpResponse? response =
        await Provider.of<OtpProvider>(context, listen: false)
            .verifyOtp(otpMobile!.requestId!, code);
    setState(() {
      _isLoading = false;
    });
    if (response != null && response.status!) {
      Navigator.of(context).pushNamed(CompleteProfileScreen.routeName);
    } else {
      showSnackbar("Failed to Process", 2000, context, Colors.black);
    }
  }
}
