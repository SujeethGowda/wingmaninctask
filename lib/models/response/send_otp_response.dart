import 'dart:convert';

class SendOtpResponse {
  bool? status;
  String? response;
  String? requestId;

  SendOtpResponse({this.status, this.response, this.requestId});

  @override
  String toString() {
    return 'SendOtpResponse(status: $status, response: $response, requestId: $requestId)';
  }

  factory SendOtpResponse.fromMap(Map<String, dynamic> data) {
    return SendOtpResponse(
      status: data['status'] as bool?,
      response: data['response'] as String?,
      requestId: data['request_id'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'response': response,
        'request_id': requestId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SendOtpResponse].
  factory SendOtpResponse.fromJson(String data) {
    return SendOtpResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SendOtpResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  SendOtpResponse copyWith({
    bool? status,
    String? response,
    String? requestId,
  }) {
    return SendOtpResponse(
      status: status ?? this.status,
      response: response ?? this.response,
      requestId: requestId ?? this.requestId,
    );
  }
}
