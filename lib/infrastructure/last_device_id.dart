import 'dart:convert';

import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:http/http.dart' as http;

Future<String> getLastDeviceId() async {
  final url = Uri.parse(ApiEndPoint.lastId);
  final headers = {'Content-Type': 'application/json'};
  final response = await http.post(
    url,
    headers: headers,
  );

  var jsonResponse = jsonDecode(response.body);
  return jsonResponse["last_device_id"].toString();
}
