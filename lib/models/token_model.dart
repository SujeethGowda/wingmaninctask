import 'dart:convert';

class TokenModel {
  final String? token;

  TokenModel({this.token});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'token': token,
      };

  factory TokenModel.fromJson(String data) {
    print(data);
    return TokenModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory TokenModel.fromMap(Map<String, dynamic> data) =>
      TokenModel(token: data as String?);
}
