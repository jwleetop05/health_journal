import 'package:googleapis/admin/directory_v1.dart';
import 'package:school_nurse_ofiice/models/diary.dart';
import 'package:school_nurse_ofiice/models/user.dart';

class LoginArgs {
  final UserData user;

  LoginArgs(this.user);
}

class InsertDataArgs {
  final DateTime date;
  final String name;
  final String email;
  final Diary? diary;

  InsertDataArgs({
    required this.date,
    required this.name,
    required this.email,
    this.diary,
  });
}
