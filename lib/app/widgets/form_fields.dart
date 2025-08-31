import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:step/app/core/extensions_and_so_on/extesions.dart';
import 'package:step/app/core/themes/helper_funtions.dart';
import 'package:step/app/utils/helper_funcs.dart';
import 'package:step/global_providers/theme_provider.dart';

import '../core/themes/colors.dart';
import 'texts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    required this.title,
    super.key,
    this.fillColor,
    this.prefixIcon,
    this.titleColor,
    this.validatetor,
    this.textInputType,
    this.controller,
    this.maxLength,
    this.showCounter = false,
    this.heightOfBoty,
    this.formatters,
    this.focusNode,
    this.prefix,
    this.enabled = true,
    this.textStyleColor,
    this.decoration,
    this.getwith,
    this.cursorColor,
    this.suffixIcon,
    this.obscureText = false,
  });

  final FocusNode? focusNode;
  final bool showCounter;
  final String title;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? titleColor;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final String? Function(String?)? validatetor;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  final double? heightOfBoty;
  final Widget? prefix;
  final bool? enabled;
  final Color? textStyleColor;
  final InputDecoration? decoration;
  final double? getwith;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final bool obscureText;
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
        getHeightSpace(getwith ?? 0),
        Builder(builder: (context) {
          return SizedBox(
            height: showCounter ? heightOfBoty ?? 0 + 30 : heightOfBoty,
            child: TextFormField(
              enabled: enabled,
              controller: controller,
              keyboardType: textInputType,
              focusNode: focusNode,
              inputFormatters: formatters,
              cursorColor: cursorColor ?? Colors.black,
              obscureText: obscureText,
              buildCounter: showCounter
                  ? (
                      context, {
                      currentLength = 0,
                      isFocused = false,
                      maxLength,
                    }) =>
                      isFocused ? Text(currentLength.toString()) : null
                  : null,
              maxLength: maxLength,
              style: getThemeData(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: textStyleColor ?? Colors.black,
                  ),
              decoration: decoration ??
                  getDecoration(getThemeData(context).inputDecorationTheme)
                      .copyWith(
                    hintText: title,
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff767676),
                    ),
                    counterStyle:
                        const TextStyle(height: 0.5, color: Colors.black),
                    prefix: prefix,
                    fillColor: fillColor,
                    errorStyle: const TextStyle(
                      color: Color(0xffaf2d24),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.clip,
                    ),
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                  ),
              validator: validatetor,
              // maxLines: null,
            ),
          );
        }),
      ],
    );
  }
}

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,
      {TextSelection? selection}) {
    if (newValue.text.contains(' ')) {
      final newText = newValue.text.replaceAll(' ', '');
      return newValue.copyWith(text: newText, selection: selection);
    } else {
      return newValue;
    }
  }
}

class MultilineTextInputWithScrollArrows extends FormField<String> {
  MultilineTextInputWithScrollArrows({
    super.key,
    required TextEditingController controller,
    required InputDecoration decoration,
  }) : super(
          initialValue: "",
          builder: (context) {
            return Container(
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: decoration.copyWith(
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        onPressed: () {
                          if (controller.selection.start > 0) {
                            controller.selection = TextSelection.collapsed(
                                offset: controller.selection.start - 1);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          if (controller.selection.end <
                              controller.text.length) {
                            controller.selection = TextSelection.collapsed(
                                offset: controller.selection.end + 1);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
}

Column getFormDropDownFieldWidget(
    BuildContext context, String title, List<Map<String, String>> list,
    {TextEditingController? controller, Color? titleColor, Color? fillColor}) {
  String? value = (controller?.text == null || controller!.text.isEmpty)
      ? null
      : controller.text;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title.isNotEmpty)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: getNormalText(
            title,
            context,
            color: titleColor,
            weight: FontWeight.bold,
          ),
        ),
      DropdownButtonFormField<String>(
        items: list
            .map(
              (e) => DropdownMenuItem<String>(
                value: e['id'],
                child: Text(
                  e['name'].toString(),
                  style: TextStyle(
                    color: getThemeData(context).colorScheme.onSurface,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            )
            .toList(),
        selectedItemBuilder: (vv) =>
            list.map((e) => Text(e['name'].toString())).toList(),
        onChanged: (Object? value) {
          value = value!;
          controller?.text = value.toString();
        },
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
        ),
        style: getThemeData(context)
            .textTheme
            .displayMedium!
            .copyWith(fontWeight: FontWeight.bold, color: kSecondaryColor),
        iconSize: 50,
        iconEnabledColor: kPrimaryColor,
        value: value,
        decoration:
            getDecoration(getThemeData(context).inputDecorationTheme).copyWith(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          filled: true,
          fillColor: fillColor ?? _getBackgroundColor(context),
        ),
      ),
    ],
  );
}

_getBackgroundColor(context) {
  final themeMode =
      Provider.of<AppThemeProvider>(context, listen: false).getAppThemeMode();

  if (themeMode == ThemeMode.light) {
    return Colors.grey.withOpacity(0.7);
  } else {
    return Colors.white70;
  }
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    required this.title,
    super.key,
    this.fillColor,
    this.icon,
    this.titleColor,
    this.validatetor,
    this.textInputType,
    this.controller,
    this.maxLength = 15,
    this.bodyHeight,
    this.borderColor,
    this.suffixIconColor,
    this.textStyleColor,
    this.getwith,
    this.cursorColor,
  });

  final String title;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? titleColor;
  final Icon? icon;
  final TextInputType? textInputType;
  final String? Function(String?)? validatetor;
  final int maxLength;
  final double? bodyHeight;
  final Color? borderColor;
  final Color? suffixIconColor;
  final Color? textStyleColor;
  final double? getwith;
  final Color? cursorColor;
  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool showPAssword = false;
  setShowPssword(bool show) {
    setState(() {
      showPAssword = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: getNormalText(
              widget.title,
              context,
              color: widget.titleColor ?? kOnPrimary,
              weight: FontWeight.bold,
            ),
          ),
        getHeightSpace(widget.getwith ?? 0),
        SizedBox(
          height: widget.bodyHeight,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            obscureText: !showPAssword,
            maxLength: widget.maxLength,
            cursorColor: widget.cursorColor ?? Colors.black,
            style: getThemeData(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: widget.textStyleColor ?? Colors.black,
                ),
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ?? const Color(0xffD9D9D9))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ?? const Color(0xffD9D9D9))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.borderColor ?? const Color(0xffD9D9D9))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? const Color(0xffD9D9D9),
                ),
              ),
              hintText: widget.title,
              hintStyle: const TextStyle(
                color: Color(0xff767676),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              counter: const SizedBox(),
              suffixIcon: (!showPAssword
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.visibility,
                            color: widget.suffixIconColor ??
                                const Color(0xff013567),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.visibility_off,
                            color: widget.suffixIconColor ??
                                const Color(0xff013567),
                          ),
                        ))
                  .onTap(() {
                setShowPssword(!showPAssword);
              }),
              fillColor: widget.fillColor,
              errorStyle: const TextStyle(
                color: Color(0xffaf2d24),
                fontWeight: FontWeight.bold,
              ),
              // counter: SizedBox(),
              prefixIcon: widget.icon,
            ),
            validator: widget.validatetor,
          ),
        ),
      ],
    );
  }
}
