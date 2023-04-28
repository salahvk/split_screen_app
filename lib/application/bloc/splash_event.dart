part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {}

class FetchDeviceId extends SplashEvent {}

class FetchLayoutDetails extends SplashEvent {}

class FetchLayoutModify extends SplashEvent {}
