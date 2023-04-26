import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platform_device_id/platform_device_id.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<FetchDeviceId>((event, emit) async {
      try {
        String? deviceId;
        emit(SplashLoading());

        deviceId = await PlatformDeviceId.getDeviceId;

        print(deviceId);
        await Future.delayed(const Duration(seconds: 5));
        emit(SplashLoaded(deviceId: deviceId));
      } catch (_) {
        // deviceId = 'Failed to get deviceId.';
      }
    });
  }
}
