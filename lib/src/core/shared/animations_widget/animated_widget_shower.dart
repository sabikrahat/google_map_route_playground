import 'package:flutter/material.dart';

import '../../config/size.dart';
import '../../utils/extensions/extensions.dart';

class AnimatedWidgetShower extends StatelessWidget {
  const AnimatedWidgetShower({
    super.key,
    required this.child,
    required this.size,
    this.padding = 6.0,
    this.color,
    this.width,
  });

  final Widget child;
  final double size;
  final double? width;
  final double padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: defaultRoundedRectangleBorder,
      color: color ?? context.theme.primaryColor.withValues(alpha: 0.1),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SizedBox(
          height: size,
          width: width ?? size,
          child: TweenAnimationBuilder(
            curve: Curves.easeOut,
            duration: kAnimationDuration(0.4),
            tween: Tween<double>(begin: 0, end: size),
            builder: (_, double x, _) {
              return Center(
                child: SizedBox(height: x, width: width ?? x, child: child),
              );
            },
          ),
        ),
      ),
    );
  }
}
