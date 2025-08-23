import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer {
  AppShimmer._();
  static Widget circle({Color? baseColor, Color? highlightColor, double? radius}) =>
      Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade200,
        highlightColor: highlightColor ?? Colors.grey.shade100,
        child: CircleAvatar(radius: radius),
      );

  static Widget container({
    double? height,
    double? width,
    double? margin,
    Color? baseColor,
    Color? highlightColor,
    double? radius,
  }) => Shimmer.fromColors(
    baseColor: baseColor ?? Colors.grey.shade200,
    highlightColor: highlightColor ?? Colors.grey.shade100,
    child: Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(margin ?? 0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
