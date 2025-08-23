import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart' show App;
import 'src/core/initilizer/initializer.dart';


void main() async => Initializer.init(() => runApp(ProviderScope(child: App())));
