import 'package:flutter/material.dart';

import '../../utils/extensions/extensions.dart';
import 'shimmer.dart';

class ShimmerContainerLoader extends StatelessWidget {
  const ShimmerContainerLoader({
    super.key,
    this.heights = const [1],
    this.padding = 0.0,
  });

  final List<double> heights;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: List.generate(
            heights.length,
            (idx) => Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Card(
                child: AppShimmer.container(
                  height: context.height * heights[idx],
                  baseColor: context.theme.cardColor,
                  highlightColor: context.theme.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
