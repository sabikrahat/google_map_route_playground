import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/settings_model.dart';
import '../model/theme/theme_model.dart';
import 'settings_provider.dart';

typedef ThemeNotifier = NotifierProvider<ThemeProvider, ThemeProfile>;

final themeProvider = ThemeNotifier(ThemeProvider.new);

class ThemeProvider extends Notifier<ThemeProfile> {
  @override
  ThemeProfile build() => ref.watch(settingsProvider.select((v) => v.theme));

  ThemeProfile get theme => state;

  Future<void> changeTheme(ThemeProfile theme) async =>
      await ref.read(settingsProvider).copyWith(theme: theme).saveData();
}
