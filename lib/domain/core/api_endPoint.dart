import 'package:hive/hive.dart';

// String endPoint = "http://192.168.29.44:8007";
// String endPoint = "https://projects.techoriz.in/digitalsignature/public";
// String endPoint = "https://oxicodes.in/digitalarts.com/demo/public";
String endPoint = "https://alphasignage.online";

String api = "$endPoint/api";
String deviceId = Hive.box("device_id").get('id');

class ApiEndPoint {
  static String layoutDetails = "$api/device/detail?device_id=$deviceId";
  static String lastId = "$api/last-device-id";
  static String layoutModify = "$api/layout/modify?layout_id=";
}
