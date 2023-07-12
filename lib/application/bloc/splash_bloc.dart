import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:split_screen_app/core/utils/set_controllers.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:http/http.dart' as http;
import 'package:split_screen_app/domain/device_layout_details/device_layout.dart';
import 'package:split_screen_app/domain/failures/main_failures.dart';
import 'package:split_screen_app/infrastructure/layout_details.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<FetchDeviceId>((event, emit) async {
      try {
        String? deviceId;

        // await Future.delayed(const Duration(seconds: 1));

        try {
          deviceId = await PlatformDeviceId.getDeviceId;
          await Hive.box("device_id").put('id', deviceId);
          print(deviceId);
        } on PlatformException {
          // deviceId = await getLastDeviceId();
          // Hive.box("device_id").put('id', deviceId);
        }

        Either<MainFailure, DeviceLayoutDetails> result =
            await LayoutImp().getLayoutDetails();

        await result.fold((falure) {
          emit(SplashLoading(error: falure));
        }, (success) async {
          final deviceDetailsModel =
              result.getOrElse(() => DeviceLayoutDetails());
          if (deviceDetailsModel.status == false) {
            await Future.delayed(const Duration(seconds: 3));
            emit(SplashLoaded(
                deviceId: deviceId,
                isDeviceReg: false,
                isNavToLogin: false,
                message: deviceDetailsModel.message));
          } else {
            await Future.delayed(const Duration(seconds: 3));
            final updatedTime =
                deviceDetailsModel.deviceDetails?.layoutUpdatedAt;
            Hive.box("updated_at").put('time', updatedTime ?? '');
            print("object");
            await setControllers(deviceDetailsModel);

            emit(SplashLoaded(
                deviceId: deviceId,
                isDeviceReg: true,
                deviceDetails: deviceDetailsModel));
          }
        });
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
          try {
            deviceId = await PlatformDeviceId.getDeviceId;

            await Hive.box("device_id").put('id', deviceId);
          } on PlatformException {
            // deviceId = await getLastDeviceId();
            // Hive.box("device_id").put('id', deviceId);
          }

          await Future.delayed(const Duration(seconds: 3));

          final updatedTime = deviceDetailsModel.deviceDetails?.layoutUpdatedAt;
          Hive.box("updated_at").put('time', updatedTime ?? '');

          if (deviceDetailsModel.status == false) {
          } else {
            await setControllers(deviceDetailsModel);
            emit(SplashLoaded(
                deviceId: deviceId,
                isDeviceReg: true,
                deviceDetails: deviceDetailsModel));
          }
        } catch (_) {}
      },
    );
    on<FetchLayoutModify>((event, emit) async {
      String deviceId = Hive.box("device_id").get('id');
      String updatedAt = Hive.box("updated_at").get('time');
      final url1 = "${ApiEndPoint.layoutDetails}&updated_time=$updatedAt";
      final url = Uri.parse(url1);
      final headers = {'Content-Type': 'application/json'};
      final response = await http.post(
        url,
        headers: headers,
      );
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (jsonResponse["status"] == false) {
        emit(SplashLoaded(
            deviceId: deviceId, isDeviceReg: false, isScreenRef: false));
      }
      if (jsonResponse["modify"] == true) {
        try {
          ytController?.close();
        } catch (_) {}

        controller?.dispose();
        controller2?.dispose();
        controller3?.dispose();
        controller4?.dispose();
        Either<MainFailure, DeviceLayoutDetails> result =
            await LayoutImp().getLayoutDetails();
        DeviceLayoutDetails deviceDetailsModel =
            result.getOrElse(() => DeviceLayoutDetails());

        await setControllers(deviceDetailsModel);
        print("Controllers initialised");
        // print(ytController);
        emit(SplashLoaded(
            deviceId: deviceId,
            isDeviceReg: true,
            deviceDetails: deviceDetailsModel,
            isScreenRef: true));

        final updatedTime = jsonResponse["device_details"]["layout_updated_at"];
        Hive.box("updated_at").put('time', updatedTime ?? '');
      }
    });
  }
}
