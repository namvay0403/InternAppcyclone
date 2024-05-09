class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;

  User(this.id, this.name, this.username, this.email);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'];
}
