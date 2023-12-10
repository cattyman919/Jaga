class User {
  final int id;
  final String? username;
  final String? email;
  final String? fullName;

  User(this.id, this.username, this.email, this.fullName);

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        username = json["username"] as String?,
        email = json["email"] as String?,
        fullName = json["fullName"] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'fullName': fullName,
      };
}
