// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:step/app/core/themes/colors.dart';
// import 'package:step/app/modules/home/main_app_controller.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BuildSpeedDialSocialMedia extends StatelessWidget {
//   const BuildSpeedDialSocialMedia({
//     super.key,
//     required this.controller,
//   });

//   final MainAppController controller;

//   @override
//   Widget build(BuildContext context) {
//     return SpeedDial(
//       animatedIcon: AnimatedIcons.menu_close,
//       backgroundColor: kPrimary1Color,
//       overlayColor: Colors.black,
//       overlayOpacity: 0.5,
//       children: controller.socialMediaModel != null
//           ? [
//               if (controller.socialMediaModel!.cocoonWhatsappUrl != null &&
//                   controller.socialMediaModel!.cocoonWhatsappUrl!.isNotEmpty)
//                 speedDialChild(
//                     image: "https://almansy.net/service_images/whatsicon.png",
//                     onTap: () {
//                       launchUrl(
//                         Uri.parse(
//                           "https://wa.me/${controller.socialMediaModel!.cocoonWhatsappUrl}?text=Hello! I have a question.",
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       );
//                     }),
//               if (controller.socialMediaModel!.cocoonFacebookUrl != null &&
//                   controller.socialMediaModel!.cocoonFacebookUrl!.isNotEmpty)
//                 speedDialChild(
//                     image: "https://almansy.net/service_images/fbicon.png",
//                     onTap: () {
//                       launchUrl(
//                         Uri.parse(
//                           controller.socialMediaModel!.cocoonFacebookUrl!,
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       );
//                     }),
//               if (controller.socialMediaModel!.cocoonInstagramUrl != null &&
//                   controller.socialMediaModel!.cocoonInstagramUrl!.isNotEmpty)
//                 speedDialChild(
//                     image: "https://almansy.net/service_images/instgicon.png",
//                     onTap: () {
//                       launchUrl(
//                         Uri.parse(
//                           controller.socialMediaModel!.cocoonInstagramUrl!,
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       );
//                     }),
//               if (controller.socialMediaModel!.cocoonYoutubeUrl != null &&
//                   controller.socialMediaModel!.cocoonYoutubeUrl!.isNotEmpty)
//                 speedDialChild(
//                     image: "https://almansy.net/service_images/youticon.png",
//                     onTap: () {
//                       launchUrl(
//                         Uri.parse(
//                           controller.socialMediaModel!.cocoonYoutubeUrl!,
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       );
//                     }),
//               if (controller.socialMediaModel!.cocoonSnapchatUrl != null &&
//                   controller.socialMediaModel!.cocoonSnapchatUrl!.isNotEmpty)
//                 speedDialChild(
//                     image: "https://almansy.net/service_images/snapicon.png",
//                     onTap: () {
//                       launchUrl(
//                         Uri.parse(
//                           controller.socialMediaModel!.cocoonSnapchatUrl!,
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       );
//                     }),
//               if (controller.socialMediaModel!.cocoonTiktokUrl != null &&
//                   controller.socialMediaModel!.cocoonTiktokUrl!.isNotEmpty)
//                 speedDialChild(
//                     image: "https://step2english.com/service_images/tiktok.png",
//                     onTap: () {}),
//               if (controller.socialMediaModel!.cocoonTelegramUrl != null &&
//                   controller.socialMediaModel!.cocoonTelegramUrl!.isNotEmpty)
//                 speedDialChild(
//                     image:
//                         "https://step2english.com/service_images/telegicon.png",
//                     onTap: () {
//                       launchUrl(
//                         Uri.parse(
//                           controller.socialMediaModel!.cocoonTelegramUrl!,
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       );
//                     }),
//               if (controller.socialMediaModel!.cocoonTwitterUrl != null &&
//                   controller.socialMediaModel!.cocoonTwitterUrl!.isNotEmpty)
//                 speedDialChild(
//                     image:
//                         "https://step2english.com/service_images/twitticon.png",
//                     onTap: () {
//                       launchUrl(
//                         Uri.parse(
//                           controller.socialMediaModel!.cocoonTwitterUrl!,
//                         ),
//                         mode: LaunchMode.externalApplication,
//                       );
//                     }),
//             ]
//           : [],
//     );
//   }
// }

// SpeedDialChild speedDialChild(
//     {required void Function()? onTap, required String image}) {
//   return SpeedDialChild(
//     child: Image.network(
//       image,
//       width: 30,
//       height: 30,
//     ),
//     onTap: onTap,
//   );
// }
