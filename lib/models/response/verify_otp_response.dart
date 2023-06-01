import 'dart:convert';

class VerifyOtpResponse {
	bool? status;
	bool? profileExists;
	String? jwt;

	VerifyOtpResponse({this.status, this.profileExists, this.jwt});

	@override
	String toString() {
		return 'VerifyOtpResponse(status: $status, profileExists: $profileExists, jwt: $jwt)';
	}

	factory VerifyOtpResponse.fromMap(Map<String, dynamic> data) {
		return VerifyOtpResponse(
			status: data['status'] as bool?,
			profileExists: data['profile_exists'] as bool?,
			jwt: data['jwt'] as String?,
		);
	}



	Map<String, dynamic> toMap() => {
				'status': status,
				'profile_exists': profileExists,
				'jwt': jwt,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VerifyOtpResponse].
	factory VerifyOtpResponse.fromJson(String data) {
		return VerifyOtpResponse.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [VerifyOtpResponse] to a JSON string.
	String toJson() => json.encode(toMap());

	VerifyOtpResponse copyWith({
		bool? status,
		bool? profileExists,
		String? jwt,
	}) {
		return VerifyOtpResponse(
			status: status ?? this.status,
			profileExists: profileExists ?? this.profileExists,
			jwt: jwt ?? this.jwt,
		);
	}
}
