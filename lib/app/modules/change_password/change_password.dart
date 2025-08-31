import 'package:flutter/material.dart';
import 'package:step/app/modules/change_password/change_password_controller.dart';
import 'widget/form_body_change_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late final ChangePasswordController controller;

  @override
  void initState() {
    controller = ChangePasswordController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تغيير كلمة المرور',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Cairo',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: FormBodyChangePassword(controller: controller),
    );
  }
}
