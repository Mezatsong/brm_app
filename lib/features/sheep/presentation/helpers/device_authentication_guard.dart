import 'package:brm/features/sheep/presentation/helpers/setting_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

import '../pages/app_lock_screen.dart';

class DeviceAuthenticationGuard extends RouteGuard {
  final _localAuth = LocalAuthentication();

  DeviceAuthenticationGuard() : super(redirectTo: AppLockScreen.pageRoute);

  @override
  Future<bool> canActivate(String path, ParallelRoute route) async {
    await SettingService.ensureInitialized();

    if (!SettingService.getAppLock() || kIsWeb) return true;

    try {
      // Check if device supports authentication
      final canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        // If no biometric options, allow access
        return true;
      }

      // Attempt authentication
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'BRM',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allows device PIN/pattern
        ),
      );

      return didAuthenticate;
    } on PlatformException {
      // In case of any authentication error, redirect to lock screen
      return false;
    }
  }
}
