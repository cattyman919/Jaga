class User {
  final String? username;
  final String? email;
  final String? fullName;

  User(this.username, this.email, this.fullName);

  User.fromJson(Map<String, dynamic> json)
      : username = json["username"] as String?,
        email = json["email"] as String?,
        fullName = json["fullName"] as String?;

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'fullName': fullName,
      };
}
