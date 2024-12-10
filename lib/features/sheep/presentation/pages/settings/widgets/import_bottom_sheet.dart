import 'package:brm/features/sheep/domain/usecases/import_from_excel_use_case.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ImportBottomSheet extends StatefulWidget {
  const ImportBottomSheet._();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => ImportBottomSheet._(),
    );
  }

  @override
  State<ImportBottomSheet> createState() => _ImportBottomSheetState();
}

class _ImportBottomSheetState extends State<ImportBottomSheet> {
  bool _isImporting = false;
  double? _importProgress;

  Future<void> _startImport() async {
    if (_isImporting) return;
    setState(() => _isImporting = true);

    try {
      // Pick Excel file
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (filePickerResult == null) return;
      final bytes = await filePickerResult.xFiles.first.readAsBytes();
      final importResult = await Modular.get<ImportFromExcelUseCase>().call(
        ImportParams(bytes: bytes),
      );

      importResult.fold(
        (failure) {
          _showErrorDialog('Import failed: ${failure.message}');
        },
        (_) async {
          await _showImportSuccessDialog();
          if (mounted) Navigator.of(context).pop();
        },
      );
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      _showErrorDialog('Import failed: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  Future<void> _showImportSuccessDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Importé avec succès !'),
        content: const Text('Donnée exportées avec succès !.'),
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
            'Importation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Choisissez un fichier Excel à importer'),
          const SizedBox(height: 16),
          if (!_isImporting)
            ElevatedButton(
              onPressed: _startImport,
              child: const Text("Démarrer l'importation"),
            )
          else
            Column(
              children: [
                LinearProgressIndicator(value: _importProgress),
                const SizedBox(height: 8),
                if (_importProgress != null)
                  Text(
                    'Importation... ${(_importProgress! * 100).toStringAsFixed(0)}%',
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
