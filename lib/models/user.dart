class User {
  final String? id;
  final String? name;
  final String? email;

  const User({
    this.id,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email
  };
}

class LoginState {
  final String? id;
  final String? identity;

  const LoginState({
    this.id,
    this.identity
  });

  factory LoginState.fromJson(Map<String, dynamic> json) {
    return LoginState(id: json['id'], identity: json['identity']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'identity': identity
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