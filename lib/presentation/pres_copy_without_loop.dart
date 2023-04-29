// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:split_screen_app/application/bloc/splash_bloc.dart';
// import 'package:split_screen_app/core/utils/change_url.dart';
// import 'package:split_screen_app/domain/core/api_endPoint.dart';
// import 'package:split_screen_app/presentation/widgets/screens/four_screens.dart';
// import 'package:split_screen_app/presentation/widgets/screens/one_screen.dart';
// import 'package:split_screen_app/presentation/widgets/screens/three_screens.dart';
// import 'package:split_screen_app/presentation/widgets/screens/two_screens.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class ImageScreen extends StatefulWidget {
//   const ImageScreen({super.key});

//   @override
//   State<ImageScreen> createState() => _ImageScreenState();
// }

// class _ImageScreenState extends State<ImageScreen> {
//   VlcPlayerController? controller;
//   VlcPlayerController? controller2;
//   VlcPlayerController? controller3;
//   VlcPlayerController? controller4;
//   Timer? timer;
//   late YoutubePlayerController ytcontroller;
//   // late YoutubePlayerController ytcontroller2;
//   // late YoutubePlayerController ytcontroller3;
//   // late YoutubePlayerController ytcontroller4;
//   late PlayerState _playerState;
//   late YoutubeMetaData _videoMetaData;
//   String? url1;
//   String? url2;
//   String? url3;
//   String? url4;
//   final bool _isPlayerReady = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       final myBlocState = context.read<SplashBloc>().state;
//       if (myBlocState is SplashLoaded) {
//         log("++++++++++++++++");
//         if (myBlocState.deviceDetails?.media?[0].type != "image") {
//           url1 = myBlocState.deviceDetails?.media?[0].type == "video"
//               ? "$endPoint${myBlocState.deviceDetails?.media?[0].file}"
//               : myBlocState.deviceDetails?.media?[0].file;
//           if (myBlocState.deviceDetails?.media?[0].type == "video") {
//             // controller = WebViewController()
//             //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//             //   ..setBackgroundColor(Colors.white)
//             //   ..loadRequest(Uri.parse(url1 ?? ''));

//             controller = VlcPlayerController.network(
//               url1 ?? '',
//               hwAcc: HwAcc.full,
//               autoPlay: true,
//               options: VlcPlayerOptions(
//                 advanced: VlcAdvancedOptions([
//                   VlcAdvancedOptions.networkCaching(2000),
//                 ]),
//                 http: VlcHttpOptions([
//                   VlcHttpOptions.httpReconnect(true),
//                 ]),
//                 rtp: VlcRtpOptions([
//                   VlcRtpOptions.rtpOverRtsp(true),
//                 ]),
//               ),
//             );
//             controller?.addListener(() {
//               if (controller?.value.playingState == PlayingState.ended) {
//                 // if video has ended
//                 controller?.stop().then(
//                       (_) => controller?.play(),
//                     ); // stop (reset) the video and play again after stop completed
//               }
//             });
//           } else if (myBlocState.deviceDetails?.media?[0].type == "youtube") {
//             print("___________");
//             ytcontroller = YoutubePlayerController(
//               initialVideoId: url1 ?? '',
//               flags: const YoutubePlayerFlags(
//                 mute: false,
//                 autoPlay: true,
//                 disableDragSeek: false,
//                 loop: true,
//                 isLive: false,
//                 forceHD: false,
//                 enableCaption: true,
//               ),
//             )..addListener(listener);
//             print(ytcontroller);
//             log("iniiiiiiiiiiiiiiiiiiiiiiii");
//           }
//         }
//         if (myBlocState.deviceDetails!.deviceDetails!.elements! > 1) {
//           if (myBlocState.deviceDetails?.media?[1].type != "image") {
//             url2 = myBlocState.deviceDetails?.media?[1].type == "video"
//                 ? "$endPoint${myBlocState.deviceDetails?.media?[1].file}"
//                 : myBlocState.deviceDetails?.media?[1].file;
//             if (myBlocState.deviceDetails?.media?[1].type == "youtube") {
//               url2 = await getVideoUrl(url2);
//             }

//             if (myBlocState.deviceDetails?.media?[1].type != "image") {
//               controller2 = VlcPlayerController.network(
//                 url2 ?? '',
//                 hwAcc: HwAcc.full,
//                 autoPlay: true,
//                 options: VlcPlayerOptions(
//                   advanced: VlcAdvancedOptions([
//                     VlcAdvancedOptions.networkCaching(2000),
//                   ]),
//                   http: VlcHttpOptions([
//                     VlcHttpOptions.httpReconnect(true),
//                   ]),
//                   rtp: VlcRtpOptions([
//                     VlcRtpOptions.rtpOverRtsp(true),
//                   ]),
//                 ),
//               );
//               controller2?.addListener(() {
//                 if (controller2?.value.playingState == PlayingState.ended) {
//                   // if video has ended
//                   controller2?.stop().then(
//                         (_) => controller2?.play(),
//                       ); // stop (reset) the video and play again after stop completed
//                 }
//               });
//             }
//           }
//         }

