class DeviceDetails {
  String? name;
  String? deviceId;
  int? layoutId;
  String? layoutName;
  String? orientation;
  int? elements;
  String? mediaIds;

  DeviceDetails({
    this.name,
    this.deviceId,
    this.layoutId,
    this.layoutName,
    this.orientation,
    this.elements,
    this.mediaIds,
  });

  factory DeviceDetails.fromJson(Map<String, dynamic> json) => DeviceDetails(
        name: json['name'] as String?,
        deviceId: json['device_id'] as String?,
        layoutId: json['layout_id'] as int?,
        layoutName: json['layout_name'] as String?,
        orientation: json['orientation'] as String?,
        elements: json['elements'] as int?,
        mediaIds: json['media_ids'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'device_id': deviceId,
        'layout_id': layoutId,
        'layout_name': layoutName,
        'orientation': orientation,
        'elements': elements,
        'media_ids': mediaIds,
      };
}
