import 'package:flutter/material.dart';

import '../../config/size.dart';
import '../../utils/extensions/extensions.dart';
import '../animations_widget/animated_widget_shower.dart';

// const takaIcon = '৳';

class KPrefixSuffixIcon extends StatelessWidget {
  const KPrefixSuffixIcon({required this.text, this.size = 28.0, this.width, super.key});

  final String text;
  final double size;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShower(
      size: size,
      width: width ?? size,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
        child: Center(
          child: Text(
            text,
            style: context.text.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class PasteSuffixIcon extends StatelessWidget {
  const PasteSuffixIcon(this.onTap, {super.key});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShower(
      size: 28.0,
      child: InkWell(
        borderRadius: defaultBorderRadius,
        onTap: onTap,
        child: const Icon(
          Icons.content_paste_go_outlined,
          size: 20.0,
        ),
      ),
    );
  }
}

class ClearPrefixIcon extends StatelessWidget {
  const ClearPrefixIcon(this.onTap, {super.key});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedWidgetShower(
      size: 28.0,
      child: InkWell(
        borderRadius: defaultBorderRadius,
        onTap: onTap,
        child: const Icon(Icons.manage_search_sharp),
      ),
    );
  }
}
