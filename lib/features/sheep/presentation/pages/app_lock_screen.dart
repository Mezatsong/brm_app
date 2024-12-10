import 'package:brm/features/sheep/presentation/pages/home/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';

import '../helpers/setting_service.dart';

class AppLockScreen extends StatefulWidget {
  static const pageRoute = '/lock';

  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen>
    with WidgetsBindingObserver {
  final _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _performAuthentication();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!SettingService.getAppLock() || kIsWeb) return;

    if (state == AppLifecycleState.resumed) {
      _performAuthentication();
    }
  }

  Future<void> _performAuthentication() async {
    try {
      // Check if device supports authentication
      final canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        await _showAuthenticationError('Device not supported');
        return;
      }

      // Attempt authentication
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'BRM',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allows device PIN/pattern
        ),
      );

      if (didAuthenticate) {
        Modular.to.pushNamedAndRemoveUntil(HomePage.pageRoute, (_) => false);
      } else {
        await _showAuthenticationError('Authentication failed');
      }
    } on PlatformException catch (e) {
      _showAuthenticationError('Authentication error: ${e.code}');
    }
  }

  Future<void> _showAuthenticationError(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Authentication Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _performAuthentication();
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              // Close the app
              SystemNavigator.pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'App Locked',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please authenticate to continue',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performAuthentication,
              child: const Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}
