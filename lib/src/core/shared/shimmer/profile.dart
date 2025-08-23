import 'package:flutter/material.dart';

import '../../utils/extensions/extensions.dart';
import 'shimmer.dart';

class ShimmerProfileLoader extends StatelessWidget {
  const ShimmerProfileLoader({super.key, this.length = 10});

  final int length;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppShimmer.circle(
            radius: 50,
            baseColor: context.theme.cardColor,
            highlightColor: context.theme.scaffoldBackgroundColor,
          ),
          const SizedBox(height: 15),
          ...List.generate(
            length,
            (idx) => Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Card(
                child: AppShimmer.container(
                  height: 80,
                  baseColor: context.theme.cardColor,
                  highlightColor: context.theme.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
