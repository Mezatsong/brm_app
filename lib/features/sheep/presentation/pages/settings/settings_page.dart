import 'package:brm/features/sheep/presentation/pages/settings/widgets/export_bottom_sheet.dart';
import 'package:brm/features/sheep/presentation/pages/settings/widgets/import_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Hive box for storing settings
  late Box _settingsBox;

  // Settings variables with default values
  int _timeToRingBeforeAppointment = 24;
  String _syncFrequency = 'daily';
  bool _usePhoneUnlockScheme = false;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  // Initialize Hive and load settings
  Future<void> _initializeHive() async {
    // Ensure Hive is initialized
    await Hive.initFlutter();

    // Open the settings box
    _settingsBox = await Hive.openBox('settings');

    // Load settings with default values
    setState(() {
      _timeToRingBeforeAppointment =
          _settingsBox.get('timeToRing', defaultValue: 24);
      _syncFrequency = _settingsBox.get('syncFrequency', defaultValue: 'daily');
      _usePhoneUnlockScheme =
          _settingsBox.get('lockWithPhone', defaultValue: false);
    });
  }

  // Save individual setting
  Future<void> _saveSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Time to Ring Before Appointment
          ListTile(
            title: const Text('Time to Ring Before Appointment'),
            subtitle: Text('$_timeToRingBeforeAppointment hours'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_timeToRingBeforeAppointment > 1) {
                        _timeToRingBeforeAppointment--;
                        _saveSetting(
                            'timeToRing', _timeToRingBeforeAppointment);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _timeToRingBeforeAppointment++;
                      _saveSetting('timeToRing', _timeToRingBeforeAppointment);
                    });
                  },
                ),
              ],
            ),
          ),

          // Sync Database Frequency
          ListTile(
            title: const Text('Sync Database Frequency'),
            subtitle: Text(_syncFrequency.capitalizeFirst()),
            trailing: DropdownButton<String>(
              value: _syncFrequency,
              items: ['daily', 'weekly', 'monthly', 'custom']
                  .map((frequency) => DropdownMenuItem(
                        value: frequency,
                        child: Text(frequency.capitalizeFirst()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _syncFrequency = value!;
                  _saveSetting('syncFrequency', _syncFrequency);
                });
              },
            ),
          ),

          // Lock App with Phone Unlock Scheme
          SwitchListTile(
            title: const Text('Lock App with Phone Unlock'),
            subtitle: const Text('Use device unlock method for app access'),
            value: _usePhoneUnlockScheme,
            onChanged: (bool value) {
              setState(() {
                _usePhoneUnlockScheme = value;
                _saveSetting('lockWithPhone', _usePhoneUnlockScheme);
              });
            },
          ),

          // Import
          ListTile(
            title: const Text('Import data'),
            subtitle: Text('Import sheeps and appointments from Excel'),
            trailing: IconButton(
              icon: const Icon(Icons.file_download_outlined),
              onPressed: () => ImportBottomSheet.show(context),
            ),
          ),

          // Export
          ListTile(
            title: const Text('Export data'),
            subtitle: Text('Export sheeps and appointments to Excel'),
            trailing: IconButton(
              icon: const Icon(Icons.file_upload_outlined),
              onPressed: () => ExportBottomSheet.show(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Close the Hive box when the page is disposed
    _settingsBox.close();
    super.dispose();
  }
}

// Extension method to capitalize first letter of a string
extension StringExtension on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
