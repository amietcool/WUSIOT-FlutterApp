import 'dart:convert';

// Main response model
class WorkerListResponse {
  final int responseCode;
  final String successMessage;
  final List<WorkerData> data;

  WorkerListResponse({
    required this.responseCode,
    required this.successMessage,
    required this.data,
  });

  factory WorkerListResponse.fromJson(Map<String, dynamic> json) {
    return WorkerListResponse(
      responseCode: json['responseCode'],
      successMessage: json['successMessage'],
      data: List<WorkerData>.from(
          json['data'].map((x) => WorkerData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "responseCode": responseCode,
      "successMessage": successMessage,
      "data": data.map((x) => x.toJson()).toList(),
    };
  }
}

// Worker Data Model
class WorkerData {
  final Worker worker;
  final List<WorkerDetail> workerdetail;

  WorkerData({
    required this.worker,
    required this.workerdetail,
  });

  factory WorkerData.fromJson(Map<String, dynamic> json) {
    return WorkerData(
      worker: Worker.fromJson(json['worker']),
      workerdetail: List<WorkerDetail>.from(
          json['workerdetail'].map((x) => WorkerDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "worker": worker.toJson(),
      "workerdetail": workerdetail.map((x) => x.toJson()).toList(),
    };
  }
}

// Worker Model
class Worker {
  final int userid;
  final String username;
  final String emailaddress;
  final String? workArea;
  final int age;
  final String profileimage;

  Worker({
    required this.userid,
    required this.username,
    required this.emailaddress,
    required this.workArea,
    required this.age,
    required this.profileimage,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      userid: json['userid'],
      username: json['username'],
      emailaddress: json['emailaddress'],
      workArea: json['work_area'],
      age: json['age'],
      profileimage: json['profileimage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": userid,
      "username": username,
      "emailaddress": emailaddress,
      "work_area": workArea,
      "age": age,
      "profileimage": profileimage,
    };
  }
}

// Worker Detail Model
class WorkerDetail {
  final String keytype;
  final String value;
  final String uuid;
  final String address;
  final String devicename;
  final String createdat;

  WorkerDetail({
    required this.keytype,
    required this.value,
    required this.uuid,
    required this.address,
    required this.devicename,
    required this.createdat,
  });

  factory WorkerDetail.fromJson(Map<String, dynamic> json) {
    return WorkerDetail(
      keytype: json['keytype'],
      value: json['value'],
      uuid: json['uuid'],
      address: json['address'],
      devicename: json['devicename'],
      createdat: json['createdat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "keytype": keytype,
      "value": value,
      "uuid": uuid,
      "address": address,
      "devicename": devicename,
      "createdat": createdat,
    };
  }
}
