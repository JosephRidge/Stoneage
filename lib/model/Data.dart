class Data {
  final String username;
  final String email;
  final String password;
  final String createdDate;

  const Data(
      {required this.username,
      required this.email,
      required this.password,
      required this.createdDate});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        createdDate: json['createdDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
