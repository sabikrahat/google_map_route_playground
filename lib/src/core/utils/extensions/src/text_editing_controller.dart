part of '../extensions.dart';

extension TextEditingControllerUtils on TextEditingController {
  String? get textOrNull => text.trim().isEmpty ? null : text;
}
