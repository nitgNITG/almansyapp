import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:step/app/core/constants_and_enums/enums.dart';
import 'package:step/app/core/constants_and_enums/static_data.dart';
import 'package:step/app/core/data/models/logged_user.dart';
import 'package:step/app/core/data/shared_preferences/shared_preferences_keys.dart';
import 'package:step/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:step/app/modules/base/base_view.dart';
import 'package:step/app/modules/change_password/change_password.dart';
import 'package:step/app/modules/course_profile/course_profile_page.dart';
import 'package:step/app/modules/home_page/helper_widgets/course_item.dart';
import 'package:step/app/modules/splash/splash_page.dart';
import 'package:step/app/modules/student_profile/profile_controller.dart';
import 'package:step/app/modules/student_profile/sub_widgets/edit_profile_bottom_sheet.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/app/utils/routing_utils.dart';
import 'package:step/app/widgets/form_fields.dart';
import 'package:step/app/widgets/image_picker.dart';
import 'package:step/app/widgets/texts.dart';
import '../global_used_widgets/widget_methods.dart';
import '../login/login_page.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late final ProfileController controller;

  LoggedUser getLoggedUser() {
    String? jsonString = SharedPreferencesService.instance
        .getString(SharedPreferencesKeys.loggedUser);
    log(jsonString.toString());
    return LoggedUser.fromString(jsonString!);
  }

  bool _isNavigating = false;

  @override
  void initState() {
    controller = ProfileController();
    controller.getAllCourses().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenSize(context).height -
          (MediaQuery.of(context).padding.bottom),
      width: getScreenSize(context).width,
      child: BaseView<ProfileController>(
        injectedObject: controller,
        //child: Scaffold(
        //appBar: buildAppBarWithLogo(context),
        //  body:
        child: Container(
          height: getScreenSize(context).height -
              (MediaQuery.of(context).padding.bottom),
          width: getScreenSize(context).width,
          color: getThemeData(context).colorScheme.surface,
          child: Builder(builder: (context) {
            LoggedUser? loggedUser = controller.getLoggedUser();
            log(loggedUser.toString());
            return Stack(
              children: [
                getAppPostionedBackground(context),
                SizedBox(
                  //height: 1.sh,
                  height: getScreenSize(context).height -
                      (MediaQuery.of(context).padding.bottom),
                  width: getScreenWidth(context),
                  child: Column(
                    children: [
                      // NormalAppBar(
                      //   title: getL10(context).profile,
                      //   icon: "assets/images/profile_bottom_bar_ic.svg",
                      // ),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              setState(() {});
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getHeightSpace(10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      getWidthSpace(10),
                                      ImagePickerWidget(
                                        loggedUser: loggedUser,
                                      ),
                                      getWidthSpace(19.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          getNormalText(
                                            "${loggedUser.firstName} ${loggedUser.lastName}",
                                            context,
                                            weight: FontWeight.w700,
                                            color: kPrimary1Color,
                                            size: 16.sp,
                                          ),
                                          getNormalText(
                                            loggedUser.email,
                                            context,
                                            weight: FontWeight.w400,
                                            size: 14.sp,
                                            color: const Color(0xff000000),
                                          ),
                                        ],
                                      ),
                                      //اقونة التعديل

                                      //const Spacer(),

                                      // getWidthSpace(10)
                                    ],
                                  ),
                                  getHeightSpace(
                                      (getScreenSize(context).height * 0.03)),
                                  // getWidthSpace(10),
                                  Container(
                                    //height: 450,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: kOnPrimary,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 2),
                                            color: const Color(0xff000000)
                                                .withOpacity(.25),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 21.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getTitleText(
                                            getL10(context).personalData,
                                            context,
                                            color: const Color(0xff000000),
                                            weight: FontWeight.bold,
                                            size: 19,
                                          ),
                                          getHeightSpace(18.h),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormFieldWidget(
                                                  enabled: false,
                                                  fillColor: kTextFeildColor,
                                                  textStyleColor:
                                                      kTextFeildColor,
                                                  controller:
                                                      TextEditingController(
                                                    text: loggedUser.firstName,
                                                  ),
                                                  title:
                                                      getL10(context).firstName,
                                                  titleColor: kTextFeildColor,
                                                  decoration:
                                                      const InputDecoration(
                                                    disabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              kTextFeildColor),
                                                    ),
                                                  ),
                                                  heightOfBoty: 35,
                                                ),
                                              ),
                                              getWidthSpace(27.w),

                                              /// الاسم الاول
                                              Expanded(
                                                child: TextFormFieldWidget(
                                                  textStyleColor:
                                                      kTextFeildColor,
                                                  enabled: false,
                                                  controller:
                                                      TextEditingController(
                                                    text: loggedUser.lastName ??
                                                        "",
                                                  ),
                                                  title: 'الاسم الاخير',
                                                  titleColor: kTextFeildColor,
                                                  heightOfBoty: 35,
                                                  decoration:
                                                      const InputDecoration(
                                                    disabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              kTextFeildColor),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              /// الاسم الثاني
                                            ],
                                          ),

                                          /// contact info
                                          getHeightSpace(18.h),
                                          TextFormFieldWidget(
                                            textStyleColor: kTextFeildColor,
                                            enabled: false,
                                            controller: TextEditingController(
                                              text: loggedUser.email ?? "",
                                            ),
                                            title: getL10(context).email,
                                            titleColor: kTextFeildColor,
                                            heightOfBoty: 35,
                                            decoration: const InputDecoration(
                                              disabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kTextFeildColor),
                                              ),
                                            ),
                                          ),
                                          getHeightSpace(18.h),

                                          TextFormFieldWidget(
                                            textStyleColor: kTextFeildColor,
                                            enabled: false,
                                            controller: TextEditingController(
                                              text: loggedUser.phone ?? "",
                                            ),
                                            title: getL10(context).phone,
                                            titleColor: kTextFeildColor,
                                            heightOfBoty: 35,
                                            decoration: const InputDecoration(
                                              disabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kTextFeildColor),
                                              ),
                                            ),
                                          ),
                                          getHeightSpace(18.h),

                                          TextFormFieldWidget(
                                            textStyleColor: kTextFeildColor,
                                            enabled: false,
                                            controller: TextEditingController(
                                              text: loggedUser.coursesCount
                                                      .toString() ??
                                                  "",
                                            ),
                                            title: getL10(context).coursesCount,
                                            titleColor: kTextFeildColor,
                                            heightOfBoty: 35,
                                            decoration: const InputDecoration(
                                              disabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kTextFeildColor),
                                              ),
                                            ),
                                          ),

                                          getHeightSpace(18.h),
                                          Builder(builder: (context) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    right: Platform.isWindows
                                                        ? 15
                                                        : 0,
                                                  ),
                                                  child: getTitleText(
                                                          'تعديل البيانات',
                                                          color: kPrimary1Color,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              kPrimary1Color,
                                                          weight:
                                                              FontWeight.w700,
                                                          size: 18.sp,
                                                          context)
                                                      .onTap(() {
                                                    // controller
                                                    //     .setDataForBottomSheet();
                                                    controller
                                                        .setDataForEditProfile();
                                                    Navigator.of(context).push(
                                                      routeToPage(
                                                        EditProfileBottomSheet(
                                                          controller:
                                                              controller,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  getHeightSpace(20),

                                  Container(
                                    //height: 310,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: kOnPrimary,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 2),
                                            color: const Color(0xff000000)
                                                .withOpacity(.25),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 21.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getTitleText(
                                            "الكورسات",
                                            context,
                                            weight: FontWeight.w700,
                                            size: 18.sp,
                                            color: const Color(0xff000000),
                                          ),
                                          //getHeightSpace(10),
                                          SizedBox(
                                            height: 180,
                                            width: getScreenSize(context).width,
                                            child: ValueListenableBuilder<
                                                    AppViewState>(
                                                valueListenable:
                                                    controller.state,
                                                builder:
                                                    (context, value, child) {
                                                  if (value ==
                                                      AppViewState.busy) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  if (controller
                                                      .myCoursesList.isEmpty) {
                                                    return Center(
                                                      child: getNormalText(
                                                        "أنت غير مسجل في دورات تعليمية تواصل مع الدعم على الواتساب للتسجيل",
                                                        context,
                                                        align: TextAlign.center,
                                                      ),
                                                    );
                                                  }
                                                  return ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: controller
                                                        .myCoursesList.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            CourseItemMyCourse(
                                                      myCourse: controller
                                                          .myCoursesList[index],
                                                    ).onTap(() {
                                                      Navigator.of(context)
                                                          .push(
                                                        routeToPage(
                                                          CourseProfilePage(
                                                            myCourse: controller
                                                                    .myCoursesList[
                                                                index],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  getHeightSpace(26.h),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              getTitleText(
                                                      'تغيير كلمة المرور',
                                                      color: kPrimary1Color,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          kPrimary1Color,
                                                      weight: FontWeight.w700,
                                                      size: 18.sp,
                                                      context)
                                                  .onTap(() {
                                                if (!_isNavigating) {
                                                  _isNavigating = true;
                                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => MyScreen())).then((_) {
                                                  Navigator.push(
                                                          context,
                                                          routeToPage(
                                                              const ChangePassword()))
                                                      .then((_) {
                                                    _isNavigating = false;
                                                  });
                                                }
                                              }),
                                              getHeightSpace(11.h),
                                              getTitleText(
                                                      'تسجيل الخروج',
                                                      color: kPrimary1Color,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          kPrimary1Color,
                                                      weight: FontWeight.w700,
                                                      size: 18.sp,
                                                      context)
                                                  .onTap(() async {
                                                final String? deviceUuid =
                                                    SharedPreferencesService
                                                        .instance
                                                        .getString(StaticData
                                                            .kDeviceUuid);

                                                await SharedPreferencesService
                                                    .instance
                                                    .clear();
                                                if (deviceUuid != null) {
                                                  await SharedPreferencesService
                                                      .instance
                                                      .setString(
                                                          StaticData
                                                              .kDeviceUuid,
                                                          deviceUuid);
                                                }
                                                Future.delayed(Duration.zero,
                                                    () {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          routeToPage(
                                                              const SplashPage()),
                                                          (route) => false);
                                                });
                                              }),
                                            ]),

                                        // getWidthSpace(10.w),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: Platform.isWindows ? 30 : 0,
                                          ),
                                          child: getTitleText(
                                                  'حذف الحساب',
                                                  color:
                                                      const Color(0xffE53935),
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      const Color(0xffE53935),
                                                  weight: FontWeight.w700,
                                                  size: 18.sp,
                                                  context)
                                              .onTap(() async {
                                            await _showConfirmationDialog(
                                                context);
                                          }),
                                        ),
                                      ]),

                                  getHeightSpace(56.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      //),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('حذف الحساب',
              style: TextStyle(
                  color: kPrimary1Color, fontWeight: FontWeight.bold)),
          content: const Text('هل تريد حذف الحساب؟',
              style: TextStyle(
                color: kPrimary1Color,
                fontWeight: FontWeight.w500,
                fontFamily: 'Cairo',
              )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
              child: const Text(
                'الغاء',
                style: TextStyle(
                  color: kPrimary1Color,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _deleteUserAccount(context);
                Navigator.of(context).pushAndRemoveUntil(
                  routeToPage(
                    const LoginPage(),
                  ),
                  (c) => false,
                );
              },
              child: const Text('نعم',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  )),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUserAccount(BuildContext context) async {
    try {
      final response = await http.delete(Uri.parse(
          "${StaticData.baseUrl}/academyApi/json.php?function=delete_user_account&token=${getLoggedUser().token}"));

      if (response.statusCode == 200) {
        print('Account Deleted Successfully');
      } else {
        print('Error deleting account: ${response.statusCode}');
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Widget getRowItemProfile(BuildContext context, title, value) {
    return Column(
      children: [
        getHeightSpace(10),
        getNormalText(title + " : " + value, context, weight: FontWeight.bold),
      ],
    );
  }
}

class CustomTextFeildProfile extends StatelessWidget {
  const CustomTextFeildProfile(
      {super.key,
      required this.title,
      this.controller,
      this.fillColor,
      this.titleColor,
      this.icon,
      this.textInputType,
      this.validatetor,
      this.maxLength,
      this.heightOfBoty,
      this.prefix,
      this.initialValue});
  //final FocusNode? focusNode;
  //final bool showCounter;
  final String title;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? titleColor;
  final Icon? icon;
  final TextInputType? textInputType;
  final String? Function(String?)? validatetor;
  final int? maxLength;
  //final List<TextInputFormatter>? formatters;
  final double? heightOfBoty;
  final Widget? prefix;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: getNormalText(
              title,
              context,
              color: titleColor ?? kOnPrimary,
              weight: FontWeight.bold,
            ),
          ),
        //getHeightSpace(7),
        Builder(builder: (context) {
          return TextFormField(
            controller: controller,
            keyboardType: textInputType,
            //focusNode: focusNode,
            //  inputFormatters: formatters,
            cursorColor: kOnPrimary,
            // buildCounter: showCounter
            // ? (
            //     context, {
            //     currentLength = 0,
            //     isFocused = false,
            //     maxLength,
            //   }) =>
            //     isFocused ? Text(currentLength.toString()) : null
            // : null,
            // maxLength: maxLength,
            // style: getThemeData(context).textTheme.displayMedium!.copyWith(
            //       fontWeight: FontWeight.w300,
            //       color: kOnPrimary,
            //     ),
            //initialValue: 'ahhdhidw',
            enabled: false,

            decoration: const InputDecoration(

                // contentPadding: EdgeInsets.all(0),
                // border: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Color(0xff777777),
                //   ),
                // ),
                // disabledBorder:
                //  UnderlineInputBorder(
                //     // borderSide: BorderSide(
                //     //   color: Color(0xff777777),
                //     // ),
                //     ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Color(0xff777777),
                //   ),
                // ),
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Color(0xff777777),
                //   ),
                // ),
                ),
            validator: validatetor,
            maxLines: null,
          );
        }),
      ],
    );
  }
}
