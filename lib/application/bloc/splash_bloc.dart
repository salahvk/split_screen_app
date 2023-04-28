import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/domain/device_layout_details/device_layout_details.dart';
import 'package:http/http.dart' as http;
import 'package:split_screen_app/domain/failures/main_failures.dart';
import 'package:split_screen_app/infrastructure/layout_details.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<FetchDeviceId>((event, emit) async {
      try {
        String? deviceId;
        emit(SplashLoading());
        await Future.delayed(const Duration(seconds: 3));

        deviceId = await PlatformDeviceId.getDeviceId;

        print(deviceId);
        Hive.box("device_id").put('id', deviceId ?? '');
        // Either<MainFailure, DeviceLayoutDetails> result =
        //     await LayoutImp().getLayoutDetails();
        final url = Uri.parse(ApiEndPoint.layoutDetails);
        final headers = {'Content-Type': 'application/json'};
        final response = await http.post(
          url,
          headers: headers,
        );

        //  log(response.data.toString());
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        if (jsonResponse["status"] == false) {
          await Future.delayed(const Duration(seconds: 3));
          emit(SplashLoaded(
              deviceId: deviceId, isDeviceReg: false, isNavToLogin: false));
        } else {
          await Future.delayed(const Duration(seconds: 3));
          final updatedTime =
              jsonResponse["device_details"]["layout_updated_at"];
          Hive.box("updated_at").put('time', updatedTime ?? '');
          Either<MainFailure, DeviceLayoutDetails> result =
              await LayoutImp().getLayoutDetails();
          DeviceLayoutDetails deviceDetailsModel =
              result.getOrElse(() => DeviceLayoutDetails());
          emit(SplashLoaded(
              deviceId: deviceId,
              isDeviceReg: true,
              deviceDetails: deviceDetailsModel));
        }

        // final deviceDetailsModel = result.getOrElse(() =>
        //     DeviceLayoutDetails()); // Use getOrElse() to handle failure case and provide a default value
        // print(result);
      } catch (_) {
        // deviceId = 'Failed to get deviceId.';
      }
    });

    on<FetchLayoutDetails>(
      (event, emit) async {
        try {
          Either<MainFailure, DeviceLayoutDetails> result =
              await LayoutImp().getLayoutDetails();
          DeviceLayoutDetails deviceDetailsModel =
              result.getOrElse(() => DeviceLayoutDetails());
          String? deviceId;
          deviceId = await PlatformDeviceId.getDeviceId;
          await Future.delayed(const Duration(seconds: 3));

          final url = Uri.parse(ApiEndPoint.layoutDetails);
          final headers = {'Content-Type': 'application/json'};
          final response = await http.post(
            url,
            headers: headers,
          );
//
          //  log(response.data.toString());
          var jsonResponse = jsonDecode(response.body);

          final updatedTime =
              jsonResponse["device_details"]["layout_updated_at"];
          Hive.box("updated_at").put('time', updatedTime ?? '');
          print(jsonResponse["status"]);
          if (jsonResponse["status"] == false) {
          } else {
            Either<MainFailure, DeviceLayoutDetails> result =
                await LayoutImp().getLayoutDetails();
            DeviceLayoutDetails deviceDetailsModel =
                result.getOrElse(() => DeviceLayoutDetails());
            emit(SplashLoaded(
                deviceId: deviceId,
                isDeviceReg: true,
                deviceDetails: deviceDetailsModel));
          }
//
          // emit(SplashLoaded(
          //     deviceDetails: deviceDetailsModel, deviceId: deviceId));
        } catch (_) {}
      },
    );
    on<FetchLayoutModify>((event, emit) async {
      String updatedAt = Hive.box("updated_at").get('time');

      print(updatedAt);
      log("_____________________");
      final url1 = "${ApiEndPoint.layoutDetails}&updated_time=$updatedAt";
      print(url1);
      final url = Uri.parse(url1);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.post(
        url,
        headers: headers,
      );
//
      //  log(response.data.toString());
      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse);
      if (jsonResponse["modify"] == true) {
        log("truuuuuuuuuuuuuuuuuuuuuuuuuuuu");
        Either<MainFailure, DeviceLayoutDetails> result =
            await LayoutImp().getLayoutDetails();
        DeviceLayoutDetails deviceDetailsModel =
            result.getOrElse(() => DeviceLayoutDetails());
        emit(SplashLoaded(
          deviceId: deviceId,
          isDeviceReg: true,
          deviceDetails: deviceDetailsModel,
        ));
        // await Future.delayed(const Duration(seconds: 3));
        final updatedTime = jsonResponse["device_details"]["layout_updated_at"];
        Hive.box("updated_at").put('time', updatedTime ?? '');
      }
      // print(jsonResponse["status"]);
      // if (jsonResponse["status"] == false) {
      // } else {}
    });
  }
}
