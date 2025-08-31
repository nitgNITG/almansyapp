// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:step/app/core/constants_and_enums/static_data.dart';
import 'package:step/app/core/data/api/ApiCall.dart';
import 'package:flutter/cupertino.dart';
import 'package:step/app/modules/base/base_controller.dart';
import 'package:step/app/modules/register/model/country_model.dart';
import 'package:step/app/utils/auth_service.dart';
import '../../core/constants_and_enums/enums.dart';
import '../../core/data/shared_preferences/helper_funcs.dart';
import '../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../utils/routing_utils.dart';
import '../../widgets/messages.dart';
import '../home/home.dart';

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final studentName_1 = TextEditingController(text: "");
  ValueNotifier<String> termsAndConditions = ValueNotifier("");
  var termsAndConditionsState = ValueNotifier(AppViewState.busy);
  final studentName_4 = TextEditingController(text: "");
  final studentEmail = TextEditingController();
  final studentPhoneNumber_2 = TextEditingController(text: "+966");
  final studentPhoneNumber_1 = TextEditingController(text: "");
  final studentPassword = TextEditingController(text: "");
  String getCombinedPhoneNumber() {
    return "${studentPhoneNumber_2.text}${studentPhoneNumber_1.text}";
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

  ///  view variables
  final ValueNotifier<AppViewState> viewState =
      ValueNotifier(AppViewState.idle);

  register(BuildContext context, String phone) async {
    if (formKey.currentState!.validate()) {
      try {
        changeViewState(AppViewState.busy);
        final url = CallApi.buildRegisterUrlParams(
          fname: studentName_1.text.toString(),
          lname: studentName_4.text.toString(),
          email: studentEmail.text.toString(),
          password: studentPassword.text.toString(),
          phone1: getCombinedPhoneNumber(),
        ).toString();
        log(url);
        final response = await CallApi.getRequest(url.toString());
        if (response["status"] == "success") {
          log(response.toString());
          log("id : ${response["data"]['id']}");
          AuthService.addDeviceToUser(
              response['data']['id'].toString(), context);
          SharedPreferencesService.instance
              .setBool(SharedPreferencesKeys.userTypeIsGust, false);
          await saveToSharedPref(response["data"]);

          await Future.delayed(const Duration(milliseconds: 200));
          Navigator.of(context).pushAndRemoveUntil(
            routeToPage(const HomeMainParentPage()),
            (route) => false,
          );
          await SharedPreferencesService.instance
              .setString('phone', studentPhoneNumber_1.text.toString());
        } else {
          showToast(context, response["error"]);
        }
      } catch (e) {
        debugPrint(e.toString());
        showToast(context, e.toString());
      } finally {
        changeViewState(AppViewState.idle);
      }
    }
  }

  @override
  void changeViewState(AppViewState state) {
    viewState.value = state;
  }

  Future<void> getTermsAndConditions() async {
    try {
      termsAndConditionsState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/signleteacher/apis3.php?function=get_termsandconditions",
      );
      //log("response: $response");
      termsAndConditions.value = response["termsandconditions"];
      // log("termsandconditions $termsAndConditions");
      termsAndConditionsState.value = AppViewState.idle;
      changeViewState(AppViewState.idle);
    } catch (e) {
      showToast(
        context!,
        e.toString(),
      );
      termsAndConditionsState.value = AppViewState.error;
      changeViewState(AppViewState.error);
      log(e.toString());
    }
  }
}
