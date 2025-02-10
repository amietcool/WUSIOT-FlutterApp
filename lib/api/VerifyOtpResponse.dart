class VerifyOtpResponse {
  final int responseCode;
  final String successMessage;
  final Data data;

  VerifyOtpResponse({
    required this.responseCode,
    required this.successMessage,
    required this.data,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      responseCode: json['responseCode'],
      successMessage: json['successMessage'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String message;
  final User user;

  Data({
    required this.message,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int userid;
  final String mobilenumber;
  final String otp;
  final String otpgeneratedat;
  final String otpexpiresat;
  final String username;
  final String emailaddress;
  final String workArea;
  final String age;
  final dynamic watchDeviceId;
  final dynamic kawachDeviceId;
  final dynamic profileImage;
  final String isactive;
  final String createdat;
  final String updatedat;

  User({
    required this.userid,
    required this.mobilenumber,
    required this.otp,
    required this.otpgeneratedat,
    required this.otpexpiresat,
    required this.username,
    required this.emailaddress,
    required this.workArea,
    required this.age,
    this.watchDeviceId,
    this.kawachDeviceId,
    this.profileImage,
    required this.isactive,
    required this.createdat,
    required this.updatedat,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      mobilenumber: json['mobilenumber'],
      otp: json['otp'],
      otpgeneratedat: json['otpgeneratedat'],
      otpexpiresat: json['otpexpiresat'],
      username: json['username'],
      emailaddress: json['emailaddress'],
      workArea: (json['work_area'] as String?) ?? 'NA',
      age: (json['age'] as String?) ?? 'NA',
      watchDeviceId: (json['watch_deviceid'] as String?) ?? 'NA',
      kawachDeviceId: (json['kawach_deviceid'] as String?) ?? 'NA',
      profileImage: (json['profile_image'] as String?) ?? 'NA',
      isactive: json['isactive'],
      createdat: json['createdat'],
      updatedat: json['updatedat'],
    );
  }
}
