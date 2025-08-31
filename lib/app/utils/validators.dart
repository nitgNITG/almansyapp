import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:step/app/utils/helper_funcs.dart';

class Validators {
  late final BuildContext context;

  Validators(this.context);

  String? validateName(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisField;
    }
    const String arabicLetters = "أإببتثججحخدذرززسشصضطظعغفقكلمنهويةى";
    // Check if the name contains only letters and spaces.
    if (!RegExp(r'^[a-zA-Z أاإببتثججحخدذرززسشصضطظعغفقكلمنهويةى]+$')
        .hasMatch(value)) {
      return "Name should only contains characters";
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisField;
    }

    // Check if the email address is in a valid format.
    final regex = RegExp(
        r'''^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$''');
    if (!regex.hasMatch(value)) {
      return getL10(context).pleaseEnterYourEmailAddress;
    }

    // Check if the email address is registered with a real domain.
    // This is an optional check, but it can help to reduce spam.
    // To use this check, you will need to install the `email_validator` package from Pub.
    // Once you have installed the package, you can uncomment the following lines of code:

    // import 'package:email_validator/email_validator.dart';
    //
    // if (!EmailValidator.validate(value)) {
    //   return 'Please enter an email address that is registered with a real domain.';
    // }

    return null;
  }

  String? validatePhone1(String? value1, String? value2) {
    if (value1 == null || value1.isEmpty || value2 == null || value2.isEmpty) {
      return getL10(context).pleaseFillThisField;
    }
    String combinedPhone = value1 + value2;
    String cleanedPhone = combinedPhone.replaceAll(RegExp(r'[^0-9+]'), '');

    log(cleanedPhone.length.toString());

    // Check if the phone number contains only numbers and parentheses.
    if (!RegExp(r'^[+0-9()]+$').hasMatch(cleanedPhone)) {
      return getL10(context).pleaseEnterYourPhoneNumber;
    }

    // Check if the phone number is at least 10 digits long.
    if (cleanedPhone.length < 11) {
      return getL10(context).pleaseEnterAPhoneNumberWithAtLeast10Digits;
    }

    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisField;
    }
    String cleanedPhone = value.replaceAll(RegExp(r'[^0-9+]'), '');
    log(cleanedPhone.length.toString());

    // Check if the phone number contains only numbers and parentheses.
    if (!RegExp(r'^[+0-9()]+$').hasMatch(cleanedPhone)) {
      return getL10(context).pleaseEnterYourPhoneNumber;
    }

    // Check if the phone number is at least 10 digits long.
    if (cleanedPhone.length < 11) {
      return getL10(context).pleaseEnterAPhoneNumberWithAtLeast10Digits;
    }

    return null;
  }

  String? validateIdNumber(String? value) {
    if (value == null || value.isEmpty) {
      return getL10(context).pleaseFillThisField;
    }
    // Check if the id number contains only numbers and parentheses.
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return getL10(context).pleaseEnterYourPhoneNumber;
    }

    // Check if the id number is at least 10 digits long.
    if (value.length != 14) {
      return getL10(context).pleaseEnterValidIdNumber;
    }

    return null;
  }

  String? notEmpty(String? value) =>
      (value == null || value.isEmpty) ? "" : null;
}
