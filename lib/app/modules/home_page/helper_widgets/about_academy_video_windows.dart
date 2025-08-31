// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:media_kit/media_kit.dart';
// import 'package:media_kit_video/media_kit_video.dart';

// class AboutAcademyVideoWindows extends StatefulWidget {
//   const AboutAcademyVideoWindows({super.key, required this.url});

//   final String url;

//   @override
//   State<AboutAcademyVideoWindows> createState() =>
//       _AboutAcademyVideoWindowsState();
// }

// class _AboutAcademyVideoWindowsState extends State<AboutAcademyVideoWindows> {
//   late final Player player;
//   late final VideoController videoController;

//   @override
//   void initState() {
//     super.initState();
//     player = Player();
//     videoController = VideoController(player);
//     player.open(Media(widget.url), play: false);
//   }

//   @override
//   void dispose() {
//     //videoController.dispose();
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     log(widget.url);
//     return AspectRatio(
//       aspectRatio: 12 / 9,
//       child: Video(
//         controller: videoController,
//       ),
//     );
//   }
// }
