import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';
import 'features/sheep/presentation/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    // imageCache.clear();
    FutureBuilder.debugRethrowError = true;
  } else {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
