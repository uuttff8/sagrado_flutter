class PhoneAuthResponse {
  final String username, status;
  final bool isNew;

  PhoneAuthResponse({this.username, this.status, this.isNew});

  factory PhoneAuthResponse.fromJson(Map<String, dynamic> json) {
    return PhoneAuthResponse(
      username: json['username'] as String,
      status: json['status'] as String,
      isNew: json['new'] as bool,
    );
  }
}

class PhoneCodeResponse {
  final String status, token, pushToken, osType;
  final int userId;
  final bool error;

  PhoneCodeResponse(
      {this.osType, this.pushToken, this.status, this.token, this.userId, this.error});

  factory PhoneCodeResponse.fromJson(Map<String, dynamic> json) {
    return PhoneCodeResponse(
      osType: json['os_type'],
      userId: json['user_id'],
      pushToken: json['push_token'],
      status: json['status'],
      token: json['token'],
      error: json['error'],
    );
  }
}

class SaveSettingsResponse {

}
