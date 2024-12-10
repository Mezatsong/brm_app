import 'package:brm/features/sheep/presentation/helpers/setting_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class DeviceAuthWrapper extends StatefulWidget {
  final Widget child;

  const DeviceAuthWrapper({required this.child, super.key});

  @override
  State<DeviceAuthWrapper> createState() => _DeviceAuthWrapperState();
}

class _DeviceAuthWrapperState extends State<DeviceAuthWrapper>
    with WidgetsBindingObserver {
  final _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    if (SettingService.getAppLock() && !kIsWeb) {
      WidgetsBinding.instance.addObserver(this);
      _checkAuthentication();
    } else {
      _isAuthenticated = true;
    }
  }

  @override
  void dispose() {
    if (SettingService.getAppLock() && !kIsWeb) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!SettingService.getAppLock() && !kIsWeb) return;

    if (state == AppLifecycleState.paused) {
      setState(() => _isAuthenticated = false);
    } else if (state == AppLifecycleState.resumed) {
      _checkAuthentication();
    }
  }

  Future<void> _checkAuthentication() async {
    try {
      // Check if device supports authentication
      final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      final availableBiometrics = await _localAuth.getAvailableBiometrics();

      if (!canAuthenticate) {
        setState(() => _isAuthenticated = true);
        await _showAuthenticationError('Device not supported');
        setState(() => _isAuthenticated = true);
        return;
      }

      if (availableBiometrics.isEmpty) {
        // If no biometric options, show error
        await _showAuthenticationError('No authentication methods available');
        setState(() => _isAuthenticated = true);
        return;
      }

      // Attempt authentication
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Authentifiez vous svp',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allows device PIN/pattern
        ),
      );

      if (didAuthenticate) {
        setState(() => _isAuthenticated = true);
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
              _checkAuthentication();
            },
            child: const Text('Re-essayez'),
          ),
          TextButton(
            onPressed: () {
              // Close the app or handle as needed
              SystemNavigator.pop();
            },
            child: const Text('Quittez'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) return widget.child;

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock, size: 100),
            Text('Authentification...'),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
