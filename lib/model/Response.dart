class Response {
  dynamic? data;
  String? message;
  String? timestamp;
  int? status;
  bool? isSuccess;

  Response(
      {this.data, this.message, this.timestamp, this.status, this.isSuccess});

  Response.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    timestamp = json['timestamp'];
    status = json['status'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = message;
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['isSuccess'] = isSuccess;
    return data;
  }
}