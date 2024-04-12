class UserListDataModel {
  String idy, username, name, datetime1, email;

  UserListDataModel(
      {
      this.idy = "",
      this.username = "",
      this.name = "",
      this.datetime1 = "",
      this.email = ""});

  factory UserListDataModel.fromJSON(Map<String, dynamic> json) {
    return UserListDataModel(
        idy: json["idy"],
        username: json["username"],
        name: json["name"],
        datetime1: json["datetime1"],
        email: json["email"]);
  }
}
