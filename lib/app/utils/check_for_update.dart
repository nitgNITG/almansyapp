import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:step/app/core/constants_and_enums/static_data.dart';
import 'package:step/app/core/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> checkForUpdate(BuildContext context) async {
  log("checkForUpdate called");

  // Get current version
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  log("Current version: ${packageInfo.version}");
  String currentVersion = packageInfo.version;

  // // Fetch latest version info from your server
  final dio = Dio();
  final response = await dio.get(
      '${StaticData.baseUrl}/signleteacher/apis3.php?function=get_latest_versions');
  String? latestVersion;
  String? updateUrl;
  if (response.statusCode == 200) {
    final data = response.data['data'];
    log("Response data: $data");
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final manufacturer = androidInfo.manufacturer.toLowerCase();

      if (manufacturer == 'huawei') {
        latestVersion = data['huawei_version'];
        updateUrl = data['huawei_url'];
      } else {
        latestVersion = data['android_version'];
        updateUrl = data['android_url'];
      }
    } else if (Platform.isIOS) {
      latestVersion = data['ios_version'];
      updateUrl = data['ios_url'];
    }
//
    if (isUpdateAvailable(currentVersion, latestVersion!)) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: const Center(
                child: Text('فرض التحديث',
                    style: TextStyle(
                      color: kPrimary1Color,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    )),
              ),
              content: Text(data['update_error_message'].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kPrimary1Color,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Cairo',
                  )),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      final uri = Uri.parse(updateUrl!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      }
                      // بعد ثانية واحدة، نقفل التطبيق
                      Future.delayed(const Duration(seconds: 1), () {
                        SystemNavigator.pop();
                      });
                    },
                    child: Text(data['update_button_message'].toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      );
      return true;
    }
  }
  return false;
}

bool isUpdateAvailable(String currentVersion, String latestVersion) {
  final current = Version.parse(currentVersion);
  final latest = Version.parse(latestVersion);
  return latest > current;
}
