class UserLogGraphDataModel {
  String username1;
  String name1;
  int count1;

  UserLogGraphDataModel({
    required this.username1,
    required this.name1,
    required this.count1,
  });

  factory UserLogGraphDataModel.fromJson(Map<String, dynamic> json) =>
      UserLogGraphDataModel(
        username1: json["username"].toString(),
        name1: json["name"].toString(),
        count1: int.parse(json["count"]),
      );
}

List<UserLogGraphDataModel> data1ModelFromJson(List data) =>
    List<UserLogGraphDataModel>.from(
      data.map(
        (e) => UserLogGraphDataModel.fromJson(e),
      ),
    );
