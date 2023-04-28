import 'device_details.dart';
import 'media.dart';

class DeviceLayoutDetails {
  bool? result;
  String? message;
  DeviceDetails? deviceDetails;
  List<Media>? media;

  DeviceLayoutDetails({
    this.result,
    this.message,
    this.deviceDetails,
    this.media,
  });

  factory DeviceLayoutDetails.fromJson(Map<String, dynamic> json) {
    return DeviceLayoutDetails(
      result: json['result'] as bool?,
      message: json['message'] as String?,
      deviceDetails: json['device_details'] == null
          ? null
          : DeviceDetails.fromJson(
              json['device_details'] as Map<String, dynamic>),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'result': result,
        'message': message,
        'device_details': deviceDetails?.toJson(),
        'media': media?.map((e) => e.toJson()).toList(),
      };
}
