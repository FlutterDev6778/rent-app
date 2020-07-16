class UserModel {
  String id;
  String name;
  String email;
  String password;
  int ts;

  UserModel({
    this.id = "unknown",
    this.name = "",
    this.email,
    this.password = "",
    this.ts = 0,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : null,
        name = (json['name'] != null) ? json['name'] : "",
        email = (json['email'] != null) ? json['email'] : "",
        password = (json['password'] != null) ? json['password'] : "",
        ts = (json['ts'] != null) ? json['ts'] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id == null) ? null : id,
      "name": (name == null) ? "" : name,
      "email": (email == null) ? "" : email,
      "password": (password == null) ? "" : password,
      "ts": (ts == null) ? 0 : ts,
    };
  }
}
