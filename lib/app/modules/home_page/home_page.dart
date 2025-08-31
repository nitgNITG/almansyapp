import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:step/app/modules/home_page/home_controller.dart';
import 'package:step/app/modules/web_view/web_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  String? token;
  @override
  void initState() {
    token = controller.getLoggedUser().token;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("token: $token");
    return WillPopScope(
      onWillPop: () async => false,
      child:
          //const Scaffold(
          // body:
          AppWebView(
        "https://almansy.net/admin/tool/mobile/launch.php?service=moodle_mobile_app&token=$token",
        "",
        showAppBar: false,
      ),
      // ),
    );
  }
}
