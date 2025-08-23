// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeProfileAdapter extends TypeAdapter<ThemeProfile> {
  @override
  final typeId = 0;

  @override
  ThemeProfile read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeProfile.system;
      case 1:
        return ThemeProfile.light;
      case 2:
        return ThemeProfile.dark;
      default:
        return ThemeProfile.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeProfile obj) {
    switch (obj) {
      case ThemeProfile.system:
        writer.writeByte(0);
      case ThemeProfile.light:
        writer.writeByte(1);
      case ThemeProfile.dark:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
