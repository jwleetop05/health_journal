import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_nurse_ofiice/models/user.dart';

class Auth {
  static const _storage = FlutterSecureStorage();

  static Future<User?> signIn() async {
    final sign = GoogleSignIn();
    if (await sign.isSignedIn()) {
      final user = await sign.signInSilently();
      return User(
        name: user?.displayName,
        email: user?.email,
      );
    }

    final user = await sign.signIn();
    return User(
      name: user?.displayName,
      email: user?.email,
    );
  }

  static Future<void> signOut() async {
    final sign = GoogleSignIn();
    sign.signOut();
  }
}