//         if (myBlocState.deviceDetails!.deviceDetails!.elements! > 2) {
//           if (myBlocState.deviceDetails?.media?[2].type != "image") {
//             url3 = myBlocState.deviceDetails?.media?[2].type == "video"
//                 ? "$endPoint${myBlocState.deviceDetails?.media?[2].file}"
//                 : myBlocState.deviceDetails?.media?[2].file;
//             if (myBlocState.deviceDetails?.media?[2].type == "video") {
//               controller3 = VlcPlayerController.network(
//                 url3 ?? '',
//                 hwAcc: HwAcc.full,
//                 autoPlay: true,
//                 options: VlcPlayerOptions(
//                   advanced: VlcAdvancedOptions([
//                     VlcAdvancedOptions.networkCaching(2000),
//                   ]),
//                   http: VlcHttpOptions([
//                     VlcHttpOptions.httpReconnect(true),
//                   ]),
//                   rtp: VlcRtpOptions([
//                     VlcRtpOptions.rtpOverRtsp(true),
//                   ]),
//                 ),
//               );
//               controller3?.addListener(() {
//                 if (controller3?.value.playingState == PlayingState.ended) {
//                   // if video has ended
//                   controller3?.stop().then(
//                         (_) => controller3?.play(),
//                       ); // stop (reset) the video and play again after stop completed
//                 }
//               });
//             }
//           }
//         }

//         if (myBlocState.deviceDetails!.deviceDetails!.elements! > 3) {
//           log("message");
//           if (myBlocState.deviceDetails?.media?[3].type != "image") {
//             url4 = myBlocState.deviceDetails?.media?[3].type == "video"
//                 ? "$endPoint${myBlocState.deviceDetails?.media?[3].file}"
//                 : myBlocState.deviceDetails?.media?[3].file;
//             if (myBlocState.deviceDetails?.media?[3].type == "video") {
//               controller4 = VlcPlayerController.network(
//                 url4 ?? '',
//                 hwAcc: HwAcc.full,
//                 autoPlay: true,
//                 options: VlcPlayerOptions(
//                   advanced: VlcAdvancedOptions([
//                     VlcAdvancedOptions.networkCaching(2000),
//                   ]),
//                   http: VlcHttpOptions([
//                     VlcHttpOptions.httpReconnect(true),
//                   ]),
//                   rtp: VlcRtpOptions([
//                     VlcRtpOptions.rtpOverRtsp(true),
//                   ]),
//                 ),
//               );
//               controller4?.addListener(() {
//                 if (controller4?.value.playingState == PlayingState.ended) {
//                   // if video has ended
//                   controller4?.stop().then(
//                         (_) => controller4?.play(),
//                       ); // stop (reset) the video and play again after stop completed
//                 }
//               });
//             }
//           }
//         }

//         // Do something with these values

//         _videoMetaData = const YoutubeMetaData();
//         _playerState = PlayerState.unknown;

//         // ytcontroller2 = YoutubePlayerController(
//         //   initialVideoId: url2 ?? '',
//         //   flags: const YoutubePlayerFlags(
//         //     mute: false,
//         //     autoPlay: true,
//         //     disableDragSeek: false,
//         //     loop: true,
//         //     isLive: false,
//         //     forceHD: false,
//         //     enableCaption: true,
//         //   ),
//         // )..addListener(listener);

//         // _videoMetaData = const YoutubeMetaData();
//         // _playerState = PlayerState.unknown;

//         // ytcontroller3 = YoutubePlayerController(
//         //   initialVideoId: url3 ?? '',
//         //   flags: const YoutubePlayerFlags(
//         //     mute: false,
//         //     autoPlay: true,
//         //     disableDragSeek: false,
//         //     loop: true,
//         //     isLive: false,
//         //     forceHD: false,
//         //     enableCaption: true,
//         //   ),
//         // )..addListener(listener);

//         // _videoMetaData = const YoutubeMetaData();
//         // _playerState = PlayerState.unknown;

//         // ytcontroller4 = YoutubePlayerController(
//         //   initialVideoId: url4 ?? '',
//         //   flags: const YoutubePlayerFlags(
//         //     mute: false,
//         //     autoPlay: true,
//         //     disableDragSeek: false,
//         //     loop: true,
//         //     isLive: false,
//         //     forceHD: false,
//         //     enableCaption: true,
//         //   ),
//         // )..addListener(listener);
//         // log(url2 ?? '');

//         _videoMetaData = const YoutubeMetaData();
//         _playerState = PlayerState.unknown;
//       }
//       setState(() {});

//       timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//         BlocProvider.of<SplashBloc>(context).add(
//           FetchLayoutModify(),
//         );

//         print("Timer");
//       });
//     });
//   }

