import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/widgets/messages.dart';
import 'package:step/app/widgets/texts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/data/models/course_details.dart';
import '../modules/course_profile/course_profile_controller.dart';

class OnlineSessionButton extends StatefulWidget {
  const OnlineSessionButton({super.key});

  @override
  State<OnlineSessionButton> createState() => _OnlineSessionButton();
}

class _OnlineSessionButton extends State<OnlineSessionButton> {
  bool isTherePromo = false;
  late final CourseDetails details;

  @override
  void initState() {
    details = Provider.of<CourseProfileController>(context, listen: false)
        .courseDetails;
    isTherePromo = true;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getThemeData(context).colorScheme.surface,
      // height: getScreenSize(context).height * 0.3,
      width: getScreenSize(context).width,
      child: Builder(
        builder: (context) {
          if (isTherePromo) {
            return Container(
              height: 200,
              width: getScreenWidth(context),
              decoration: BoxDecoration(
                color: kPrimary1Color.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                    10,
                  ),
                  bottomRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const Spacer(),
                  const Icon(
                    Icons.video_camera_front_outlined,
                    color: kPrimary1Color,
                    size: 100,
                  ),
                  const Spacer(),
                  Container(
                    width: getScreenWidth(context),
                    decoration: const BoxDecoration(
                      color: kPrimary1Color,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          10,
                        ),
                        bottomRight: Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Center(
                      child: getNormalText(
                        "Go to online Session",
                        context,
                        color: kOnPrimary,
                      ),
                    ),
                  )
                ],
              ),
            ).onTap(() {
              if (details.otherFields?.online_url == null ||
                  details.otherFields?.online_url == "") {
                showToast(
                  context,
                  "No online session link found",
                  color: Colors.red,
                );
                return;
              }
              launchUrl(
                Uri.parse(details.otherFields?.online_url ?? ""),
                mode: LaunchMode.externalApplication,
              );
            });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
