import 'dart:ui';

import 'shared.dart';

class Barcode {
  final BarcodeType type;
  final String value;
  final Rect? boundingBox;
  final List<Offset> corners;

  Barcode({
    required this.type,
    required this.value,
    this.boundingBox,
    this.corners = const [],
  });

  factory Barcode.from(Map json) {
    String value = json['value'] as String;
    BarcodeType type = toBarcodeType(json['type']);
    Rect boundingBox = toRect(json['boundingBox']);
    List<Offset> corners = toPoints(json['corners']);

    if (type == BarcodeType.TEXT) {
      return BarcodeText(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        displayValue: json['value'] as String,
      );
    }

    if (type == BarcodeType.URL) {
      return BarcodeUrl(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        title: json['title'] as String,
        url: json['url'] as String,
      );
    }

    if (type == BarcodeType.SMS) {
      return BarcodeSms(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        number: json['number'] as String,
        message: json['message'] as String,
      );
    }

    if (type == BarcodeType.WIFI) {
      return BarcodeWifi(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        ssid: json['ssid'] as String,
        password: json['password'] as String,
        wifiType: toBarcodeWifiType(json['encryption']),
      );
    }

    if (type == BarcodeType.EMAIL) {
      return BarcodeEmail(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        address: json['address'] as String,
        subject: json['subject'] as String,
        body: json['body'] as String,
        emailType: toBarcodeEmailType(json['emailType']),
      );
    }

    if (type == BarcodeType.PHONE) {
      return BarcodePhone(
          value: value,
          boundingBox: boundingBox,
          corners: corners,
          number: json['number'] as String,
          phoneType: toBarcodePhoneType(json['phoneType']));
    }

    if (type == BarcodeType.CALENDAR_EVENT) {
      return BarcodeCalendarEvent(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        status: json['status'] as String,
        summary: json['summary'] as String,
        description: json['description'] as String,
        location: json['location'] as String,
        start: json['start'] as String,
        end: json['end'] as String,
        organizer: json['organizer'] as String,
      );
    }

    if (type == BarcodeType.CONTACT_INFO) {
      return BarcodeContactInfo(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        title: json['title'] as String,
        name: json['name'] as String,
        organization: json['organization'] as String,
        emails: json['emails'] as String,
        phones: json['phones'] as String,
        addresses: json['addresses'] as String,
        urls: json['urls'] as String,
      );
    }
    if (type == BarcodeType.DRIVER_LICENSE) {
      return BarcodeDriverLicense(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        documentType: json['documentType'] as String,
        licenseNumber: json['licenseNumber'] as String,
        firstName: json['firstName'] as String,
        middleName: json['middleName'] as String,
        lastName: json['lastName'] as String,
        gender: json['gender'] as String,
        birthDate: json['birthDate'] as String,
        street: json['street'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
        zip: json['zip'] as String,
        issueDate: json['issueDate'] as String,
        expiryDate: json['expiryDate'] as String,
        issuingCountry: json['issuingCountry'] as String,
      );
    }

    if (type == BarcodeType.GEO) {
      return BarcodeGeo(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
      );
    }

    if (type == BarcodeType.ISBN) {
      return BarcodeISBN(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
      );
    }

    if (type == BarcodeType.PRODUCT) {
      return BarcodeProduct(
        value: value,
        boundingBox: boundingBox,
        corners: corners,
      );
    }

    return Barcode(
      type: type,
      value: value,
      boundingBox: boundingBox,
      corners: corners,
    );
  }
}

class BarcodeText extends Barcode {
  final String? displayValue;

  BarcodeText({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.displayValue,
  }) : super(
          type: BarcodeType.TEXT,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeUrl extends Barcode {
  final String? title;
  final String? url;

  BarcodeUrl({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.title,
    this.url,
  }) : super(
          type: BarcodeType.URL,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeSms extends Barcode {
  final String? number;
  final String? message;

  BarcodeSms({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.number,
    this.message,
  }) : super(
          type: BarcodeType.SMS,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeWifi extends Barcode {
  final String? ssid;
  final String? password;
  final BarcodeWifiType? wifiType;

  BarcodeWifi({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.ssid,
    this.password,
    this.wifiType,
  }) : super(
          type: BarcodeType.WIFI,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeEmail extends Barcode {
  final String? address;
  final String? subject;
  final String? body;
  final BarcodeEmailType emailType;

  BarcodeEmail({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.address,
    this.subject,
    this.body,
    this.emailType = BarcodeEmailType.UNKNOWN,
  }) : super(
          type: BarcodeType.EMAIL,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodePhone extends Barcode {
  final String? number;
  final BarcodePhoneType? phoneType;

  BarcodePhone({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.number,
    this.phoneType,
  }) : super(
          type: BarcodeType.PHONE,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeCalendarEvent extends Barcode {
  final String? status;
  final String? summary;
  final String? description;
  final String? location;
  final String? start;
  final String? end;
  final String? organizer;

  BarcodeCalendarEvent({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.status,
    this.summary,
    this.description,
    this.location,
    this.start,
    this.end,
    this.organizer,
  }) : super(
          type: BarcodeType.CALENDAR_EVENT,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeContactInfo extends Barcode {
  final String? title;
  final String? name;
  final String? organization;
  final String? emails;
  final String? phones;
  final String? addresses;
  final String? urls;

  BarcodeContactInfo({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.title,
    this.name,
    this.organization,
    this.emails,
    this.phones,
    this.addresses,
    this.urls,
  }) : super(
          type: BarcodeType.CONTACT_INFO,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeDriverLicense extends Barcode {
  final String? documentType;
  final String? licenseNumber;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender;
  final String? birthDate;
  final String? street;
  final String? city;
  final String? state;
  final String? zip;
  final String? issueDate;
  final String? expiryDate;
  final String? issuingCountry;

  BarcodeDriverLicense({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.documentType,
    this.licenseNumber,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.birthDate,
    this.street,
    this.city,
    this.state,
    this.zip,
    this.issueDate,
    this.expiryDate,
    this.issuingCountry,
  }) : super(
          type: BarcodeType.DRIVER_LICENSE,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeGeo extends Barcode {
  final double? latitude;
  final double? longitude;

  BarcodeGeo({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
    this.latitude,
    this.longitude,
  }) : super(
          type: BarcodeType.GEO,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeISBN extends Barcode {
  BarcodeISBN({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
  }) : super(
          type: BarcodeType.ISBN,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}

class BarcodeProduct extends Barcode {
  BarcodeProduct({
    required String value,
    Rect? boundingBox,
    List<Offset> corners = const [],
  }) : super(
          type: BarcodeType.PRODUCT,
          value: value,
          boundingBox: boundingBox,
          corners: corners,
        );
}