//   void listener() {
//     if (_isPlayerReady && mounted && !ytcontroller.value.isFullScreen) {
//       setState(() {
//         _playerState = ytcontroller.value.playerState;
//         _videoMetaData = ytcontroller.metadata;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     ytcontroller.dispose();
//     // ytcontroller2.dispose();
//     // ytcontroller3.dispose();
//     // ytcontroller4.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return BlocConsumer<SplashBloc, SplashState>(
//       listener: (context, state) {
//         if (state is SplashLoaded && state.isScreenRef == true) {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
//             return const ImageScreen();
//           }));
//         }
//       },
//       builder: (context, state) {
//         if (state is SplashLoaded) {
//           final eleCou = state.deviceDetails?.deviceDetails?.elements;

//           if (eleCou == 4) {
//             return buildFourScreens(
//               context,
//               state,
//               controller,
//               controller2,
//               controller3,
//               controller4,
//               ytcontroller,
//               // ytcontroller2,
//               // ytcontroller3,
//               // ytcontroller4
//             );
//           } else if (eleCou == 3) {
//             return buildThreeScreens(
//               context,
//               state,
//               controller,
//               controller2,
//               controller3,
//               ytcontroller,
//             );
//           } else if (eleCou == 2) {
//             return buildTwoScreens(
//               context,
//               state,
//               controller,
//               controller2,
//               ytcontroller,
//             );
//           } else if (eleCou == 1) {
//             return buildOneScreen(
//               context,
//               state,
//               controller,
//               ytcontroller,
//             );
//           }
//           return buildImage(context);
//         }
//         return Container();
//       },
//     );
//   }
// }

// Widget buildImage(BuildContext context) {
//   final size = MediaQuery.of(context).size;
//   return Scaffold(
//     body: Image.asset(
//       'assets/image.png',
//       fit: BoxFit.fitWidth,
//       width: size.width,
//       height: size.height,
//     ),
//   );
// }

// // Widget buildFourScreens(BuildContext context, LayoutLoaded state, controller) {
// //   final size = MediaQuery.of(context).size;
// //   return Scaffold(
// //     backgroundColor: Colors.black,
// //     body: SafeArea(
// //       child: GridView.builder(
// //           padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
// //           // shrinkWrap: true,
// //           // physics: const NeverScrollableScrollPhysics(),
// //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
// //               maxCrossAxisExtent: 530,
// //               // childAspectRatio: 2 / 3,
// //               crossAxisSpacing: 5,
// //               mainAxisExtent: size.height * .4,
// //               mainAxisSpacing: 5),
// //           itemCount: 4,
// //           itemBuilder: (BuildContext ctx, index) {
// //             return InkWell(
// //               child: Container(
// //                   alignment: Alignment.center,
// //                   decoration: BoxDecoration(

// //                       // color: ColorManager.whiteColor,
// //                       borderRadius: BorderRadius.circular(5)),
// //                   child:
// //                       //  state.deviceDetails?.media?[index].type == 'youtube'?
// //                       buildvideo(context, size, controller)
// //                   //     : state.deviceDetails?.media?[index].type == 'image'
// //                   //         ? buildOneImage(size, state)
// //                   //         : Container(),
// //                   ),
// //             );
// //           }),
// //     ),
// //   );
// // }

// Widget buildOneImage(size, state, index, height) {
//   return Expanded(
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(14),
//       child: Image.network(
//         "$endPoint${state.deviceDetails?.media?[index].file}",
//         fit: BoxFit.contain,
//         width: size.width,
//         height: height,
//       ),
//     ),
//   );
// }

// Widget buildYtbvideo(
//     BuildContext context, size, YoutubePlayerController ytcontroller, height) {
//   return Expanded(
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(14),
//       child: Container(
//         height: height,
//         width: size.width,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//         child: YoutubePlayer(
//           controller: ytcontroller,
//           showVideoProgressIndicator: true,
//           // videoProgressIndicatorColor: Colors.amber,
//           progressColors: const ProgressBarColors(
//             playedColor: Colors.amber,
//             handleColor: Colors.amberAccent,
//           ),
//           // onReady: () {
//           //   _isPlayerReady = true;
//           // },
//         ),
//       ),
//     ),
//   );
// }

// // Widget buildYtbvideo2(BuildContext context, size, ytcontroller, height) {
// //   return Expanded(
// //     child: ClipRRect(
// //       borderRadius: BorderRadius.circular(14),
// //       child: Container(
// //         height: height,
// //         width: size.width,
// //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
// //         child: YoutubePlayer(
// //           controller: ytcontroller,
// //           showVideoProgressIndicator: true,
// //           // videoProgressIndicatorColor: Colors.amber,
// //           progressColors: const ProgressBarColors(
// //             playedColor: Color.fromARGB(255, 0, 0, 0),
// //             handleColor: Color.fromARGB(255, 66, 55, 13),
// //           ),
// //           // onReady: () {
// //           //   _isPlayerReady = true;
// //           // },
// //         ),
// //       ),
// //     ),
// //   );
// // }
