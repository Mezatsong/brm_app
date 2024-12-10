import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/device_auth_wrapper.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BRM',
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      builder: (context, child) => DeviceAuthWrapper(child: child!),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,

      // routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}
