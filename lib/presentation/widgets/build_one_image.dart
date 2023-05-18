import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';

Widget buildOneImage(size, state, index, height) {
  return Expanded(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: CachedNetworkImage(
        imageUrl: "$endPoint${state.deviceDetails?.media?[index].file}",
        fit: BoxFit.cover,
        width: size.width,
        height: height,
      ),
    ),
  );
}
