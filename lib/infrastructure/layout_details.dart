import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import 'package:http/http.dart' as http;
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/domain/device_layout_details/device_layout_details.dart';
import 'package:split_screen_app/domain/failures/main_failures.dart';
import 'package:split_screen_app/domain/layout_services.dart';

@LazySingleton(as: LayoutServices)
class LayoutImp implements LayoutServices {
  @override
  Future<Either<MainFailure, DeviceLayoutDetails>> getLayoutDetails() async {
    try {
      final url = Uri.parse(ApiEndPoint.layoutDetails);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.post(
        url,
        headers: headers,
      );

      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = DeviceLayoutDetails.fromJson(jsonResponse);
        log(response.body);
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
