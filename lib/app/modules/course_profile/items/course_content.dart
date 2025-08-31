import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/course_profile/items/moduleItem.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/widgets/texts.dart';

import '../../../core/data/models/course_details.dart';
import '../course_profile_controller.dart';

class CourseContent extends StatefulWidget {
  const CourseContent({super.key});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  String? openedIndex;

  openIndex(String? i) {
    setState(() {
      openedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<CourseProfileController>(context, listen: false);
    CourseDetails details = controller.courseDetails;
    return Column(
      children: [
        getHeightSpace(10),
        ...details.contents.map((e) {
          return buildSectionItem(context, e);
        })
      ],
    );
  }

  Widget buildSectionItem(BuildContext context, Section section) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(5),
          decoration: buildDecorationButton(
            borderButton: null,
            radius: 10,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getNormalText(
                  truncateString(
                      section.name, getScreenWidth(context).toInt() ~/ 14),
                  context,
                  color: kOnPrimary,
                  overflow: TextOverflow.clip,
                ),
                Icon(
                  openedIndex == section.id
                      ? Icons.arrow_drop_up_sharp
                      : Icons.arrow_drop_down_sharp,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ).onTap(() {
          openIndex(section.id == openedIndex ? null : section.id);
        }),
        if (openedIndex == section.id)
          Column(
            children: section.modules
                .where((e) {
                  log("Module name: ${e.name}");
                  log("Module name: ${e.url}");
                  log("Modname: ${e.modname}");
                  return e.modname != 'forum';
                })
                .map((e) => ModuleItem(module: e))
                .toList(),
          ),
        getHeightSpace(10)
      ],
    );
  }
}
