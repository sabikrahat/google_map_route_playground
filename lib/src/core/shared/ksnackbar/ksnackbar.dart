import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

class _Colors {
  /// success
  static const Color success = Color(0xff2D6A4F);

  /// failure
  static const Color error = Color(0xffc72c41);

  /// warning
  static const Color warning = Color(0xffFCA652);

  /// info
  static const Color info = Color(0xFF49454F);
}

class KSnackbar {
  static void hideSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // success
  static void success(
    BuildContext context,
    String content, {
    int? second,
    TextStyle? contentTextStyle,
  }) => _show(
    context,
    content,
    bgColor: _Colors.success,
    foregroundColor: Colors.white,
    second: second ?? 3,
    contentTextStyle: contentTextStyle,
  );

  // error
  static void error(
    BuildContext context,
    String content, {
    int? second,
    TextStyle? contentTextStyle,
  }) => _show(
    context,
    content,
    bgColor: _Colors.error,
    foregroundColor: Colors.white,
    second: second ?? 3,
    contentTextStyle: contentTextStyle,
  );

  // warning
  static void warning(
    BuildContext context,
    String content, {
    int? second,
    TextStyle? contentTextStyle,
  }) => _show(
    context,
    content,
    bgColor: _Colors.warning,
    foregroundColor: Colors.white,
    second: second ?? 3,
    contentTextStyle: contentTextStyle,
  );

  // info
  static void info(
    BuildContext context,
    String content, {
    int? second,
    TextStyle? contentTextStyle,
  }) => _show(
    context,
    content,
    bgColor: _Colors.info,
    foregroundColor: Colors.white,
    second: second ?? 3,
    contentTextStyle: contentTextStyle,
  );

  static void _show(
    BuildContext context,
    String content, {
    required Color bgColor,
    required Color foregroundColor,
    required int second,
    TextStyle? contentTextStyle,
  }) {
    EasyLoading.dismiss();
    hideSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _Content(
          content: content,
          second: second,
          contentTextStyle: contentTextStyle,
          bgColor: bgColor,
          foregroundColor: foregroundColor,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: second),
        animation: const AlwaysStoppedAnimation(1.0),
        padding: const EdgeInsets.all(0.0),
        margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
        showCloseIcon: false,
        shape: roundedRectangleBorder5,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    /// Main body message
    required this.content,

    /// default time set 3 seconds.
    required this.second,

    /// default TextStyle is none.
    this.contentTextStyle,

    /// default is false.
    /// if true, the snackbar will be red.
    /// if false, the snackbar will be black.
    required this.bgColor,
    required this.foregroundColor,
  });

  final String content;
  final int second;
  final TextStyle? contentTextStyle;
  final Color bgColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (context.isScreenDesktop) const Expanded(flex: 2, child: SizedBox.shrink()),
        Expanded(
          flex: context.isScreenDesktop ? 3 : 1,
          child: Card(
            elevation: 5.0,
            shape: roundedRectangleBorder5,
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxHeight: 27.0),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: second * 1000.toDouble()),
                      duration: Duration(seconds: second),
                      builder: (context, double value, child) {
                        return Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                value: value / (second * 1000),
                                color: foregroundColor,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Center(
                              child: Text(
                                (second - (value / 1000)).toInt().toString(),
                                textScaler: const TextScaler.linear(0.85),
                                style:
                                    contentTextStyle ??
                                    context.text.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: foregroundColor,
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      content,
                      style:
                          contentTextStyle ??
                          context.text.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: foregroundColor,
                          ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  InkWell(
                    borderRadius: borderRadius45,
                    onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    child: Icon(Icons.close, size: 20.0, color: foregroundColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (context.isScreenDesktop) const Expanded(flex: 2, child: SizedBox.shrink()),
      ],
    );
  }
}
