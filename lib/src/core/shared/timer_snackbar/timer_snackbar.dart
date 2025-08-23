import 'package:flutter/material.dart';

import '../../utils/extensions/extensions.dart';
import '../../utils/themes/themes.dart';

class TimerSnackbarContent extends StatelessWidget {
  const TimerSnackbarContent({
    super.key,

    /// Main body message
    required this.contentText,

    /// action button prefix child
    this.buttonPrefixWidget,

    /// button label
    this.buttonLabel = 'Undo',

    /// This method will execute after time finish. The default time is 4 seconds.
    this.onTap,

    /// default time set 4 seconds.
    this.second = 4,

    /// default TextStyle is none.
    this.contentTextStyle,

    /// Alignment of the content text
    this.alignment = Alignment.center,
  });

  final String contentText;
  final Widget? buttonPrefixWidget;
  final String buttonLabel;
  final void Function()? onTap;
  final int second;
  final TextStyle? contentTextStyle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // screen dimensions
    bool isMobile = size.width <= 768;
    // bool isTablet = size.width > 768 && size.width <= 992;
    bool isDesktop = size.width >= 992;

    return Row(
      children: [
        if (alignment == Alignment.center)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.01),
        if (alignment == Alignment.centerRight)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.02),
        Expanded(
          flex: !isDesktop ? 8 : 1,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                                color: context.theme.primaryColor,
                                backgroundColor: context.theme.cardColor,
                              ),
                            ),
                            Center(
                              child: Text(
                                (second - (value / 1000)).toInt().toString(),
                                textScaler: const TextScaler.linear(0.85),
                                style:
                                    contentTextStyle ??
                                    context.text.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
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
                      contentText,
                      style:
                          contentTextStyle ??
                          context.text.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: context.theme.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      foregroundColor: Colors.white,
                      fixedSize: const Size(80.0, 30.0),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if (onTap != null) onTap!();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (buttonPrefixWidget != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: buttonPrefixWidget,
                          ),
                        Text(
                          buttonLabel,
                          style:
                              contentTextStyle ?? context.text.labelLarge!.copyWith(color: white),
                          textScaler: const TextScaler.linear(1.1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (alignment == Alignment.center)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.01),
        if (alignment == Alignment.centerLeft)
          !isMobile ? const Spacer() : SizedBox(width: size.width * 0.02),
      ],
    );
  }
}
