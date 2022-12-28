class User {
  late final String name;
  late final String token;

  User(this.name, this.token);

  User.fromJson(Map<String, dynamic> json) {
    name = json['user'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.name;
    data['token'] = this.token;
    return data;
  }
}
