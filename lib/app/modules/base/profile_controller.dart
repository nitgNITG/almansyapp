import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:step/app/core/constants_and_enums/static_data.dart';
import 'package:step/app/modules/base/base_controller.dart';
import 'package:step/app/modules/register/model/country_model.dart';
import 'package:step/app/utils/helper_funcs.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/models/logged_user.dart';
import '../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../widgets/messages.dart';

class BaseProfileController extends BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final thirdNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // final phone2Controller = TextEditingController();
  final studentPhoneNumber_2 = TextEditingController(text: "+966");

  final sientificDegreeController = TextEditingController(text: "1");
  final jobController = TextEditingController();
  final password = TextEditingController();

  final cityController = TextEditingController(text: "1");

  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  String getCombinedPhoneNumber() {
    log("Total Phone : ${studentPhoneNumber_2.text}${phoneController.text}");
    return "${studentPhoneNumber_2.text}${phoneController.text}";
  }

  List<CountryModel> countries = const [
    CountryModel(
        name: '(السعودية) saudi Arabia',
        code: '+966',
        image: 'assets/images/saudi_image.png'),
    CountryModel(
        name: '(مصر) Egypt',
        code: '+20',
        image: 'assets/images/egypt_image.png'),
    CountryModel(
        name: '(كويت) kuwait',
        code: '+965',
        image: 'assets/images/kuwait_image.png'),
    CountryModel(
        name: '(الإمارات) The UAE',
        code: '+971',
        image: 'assets/images/uae_image.png'),
    CountryModel(
        name: '(قطر) Qatar',
        code: '+974',
        image: 'assets/images/qatar_image.png'),
    CountryModel(
        name: '(عمان) Oman',
        code: '+968',
        image: 'assets/images/oman_image.png'),
    CountryModel(
        name: '(البحرين) Bahrain',
        code: '+973',
        image: 'assets/images/bahrain_image.png'),
  ];

  updateUserData(context) async {
    if (formKey.currentState!.validate()) {
      try {
        changeViewState(AppViewState.busy);
        log('token=${getLoggedUser().token}');
        log(phoneController.text.toString());
        log(getCombinedPhoneNumber());
        log(firstNameController.text.toString());
        log(lastNameController.text.toString());
        final response = await CallApi.getRequest(
          "${StaticData.baseUrl}/signleteacher/apis3.php?function=edit_user&token=${getLoggedUser().token}&phone1=${getCombinedPhoneNumber()}&fname=${firstNameController.text.toString()}&lname=${lastNameController.text.toString()}",
        );
        log("response edit profile data=$response");
        log(response.toString());
        if (response['status'] == 'success') {
          Navigator.of(context).pop();
          saveUser();
          // await SharedPreferencesService.instance
          //     .setString('phone', phoneController.text.toString());
          Future.delayed(const Duration(milliseconds: 100));
          showToast(
            context,
            "تم تحديث البيانات بنجاح",
            color: Colors.blue,
            icon: Icons.check,
          );

          changeViewState(AppViewState.idle);
        } else {
          showToast(context, getL10(context).tryAgain);
        }
      } catch (e) {
        changeViewState(AppViewState.error);
        print(e.toString());
      }
    }
  }

  void setDataForBottomSheet() {
    firstNameController.text = getLoggedUser().firstName;

    lastNameController.text = getLoggedUser().lastName;

    phoneController.text = getLoggedUser().phone;

    emailController.text = getLoggedUser().email;
  }

  void setDataForEditProfile() async {
    //final String? phone = SharedPreferencesService.instance.getString('phone');
    firstNameController.text = getLoggedUser().firstName;
    lastNameController.text = getLoggedUser().lastName;
    phoneController.text = getLoggedUser().phone;
    extractCountryCode(phoneController.text);

    // log("phoneController: ${phoneController.text}");
    // log("phone: $phone");
    //phoneController.text = phone ?? '';
  }

  void extractCountryCode(String rawNumber) {
    try {
      final phoneNumber = PhoneNumber.parse(rawNumber);
      studentPhoneNumber_2.text = '+${phoneNumber.countryCode}';
      final isoCode = phoneNumber.isoCode;
      phoneController.text = phoneNumber.nsn;
      log('studentPhoneNumber_2.text: ${studentPhoneNumber_2.text}');
      log('ISO Code: $isoCode');
      log('phoneController.text : ${phoneController.text}');
    } catch (e) {
      log('error in extractCountryCode: $e');
    }
  }

  saveUser() async {
    final user = LoggedUser(
      id: getLoggedUser().id,
      auth: getLoggedUser().auth,
      username: getLoggedUser().username,
      firstName: firstNameController.text.toString(),
      lastName: lastNameController.text.toString(),
      image: getLoggedUser().image,
      token: getLoggedUser().token,
      email: getLoggedUser().email,
      role: getLoggedUser().role,
      phone: getCombinedPhoneNumber(),
      coursesCount: getLoggedUser().coursesCount,
      isAdmin: getLoggedUser().isAdmin,
    );

    await SharedPreferencesService.instance
        .setString(SharedPreferencesKeys.loggedUser, user.toString());
  }
}
