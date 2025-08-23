import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';

class SwipeIndicator extends StatelessWidget {
  const SwipeIndicator({super.key, this.text, this.isSuggestion = false});

  final String? text;
  final bool isSuggestion;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainCenter,
      children: [
        if (!isSuggestion)
          SvgPicture.asset(
            'assets/svgs/left-arrow.svg',
            colorFilter: context.theme.dividerColor.toColorFilter,
            height: 20.0,
            width: 50.0,
            fit: BoxFit.fitWidth,
          ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              isSuggestion
                  ? 'Scroll down to see more$text'
                  : 'Swipe to see more options$text',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.text.labelSmall!.copyWith(
                color: context.theme.dividerColor,
              ),
            ),
          ),
        ),
        if (!isSuggestion)
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: SvgPicture.asset(
              'assets/svgs/left-arrow.svg',
              colorFilter: context.theme.dividerColor.toColorFilter,
              height: 20.0,
              width: 55.0,
              fit: BoxFit.fitWidth,
            ),
          ),
      ],
    );
  }
}
