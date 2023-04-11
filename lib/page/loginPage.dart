import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:school_nurse_ofiice/util/auth.dart';

import '../models/user.dart';
import '../util/googleHttpClient.dart';

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
            )
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
        push("/insert");
        return;
      case UserState.teacher:
        // push("/");
        return;
      default:
        return;
    }
  }

  void push(String route) {
    Navigator.pushNamed(context, route);
  }
}
