import 'package:brm/features/sheep/presentation/pages/settings/widgets/export_bottom_sheet.dart';
import 'package:brm/features/sheep/presentation/pages/settings/widgets/import_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../helpers/setting_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    SettingService.ensureInitialized();
  }

  // Save individual setting
  Future<void> _loadingWrapper(Future setSettingfuture) async {
    setState(() => _isLoading = true);
    await setSettingfuture;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Visibility(
        visible: !_isLoading,
        replacement: Center(child: CircularProgressIndicator.adaptive()),
        child: ListView(
          children: [
            /*
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
            subtitle: Text(_syncFrequency.capitalize()),
            trailing: DropdownButton<String>(
              value: _syncFrequency,
              items: ['daily', 'weekly', 'monthly', 'custom']
                  .map((frequency) => DropdownMenuItem(
                        value: frequency,
                        child: Text(frequency.capitalize()),
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
*/
            // Lock App with Phone Unlock Scheme
            SwitchListTile(
              title: const Text('Lock App with Phone Unlock'),
              subtitle: const Text('Use device unlock method for app access'),
              value: SettingService.getAppLock(),
              onChanged: (bool value) {
                _loadingWrapper(SettingService.setAppLock(value));
              },
            ),

            // Import
            ListTile(
              title: const Text('Import data'),
              subtitle: Text('Import sheeps and appointments from Excel'),
              trailing: IconButton(
                icon: const Icon(Icons.file_download_outlined),
                onPressed: () {
                  _loadingWrapper(ImportBottomSheet.show(context));
                },
              ),
            ),

            // Export
            ListTile(
              title: const Text('Export data'),
              subtitle: Text('Export sheeps and appointments to Excel'),
              trailing: IconButton(
                icon: const Icon(Icons.file_upload_outlined),
                onPressed: () {
                  _loadingWrapper(ExportBottomSheet.show(context));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
