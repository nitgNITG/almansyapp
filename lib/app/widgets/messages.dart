import 'package:step/app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool displaing = false;
void showSnackBar(
  BuildContext context,
  String message, {
  Color color = Colors.redAccent,
}) {
  if (!displaing) {
    displaing = true;
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            backgroundColor: color,
            content: Text(
              message,
              style: const TextStyle(
                color: kOnPrimary,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        )
        .closed
        .then((value) {
      displaing = false;
    });
  }
}

showToast(BuildContext context, String message,
    {Color? color, IconData? icon}) {
  final fToast = FToast();
  // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color ?? Colors.red,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon ?? Icons.error),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          flex: 4,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kOnPrimary,
              fontFamily: 'Cairo',
            ),
          ),
        )
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 2),
  );
}
