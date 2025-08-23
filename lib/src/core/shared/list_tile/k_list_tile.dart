import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../config/size.dart';
import '../../utils/extensions/extensions.dart';

class KListTile extends StatelessWidget {
  const KListTile({
    super.key,
    this.onTap,
    this.title,
    this.leading,
    this.padding,
    this.trailing,
    this.subtitle,
    this.selected,
    this.onEditTap,
    this.onDeleteTap,
    this.onDoubleTap,
    this.onLongPress,
    this.selectedColor,
    this.slidableAction,
    this.canEdit = true,
    this.crossAxisAlignment,
    this.paddingBetweenTitleAndSubtitle,
    this.paddingBetweenLeadingAndContent,
  });

  final bool canEdit;
  final Widget? title;
  final bool? selected;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final Color? selectedColor;
  final Widget? slidableAction;
  final void Function()? onTap;
  final void Function()? onEditTap;
  final EdgeInsetsGeometry? padding;
  final void Function()? onDeleteTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final double? paddingBetweenTitleAndSubtitle;
  final double? paddingBetweenLeadingAndContent;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: context.theme.primaryColor.withValues(alpha: 0.5),
      splashColor: context.theme.primaryColor.withValues(alpha: 0.5),
      borderRadius: defaultBorderRadius,
      radius: 30,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: key == null
          ? _Tile(
              selected: selected,
              padding: padding,
              leading: leading,
              title: title,
              subtitle: subtitle,
              selectedColor: selectedColor,
              paddingBetweenTitleAndSubtitle: paddingBetweenTitleAndSubtitle,
              trailing: trailing,
              crossAxisAlignment: crossAxisAlignment ?? crossCenter,
              paddingBetweenLeadingAndContent: paddingBetweenLeadingAndContent,
            )
          : _Tile(
              selected: selected,
              padding: padding,
              leading: leading,
              title: title,
              subtitle: subtitle,
              selectedColor: selectedColor,
              paddingBetweenTitleAndSubtitle: paddingBetweenTitleAndSubtitle,
              trailing: trailing,
              crossAxisAlignment: crossAxisAlignment ?? crossCenter,
              paddingBetweenLeadingAndContent: paddingBetweenLeadingAndContent,
            ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.selected,
    required this.padding,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.paddingBetweenTitleAndSubtitle,
    required this.trailing,
    this.selectedColor,
    required this.crossAxisAlignment,
    required this.paddingBetweenLeadingAndContent,
  });

  final bool? selected;
  final EdgeInsetsGeometry? padding;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Color? selectedColor;
  final double? paddingBetweenTitleAndSubtitle;
  final Widget? trailing;
  final CrossAxisAlignment crossAxisAlignment;
  final double? paddingBetweenLeadingAndContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected == true
            ? (selectedColor ?? context.theme.primaryColor.withValues(alpha: 0.2))
            : null,
        borderRadius: defaultBorderRadius,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        child: Row(
          mainAxisAlignment: mainCenter,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            leading ?? const SizedBox.shrink(),
            SizedBox(width: paddingBetweenLeadingAndContent ?? 10),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisSize: mainMin,
                crossAxisAlignment: crossStart,
                children: [
                  title ?? const SizedBox.shrink(),
                  if (subtitle != null) SizedBox(height: paddingBetweenTitleAndSubtitle ?? 2.0),
                  subtitle ?? const SizedBox.shrink(),
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
