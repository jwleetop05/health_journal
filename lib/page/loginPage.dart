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
    return Container(
      child: TextButton(
        onPressed: getAPI,
        child: Text("Google login"),
      )
    );
  }
  Future getAPI() async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        DirectoryApi.adminDirectoryUserReadonlyScope,
        DirectoryApi.adminDirectoryGroupReadonlyScope,
      ],
    );

    await googleSignIn.signIn();

    final authHeaders = await googleSignIn.currentUser?.authHeaders;
    final httpClient = GoogleHttpClient(authHeaders!);
    try {
      final directory = DirectoryApi(httpClient);
      final path = await directory.users.get(googleSignIn.currentUser!.id);
      final user = await Auth.signIn();
      if (user == null) {
        Navigator.of(context).pushNamed('/login');
      } else {
        var val = jsonEncode(
          LoginState(
            id: googleSignIn.currentUser!.id,
            identity: path.orgUnitPath ?? "",
          ),
        );
        await Auth.storage.write(key: 'login', value: val);
        Navigator.of(context).popUntil((route) => route.isFirst);
        if (path.orgUnitPath == "/교사") {
          Navigator.of(context).pushNamed('/login');
        } else {
          Navigator.of(context).pushNamed('/insert');
        }
      }
    } finally {
      httpClient.close();
    }
  }
}
