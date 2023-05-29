class DeviceLayoutDetails {
  bool? status;
  String? message;
  DeviceDetails? deviceDetails;
  List<Media>? media;
  bool? modify;

  DeviceLayoutDetails(
      {this.status, this.message, this.deviceDetails, this.media, this.modify});

  DeviceLayoutDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    deviceDetails = json['device_details'] != null
        ? DeviceDetails.fromJson(json['device_details'])
        : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    modify = json['modify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (deviceDetails != null) {
      data['device_details'] = deviceDetails!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    data['modify'] = modify;
    return data;
  }
}

class DeviceDetails {
  String? name;
  String? deviceId;
  int? layoutId;
  String? layoutName;
  String? orientation;
  int? elements;
  String? mediaIds;
  int? componyId;
  String? status;
  String? layoutUpdatedAt;
  String? defaultImage;
  var expiryDate;

  DeviceDetails(
      {this.name,
      this.deviceId,
      this.layoutId,
      this.layoutName,
      this.orientation,
      this.elements,
      this.mediaIds,
      this.componyId,
      this.status,
      this.layoutUpdatedAt,
      this.defaultImage,
      this.expiryDate});

  DeviceDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    deviceId = json['device_id'];
    layoutId = json['layout_id'];
    layoutName = json['layout_name'];
    orientation = json['orientation'];
    elements = json['elements'];
    mediaIds = json['media_ids'];
    componyId = json['compony_id'];
    status = json['status'];
    layoutUpdatedAt = json['layout_updated_at'];
    defaultImage = json['default_image'];
    expiryDate = json['expiry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['device_id'] = deviceId;
    data['layout_id'] = layoutId;
    data['layout_name'] = layoutName;
    data['orientation'] = orientation;
    data['elements'] = elements;
    data['media_ids'] = mediaIds;
    data['compony_id'] = componyId;
    data['status'] = status;
    data['layout_updated_at'] = layoutUpdatedAt;
    data['default_image'] = defaultImage;
    data['expiry_date'] = expiryDate;
    return data;
  }
}

class Media {
  int? id;
  String? title;
  String? type;
  int? timeInterval;
  String? file;
  var thumbnail;
  var animation;
  List<String>? carouselImages;

  Media(
      {this.id,
      this.title,
      this.type,
      this.timeInterval,
      this.file,
      this.animation,
      this.thumbnail,
      this.carouselImages});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    timeInterval = json['time_interval'];
    file = json['file'];
    animation = json['animation'];
    thumbnail = json['thumbnail'];
    carouselImages = json['carousel_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['time_interval'] = timeInterval;
    data['animation'] = animation;
    data['file'] = file;
    data['thumbnail'] = thumbnail;
    data['carousel_images'] = carouselImages;
    return data;
  }
}
