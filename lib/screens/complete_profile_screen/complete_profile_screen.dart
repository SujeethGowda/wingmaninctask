import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wingmaninctask/models/response/profile_submit_response.dart';
import 'package:wingmaninctask/providers/profile_provider.dart';
import 'package:wingmaninctask/screens/home_screen/home_screen.dart';
import 'package:wingmaninctask/utils/globals.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const routeName = "CompleteProfile";
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: []),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Center(child: Text("Complete Profile")),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
              controller: _nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
              controller: _emailController,
            ),
            Column(
              children: [
                _isLoading
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator())
                    : SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: const Text("Confirm"),
                          onPressed: () {
                            updateProfile();
                          },
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    setState(() {
      _isLoading = true;
    });
    ProfileSubmitResponse? response =
        await Provider.of<ProfileProvider>(context, listen: false)
            .updateProfile(_nameController.text, _emailController.text);
    setState(() {
      _isLoading = false;
    });
    if (response != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName, (Route<dynamic> route) => false);
    } else {
      showSnackbar("Failed to Process", 2000, context, Colors.black);
    }
  }
}
