import 'dart:convert';

class ProfileSubmitResponse {
  bool? status;
  String? response;

  ProfileSubmitResponse({this.status, this.response});

  @override
  String toString() {
    return 'ProfileSubmitResponse(status: $status, response: $response)';
  }

  factory ProfileSubmitResponse.fromMap(Map<String, dynamic> data) {
    return ProfileSubmitResponse(
      status: data['status'] as bool?,
      response: data['response'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'response': response,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProfileSubmitResponse].
  factory ProfileSubmitResponse.fromJson(String data) {
    return ProfileSubmitResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProfileSubmitResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  ProfileSubmitResponse copyWith({
    bool? status,
    String? response,
  }) {
    return ProfileSubmitResponse(
      status: status ?? this.status,
      response: response ?? this.response,
    );
  }
}
