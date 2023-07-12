part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {
  MainFailure? error;
  SplashLoading({this.error});
}

class SplashLoaded extends SplashState {
  String? deviceId;
  String? message;
  bool? isDeviceReg;
  bool? isNavToLogin;
  bool? isScreenRef;

  DeviceLayoutDetails? deviceDetails;
  SplashLoaded(
      {this.deviceId,
      this.message,
      this.isDeviceReg,
      this.deviceDetails,
      this.isNavToLogin,
      this.isScreenRef});
}


// class LayoutLoading extends SplashState {}

// class LayoutLoaded extends SplashState {
//   String? deviceId;
//   bool? isDeviceReg;
//   DeviceLayoutDetails? deviceDetails;

//   LayoutLoaded({this.deviceId, this.deviceDetails});
// }
