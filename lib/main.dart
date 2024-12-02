import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_module.dart';
import 'features/sheep/presentation/app_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fr_FR';
  await initializeDateFormatting(Intl.defaultLocale);

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
