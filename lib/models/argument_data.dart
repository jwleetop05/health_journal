import 'package:googleapis/admin/directory_v1.dart';
import 'package:school_nurse_ofiice/models/diary.dart';
import 'package:school_nurse_ofiice/models/user.dart';

class LoginArgs {
  final UserData user;

  LoginArgs(this.user);
}

class InsertDateArgs {
  final DateTime date;
  final String name;
  final String email;
  final Diary diary;
  InsertDateArgs(
    this.date,
    this.name,
    this.email,
    this.diary,
  );
}
