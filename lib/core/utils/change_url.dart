// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// Future<String> getVideoUrl(url) async {
//   var yt = YoutubeExplode();
//   var manifest = await yt.videos.streamsClient.getManifest(url);
//   String videoUrl;
//   // var s = manifest.videoOnly.getAllVideoQualitiesLabel();
//   // var s1 = manifest.videoOnly.getAllVideoQualities();
//   // if(manifest.videoOnly.getAllVideoQualities().contains(VideoQuality.high1080)){

//   // }

//   if (manifest.videoOnly
//       .getAllVideoQualities()
//       .contains(VideoQuality.high720)) {
//     var video = manifest.videoOnly.firstWhere(
//       (stream) => stream.videoQuality == VideoQuality.high720,
//     );
//     videoUrl = video.url.toString();
//   } else {
//     videoUrl = manifest.videoOnly.last.url.toString();
//   }
//   // var s2 = manifest.videoOnly.bestQuality;
//   // print("________________");
//   // print(s1.contains(VideoQuality.high1080));
//   // print(s2.videoQuality);
//   // print(s);
//   // var videog = manifest.videoOnly.sortByVideoQuality();
//   // var video = manifest.videoOnly.sortByVideoQuality().firstWhere((stream) {
//   //   final s = stream.videoQuality;
//   //   print(s);
//   //   return true;
//   // });
//   // print("object");
//   // print(video.url.toString());
//   print(videoUrl);
//   return videoUrl;
// }
