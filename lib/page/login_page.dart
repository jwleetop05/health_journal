import 'package:flutter/material.dart';
import 'package:school_nurse_ofiice/models/argumentData.dart';
import 'package:school_nurse_ofiice/util/auth.dart';

import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: TextButton(
            onPressed: getAPI,
            child: const Text("Google login"),
          ),
        ),
      ),
    );
  }

  Future getAPI() async {
    final user = await Auth.signIn();
    if (user == null) {
      return;
    }
    switch (user.state) {
      case UserState.student:
        push("/todo", user);
        return;
      case UserState.teacher:
        push("/todo", user);
        return;
      default:
        return;
    }
  }

  void push(String route, UserData user) {
    Navigator.pushNamed(context, route, arguments: LoginArguments(user));
  }
}
