// To parse this JSON data, do
//
//     final acceptedOrdersRes = acceptedOrdersResFromJson(jsonString);

import 'package:speedx_driver_122283/models/OrderListRes.dart';

class AcceptedOrdersRes {
  AcceptedOrdersRes({
    this.status,
    this.data,
  });

  final String status;
  final List<AcceptDatum> data;

  factory AcceptedOrdersRes.fromJson(Map<String, dynamic> json) =>
      AcceptedOrdersRes(
        status: json["status"],
        data: List<AcceptDatum>.from(
            json["data"].map((x) => AcceptDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AcceptDatum {
  AcceptDatum({
    this.id,
    this.orderId,
    this.userId,
    this.remarks,
    this.status,
    this.dateTime,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  final int id;
  final int orderId;
  final int userId;
  final dynamic remarks;
  final String status;
  final DateTime dateTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Datum order;

  factory AcceptDatum.fromJson(Map<String, dynamic> json) => AcceptDatum(
        id: json["id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        remarks: json["remarks"],
        status: json["status"],
        dateTime: DateTime.parse(json["date_time"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        order: Datum.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "remarks": remarks,
        "status": status,
        "date_time": dateTime.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order": order.toJson(),
      };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

enum Type { DROP, PICKUP }

final typeValues = EnumValues({"drop": Type.DROP, "pickup": Type.PICKUP});

class GstCharge {
  GstCharge({
    this.cgst,
    this.sgst,
    this.gst,
  });

  final String cgst;
  final String sgst;
  final int gst;

  factory GstCharge.fromJson(Map<String, dynamic> json) => GstCharge(
        cgst: json["cgst"],
        sgst: json["sgst"],
        gst: json["gst"],
      );

  Map<String, dynamic> toJson() => {
        "cgst": cgst,
        "sgst": sgst,
        "gst": gst,
      };
}

class User {
  User({
    this.id,
    this.fName,
    this.mName,
    this.lName,
    this.email,
    this.phoneNo,
    this.emailVerifiedAt,
    this.image,
    this.referralCode,
    this.referredBy,
    this.address,
    this.latitude,
    this.longitude,
    this.address2,
    this.stateId,
    this.cityId,
    this.zipCode,
    this.idProof1,
    this.idProof1Image,
    this.idProof2,
    this.idProof2Image,
    this.drivingLicenseNo,
    this.drivingLicenseImage,
    this.wallet,
    this.deviceId,
    this.rating,
    this.otp,
    this.status,
    this.otpVerified,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.formattedPhoneNo,
  });

  final int id;
  final String fName;
  final dynamic mName;
  final String lName;
  final String email;
  final String phoneNo;
  final dynamic emailVerifiedAt;
  final String image;
  final String referralCode;
  final dynamic referredBy;
  final String address;
  final String latitude;
  final String longitude;
  final dynamic address2;
  final int stateId;
  final int cityId;
  final String zipCode;
  final dynamic idProof1;
  final String idProof1Image;
  final dynamic idProof2;
  final String idProof2Image;
  final dynamic drivingLicenseNo;
  final String drivingLicenseImage;
  final String wallet;
  final String deviceId;
  final String rating;
  final String otp;
  final Status status;
  final String otpVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String formattedPhoneNo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fName: json["f_name"],
        mName: json["m_name"],
        lName: json["l_name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        emailVerifiedAt: json["email_verified_at"],
        image: json["image"],
        referralCode: json["referral_code"],
        referredBy: json["referred_by"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address2: json["address2"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        zipCode: json["zip_code"],
        idProof1: json["id_proof1"],
        idProof1Image: json["id_proof1_image"],
        idProof2: json["id_proof2"],
        idProof2Image: json["id_proof2_image"],
        drivingLicenseNo: json["driving_license_no"],
        drivingLicenseImage: json["driving_license_image"],
        wallet: json["wallet"],
        deviceId: json["device_id"],
        rating: json["rating"],
        otp: json["otp"],
        status: statusValues.map[json["status"]],
        otpVerified: json["otp_verified"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        formattedPhoneNo: json["formatted_phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "m_name": mName,
        "l_name": lName,
        "email": email,
        "phone_no": phoneNo,
        "email_verified_at": emailVerifiedAt,
        "image": image,
        "referral_code": referralCode,
        "referred_by": referredBy,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "address2": address2,
        "state_id": stateId,
        "city_id": cityId,
        "zip_code": zipCode,
        "id_proof1": idProof1,
        "id_proof1_image": idProof1Image,
        "id_proof2": idProof2,
        "id_proof2_image": idProof2Image,
        "driving_license_no": drivingLicenseNo,
        "driving_license_image": drivingLicenseImage,
        "wallet": wallet,
        "device_id": deviceId,
        "rating": rating,
        "otp": otp,
        "status": statusValues.reverse[status],
        "otp_verified": otpVerified,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "formatted_phone_no": formattedPhoneNo,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
