import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'dart:io';
import 'package:injectable/injectable.dart';

import 'package:http/http.dart' as http;
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/domain/device_layout_details/device_layout.dart';

import 'package:split_screen_app/domain/failures/main_failures.dart';
import 'package:split_screen_app/domain/layout_services.dart';

@LazySingleton(as: LayoutServices)
class LayoutImp implements LayoutServices {
  @override
  Future<Either<MainFailure, DeviceLayoutDetails>> getLayoutDetails() async {
    try {
      final httpClient = HttpClient();
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final url = Uri.parse(ApiEndPoint.layoutDetails);
      final request = await httpClient.postUrl(url);
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      HttpOverrides.global = CustomHttpOverrides();

      httpClient.close();

      var jsonResponse = jsonDecode(responseBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = DeviceLayoutDetails.fromJson(jsonResponse);
        log(responseBody);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on Error catch (e) {
      log(e.toString());
      if (e is http.ClientException) {
        return const Left(MainFailure.clientFailure());
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
