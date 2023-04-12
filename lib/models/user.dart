import 'package:school_nurse_ofiice/models/json.dart';

class UserData {
  final String id;
  final String name;
  final String email;
  final UserState state;

  const UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.state,
  });

  factory UserData.fromJson(JSON json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      state: UserState.byLocale(json['state']),
    );
  }

  JSON toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}

class LoginState {
  final String? id;
  final String? identity;

  const LoginState({this.id, this.identity});

  factory LoginState.fromJson(JSON json) {
    return LoginState(
      id: json['id'],
      identity: json['identity'],
    );
  }

  JSON toJson() => {
        'id': id,
        'identity': identity,
      };
}

enum UserState {
  teacher('/교사'),
  student('/학생'),
  none('/');

  const UserState(this.locale);
  final String locale;

  factory UserState.byLocale(String? locale) {
    return UserState.values.firstWhere(
      (e) => e.locale == locale,
      orElse: () => UserState.none,
    );
  }
}
