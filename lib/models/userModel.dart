class UsersModel {
  String username;
  String userId;

  UsersModel({required this.username, required this.userId});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(username: json['username'], userId: json['userId']);
  }

  Map<String, dynamic> toJson() => {'userId': userId, 'username': username};
}
