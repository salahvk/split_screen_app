part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  String? deviceId;
  bool? isDeviceReg;
  bool? isNavToLogin;

  DeviceLayoutDetails? deviceDetails;
  SplashLoaded({
    this.deviceId,
    this.isDeviceReg,
    this.deviceDetails,
    this.isNavToLogin,
  });
}

// class LayoutLoading extends SplashState {}

// class LayoutLoaded extends SplashState {
//   String? deviceId;
//   bool? isDeviceReg;
//   DeviceLayoutDetails? deviceDetails;

//   LayoutLoaded({this.deviceId, this.deviceDetails});
// }
