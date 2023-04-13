import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:school_nurse_ofiice/models/json.dart';
import 'package:school_nurse_ofiice/models/user.dart';
import 'package:school_nurse_ofiice/util/google_http_client.dart';

class Auth {
  static const _storage = FlutterSecureStorage();
  static get storage => _storage;
  String userInfo = '{}';
  static Future<UserData?> signIn() async {
    final sign = GoogleSignIn(
      scopes: [
        'email',
        DirectoryApi.adminDirectoryGroupScope,
        DirectoryApi.adminDirectoryUserScope,
      ],
    );
    final user = await sign.signIn();
    if (user == null) {}
    final httpClient = GoogleHttpClient(await user!.authHeaders);
    try {
      final directory = DirectoryApi(httpClient);
      final orgUnitPath = (await directory.users.get(user.id)).orgUnitPath;
      final id = await directory.groups.list(userKey: user.id);
      return UserData(
        id: id.groups?[0].name ?? '4학년 0반',
        name: user.displayName ?? orgUnitPath ?? '',
        email: user.email,
        state: UserState.byLocale(orgUnitPath),
      );
    } finally {
      httpClient.close();
    }
  }

  static Future<void> signOut() async {
    final sign = GoogleSignIn();
    sign.signOut();
  }

  Future<UserState> checkInfo() async {
    userInfo = await _storage.read(key: 'login') ?? '{}';
    LoginState state = LoginState.fromJson(jsonDecode(userInfo) as JSON);

    return UserState.byLocale(state.identity);
  }
}
