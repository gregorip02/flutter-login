class User {
  final String name;
  final String email;
  final String token;

  User({ this.name, this.email, this.token });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      token: json['token']
    );
  }

  User copyWith({ String name, String email, String token }) {
    return User(
      name: this.name ?? name,
      email: this.email ?? email,
      token: this.token ?? token
    );
  }

  User setToken(String token) {
    return copyWith(token: token);
  }

  bool isAuth() => this.token.isNotEmpty;
}