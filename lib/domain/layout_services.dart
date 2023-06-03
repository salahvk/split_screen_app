import 'package:dartz/dartz.dart';
import 'package:split_screen_app/domain/device_layout_details/device_layout.dart';

import 'package:split_screen_app/domain/failures/main_failures.dart';

abstract class LayoutServices {
  Future<Either<MainFailure, DeviceLayoutDetails>> getLayoutDetails();
}
