import 'package:split_screen_app/core/controllers/controllers.dart';
import 'package:split_screen_app/core/utils/change_url.dart';
import 'package:split_screen_app/domain/core/api_endPoint.dart';
import 'package:split_screen_app/domain/device_layout_details/device_layout.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

setControllers(DeviceLayoutDetails deviceDetailsModel) async {
  // List urls = [];
  // String? url;
  // for (var i = 0;
  //     i < deviceDetailsModel.deviceDetails!.elements!.toInt();
  //     i++) {
  //   if (deviceDetailsModel.media?[i].type != "image") {
  //     url = deviceDetailsModel.media?[i].type == "video"
  //         ? "$endPoint${deviceDetailsModel.media?[i].file}"
  //         : deviceDetailsModel.media?[i].file;
  //     if (deviceDetailsModel.media?[i].type == "youtube") {
  //       url = await getVideoUrl(url);
  //     }
  //   }
  //   urls.add(url);
  // }

  // print(urls);
  String? url1;
  String? url2;
  String? url3;
  String? url4;
  if (deviceDetailsModel.media?[0].type != "image") {
    url1 = deviceDetailsModel.media?[0].type == "video"
        ? "$endPoint${deviceDetailsModel.media?[0].file}"
        : deviceDetailsModel.media?[0].file;
    if (deviceDetailsModel.media?[0].type == "video") {
      controller = VideoPlayerController.network(
        url1 ?? '',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      controller?.addListener(() {
        // setState(() {});
      });
      controller?.setLooping(true);
      controller?.initialize();
      controller?.play();
    } else if (deviceDetailsModel.media?[0].type == "youtube") {
      ytController = YoutubePlayerController(
        params: const YoutubePlayerParams(
            mute: false,
            showControls: true,
            showFullscreenButton: true,
            loop: true),
      );

      ytController?.loadVideoById(videoId: url1 ?? ''); // Auto Play
      // var logger = Logger();
      // logger.d("___________________________________");
      print("video playing");

      // Hive.box("device_id").put('url', url1);
    }
  }
  if (deviceDetailsModel.deviceDetails!.elements! > 1) {
    if (deviceDetailsModel.media?[1].type != "image") {
      url2 = deviceDetailsModel.media?[1].type == "video"
          ? "$endPoint${deviceDetailsModel.media?[1].file}"
          : deviceDetailsModel.media?[1].file;
      if (deviceDetailsModel.media?[1].type == "youtube") {
        url2 = await getVideoUrl(url2);
      }
      controller2 = VideoPlayerController.network(
        url2 ?? '',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      controller2?.addListener(() {});
      controller2?.setLooping(true);
      controller2?.initialize();
      controller2?.play();
    }
  }

  if (deviceDetailsModel.deviceDetails!.elements! > 2) {
    if (deviceDetailsModel.media?[2].type != "image") {
      url3 = deviceDetailsModel.media?[2].type == "video"
          ? "$endPoint${deviceDetailsModel.media?[2].file}"
          : deviceDetailsModel.media?[2].file;
      if (deviceDetailsModel.media?[2].type == "youtube") {
        url3 = await getVideoUrl(url3);
      }

      controller3 = VideoPlayerController.network(
        url3 ?? '',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      controller3?.addListener(() {
        // setState(() {});
      });
      controller3?.setLooping(true);
      controller3?.initialize();
      controller3?.play();
    }
  }

  if (deviceDetailsModel.deviceDetails!.elements! > 3) {
    if (deviceDetailsModel.media?[3].type != "image") {
      url4 = deviceDetailsModel.media?[3].type == "video"
          ? "$endPoint${deviceDetailsModel.media?[3].file}"
          : deviceDetailsModel.media?[3].file;
      if (deviceDetailsModel.media?[3].type == "youtube") {
        url4 = await getVideoUrl(url4);
      }
      controller4 = VideoPlayerController.network(
        url4 ?? '',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      controller4?.addListener(() {
        // setState(() {});
      });
      controller4?.setLooping(true);
      controller4?.initialize();
      controller4?.play();
    }
  }
}
