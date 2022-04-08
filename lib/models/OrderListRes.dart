// To parse this JSON data, do
//
//     final orderListRes = orderListResFromJson(jsonString);

import 'package:speedx_driver_122283/models/ParcelItem.dart';

class OrderListRes {
  OrderListRes({
    this.status,
    this.data,
  });

  final String status;
  final List<Datum> data;

  factory OrderListRes.fromJson(Map<String, dynamic> json) => OrderListRes(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.uniqueId,
    this.rideType,
    this.userId,
    this.vehicleId,
    this.goodId,
    this.parcelQty,
    this.weight,
    this.requiredLabour,
    this.orderDate,
    this.orderTime,
    this.documents,
    this.pickupAddress,
    this.totalDistance,
    this.vehicleFare,
    this.appliedPromoCode,
    this.promoDiscount,
    this.applyInsurance,
    this.insuranceAmount,
    this.applyWallet,
    this.walletAmount,
    this.gstCharge,
    this.serviceCharge,
    this.labourCharge,
    this.totalAmount,
    this.paymentMethod,
    this.paymentDateTime,
    this.paymentStatus,
    this.transactionId,
    this.pickupTimeOtp,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.dropAddress,
  });

  final int id;
  final String uniqueId;
  final String rideType;
  final int userId;
  final int vehicleId;
  final int goodId;
  final int parcelQty;
  final String weight;
  final String requiredLabour;
  final DateTime orderDate;
  final String orderTime;
  final List<String> documents;
  final PAddress pickupAddress;
  final String totalDistance;
  final String vehicleFare;
  final String appliedPromoCode;
  final String promoDiscount;
  final String applyInsurance;
  final String insuranceAmount;
  final String applyWallet;
  final String walletAmount;
  final GstCharge gstCharge;
  final String serviceCharge;
  final String labourCharge;
  final String totalAmount;
  final String paymentMethod;
  final DateTime paymentDateTime;
  final String paymentStatus;
  final String transactionId;
  final String pickupTimeOtp;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DropAddress> dropAddress;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        uniqueId: json["unique_id"],
        rideType: json["ride_type"],
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        goodId: json["good_id"],
        parcelQty: json["parcel_qty"],
        weight: json["weight"],
        requiredLabour: json["required_labour"],
        orderDate: DateTime.parse(json["order_date"]),
        orderTime: json["order_time"],
        //documents: List<String>.from(json["documents"].map((x) => x)),
        pickupAddress: PAddress.fromJson(json["pickup_address"]),
        totalDistance: json["total_distance"],
        vehicleFare: json["vehicle_fare"],
        appliedPromoCode: json["applied_promo_code"],
        promoDiscount: json["promo_discount"],
        applyInsurance: json["apply_insurance"],
        insuranceAmount: json["insurance_amount"],
        applyWallet: json["apply_wallet"],
        walletAmount: json["wallet_amount"],
        gstCharge: GstCharge.fromJson(json["gst_charge"]),
        serviceCharge: json["service_charge"],
        labourCharge: json["labour_charge"],
        totalAmount: json["total_amount"],
        paymentMethod: json["payment_method"],
        paymentDateTime: DateTime.parse(json["payment_date_time"]),
        paymentStatus: json["payment_status"],
        transactionId: json["transaction_id"],
        pickupTimeOtp: json["pickup_time_otp"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        dropAddress: List<DropAddress>.from(
            json["drop_address"].map((x) => DropAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "ride_type": rideType,
        "user_id": userId,
        "vehicle_id": vehicleId,
        "good_id": goodId,
        "parcel_qty": parcelQty,
        "weight": weight,
        "required_labour": requiredLabour,
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "order_time": orderTime,
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "pickup_address": pickupAddress.toJson(),
        "total_distance": totalDistance,
        "vehicle_fare": vehicleFare,
        "applied_promo_code": appliedPromoCode,
        "promo_discount": promoDiscount,
        "apply_insurance": applyInsurance,
        "insurance_amount": insuranceAmount,
        "apply_wallet": applyWallet,
        "wallet_amount": walletAmount,
        "gst_charge": gstCharge.toJson(),
        "service_charge": serviceCharge,
        "labour_charge": labourCharge,
        "total_amount": totalAmount,
        "payment_method": paymentMethod,
        "payment_date_time": paymentDateTime.toIso8601String(),
        "payment_status": paymentStatus,
        "transaction_id": transactionId,
        "pickup_time_otp": pickupTimeOtp,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "drop_address": List<dynamic>.from(dropAddress.map((x) => x.toJson())),
      };
}

class DropAddress {
  DropAddress({
    this.id,
    this.orderId,
    this.dropAddress,
    this.itemName,
    this.itemWeight,
    this.itemLength,
    this.itemHeight,
    this.image,
    this.dropTimeOtp,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.items
  });

  final int id;
  final int orderId;
  final PAddress dropAddress;
  dynamic itemName;
  dynamic itemWeight;
  dynamic itemLength;
  dynamic itemHeight;
  final String image;
  final String dropTimeOtp;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  ParcelItem parcelItem;
  final List<Items> items;

  factory DropAddress.fromJson(Map<String, dynamic> json) => DropAddress(
        id: json["id"],
        orderId: json["order_id"],
        dropAddress: PAddress.fromJson(json["drop_address"]),
        itemName: json["item_name"],
        itemWeight: json["item_weight"],
        itemLength: json["item_length"],
        itemHeight: json["item_height"],
        image: json["image"],
        dropTimeOtp: json["drop_time_otp"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        items: (json['items'] as List).map((e) => Items.fromJson(e)).toList()
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "drop_address": dropAddress.toJson(),
        "item_name": itemName,
        "item_weight": itemWeight,
        "item_length": itemLength,
        "item_height": itemHeight,
        "image": image,
        "drop_time_otp": dropTimeOtp,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PAddress {
  PAddress({
    this.id,
    this.userId,
    this.name,
    this.phoneNo,
    this.address,
    this.latitude,
    this.longitude,
    this.detailAddress,
    this.landmark,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int userId;
  final String name;
  final String phoneNo;
  final String address;
  final String latitude;
  final String longitude;
  final String detailAddress;
  final String landmark;
  final Type type;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory PAddress.fromJson(Map<String, dynamic> json) => PAddress(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phoneNo: json["phone_no"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        detailAddress: json["detail_address"],
        landmark: json["landmark"],
        type: typeValues.map[json["type"]],
        status: statusValues.map[json["status"]],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone_no": phoneNo,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "detail_address": detailAddress,
        "landmark": landmark,
        "type": typeValues.reverse[type],
        "status": statusValues.reverse[status],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Items {
  Items({
    this.id,
    this.dropAddressId,
    this.goodId,
    this.itemName,
    this.itemWeight,
    this.itemLength,
    this.itemHeight,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.good,
  });

  final int id;
  final int dropAddressId;
  final int goodId;
  final String itemName;
  final String itemWeight;
  final String itemLength;
  final String itemHeight;
  final String image;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Good good;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        dropAddressId: json["drop_address_id"],
        goodId: json["good_id"],
        itemName: json["item_name"],
        itemWeight: json["item_weight"],
        itemLength: json["item_length"],
        itemHeight: json["item_height"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        good: Good.fromJson(json["good"]),
      );
}

class Good {
  Good({
    this.id,
    this.name,
    this.image,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String image;
  final String url;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Good.fromJson(Map<String, dynamic> json) => Good(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        url: json["url"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
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
