import 'Data.dart';

class Response {
   final List<Data> data ;
  final String message  ;
  final String timestamp  ;
  final int status  ;
  final bool isSuccess ;

  Response(
      {required this.data, required this.message, required this.timestamp, required this.status, required this.isSuccess});

  // factory Response.fromJson(Map<String, dynamic> json, this.data, this.message, this.timestamp, this.status, this.isSuccess) {
  //   return Response(
  //   data: (json['data'] != null)? json['data']:{
  //       data = <Data>[]
  //     json['data'].forEach((v) {
  //       data.add(Data.fromJson(v))
  //     });
  //     return data,
  //   }
  //   message : json['message'],
  //   timestamp : json['timestamp'],
  //   status : json['status'],
  //   isSuccess : json['isSuccess']);
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}

