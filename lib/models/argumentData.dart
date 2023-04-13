import 'package:googleapis/admin/directory_v1.dart';
import 'package:school_nurse_ofiice/models/user.dart';

class LoginArguments{
  final UserData user;

  LoginArguments(this.user);
}
class UserDateArguments {
  final DateTime date;
  final String name;
  final String email;
  UserDateArguments(this.date,this.name,this.email);
}