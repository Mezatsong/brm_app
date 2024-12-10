import 'package:brm/features/sheep/domain/usecases/export_to_excel_use_case.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExportBottomSheet extends StatefulWidget {
  const ExportBottomSheet._();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => ExportBottomSheet._(),
    );
  }

  @override
  State<ExportBottomSheet> createState() => _ExportBottomSheetState();
}

class _ExportBottomSheetState extends State<ExportBottomSheet> {
  bool _isExporting = false;
  double? _exportProgress;

  void _startExport() async {
    if (_isExporting) return;
    setState(() => _isExporting = true);
    try {
      // Save file
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) return;
      final now = DateTime.now();
      final dt = '${now.year}-${now.month}-${now.day}_${now.hour}${now.second}';
      final filePath = '$selectedDirectory/brm_$dt.xlsx';

      final exportResult = await Modular.get<ExportToExcelUseCase>().call(
        ExportParams(filePath: filePath),
      );

      exportResult.fold(
        (failure) {
          _showErrorDialog("Echec de l'exportation: ${failure.message}");
        },
        (_) async {
          await _showExportSuccessDialog(filePath);
          if (mounted) Navigator.of(context).pop();
        },
      );
    } catch (e) {
      // Show error dialog
      _showErrorDialog('Export failed: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  Future<void> _showExportSuccessDialog(String filePath) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exportées avec succés !'),
        content: Text('Donnée exportées vers $filePath'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showErrorDialog(String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Exportation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Exporter vos données vers un fichier Excel'),
          const SizedBox(height: 16),
          if (!_isExporting)
            ElevatedButton(
              onPressed: _startExport,
              child: const Text("Démarrer l'exportation"),
            )
          else
            Column(
              children: [
                LinearProgressIndicator(value: _exportProgress),
                const SizedBox(height: 8),
                if (_exportProgress != null)
                  Text(
                    'Exportation... ${(_exportProgress! * 100).toStringAsFixed(0)}%',
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
