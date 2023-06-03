import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:split_screen_app/core/utils/show_animated.dart';

class ErrorScreen extends StatefulWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        String? deviceId;
        Hive.box("device_id").put('id', deviceId);
        deviceId = Hive.box("device_id").get('id');
      } catch (c) {
        showAnimatedSnackBar(
          context,
          "Hive never work $c",
        );
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.error),
      ),
    );
  }
}
