part of '../sheep_list_page.dart';

class _FilterBottomSheetModal extends StatefulWidget {
  final ESheepStatus? selectedStatus;
  final void Function(ESheepStatus?) onStatusChanged;

  final ESheepStage? selectedStage;
  final void Function(ESheepStage?) onStageChanged;

  final ESheepSurveyStatus? selectedSurveyStatus;
  final void Function(ESheepSurveyStatus?) onSurveyStatusChanged;

  final VoidCallback applyFilters;

  const _FilterBottomSheetModal({
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.selectedStage,
    required this.onStageChanged,
    required this.selectedSurveyStatus,
    required this.onSurveyStatusChanged,
    required this.applyFilters,
  });

  static Future<void> show(
    BuildContext context, {
    required ESheepStatus? selectedStatus,
    required void Function(ESheepStatus?) onStatusChanged,
    required ESheepStage? selectedStage,
    required void Function(ESheepStage?) onStageChanged,
    required ESheepSurveyStatus? selectedSurveyStatus,
    required void Function(ESheepSurveyStatus?) onSurveyStatusChanged,
    required VoidCallback applyFilters,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheetModal(
        selectedStatus: selectedStatus,
        onStatusChanged: onStatusChanged,
        selectedStage: selectedStage,
        onStageChanged: onStageChanged,
        selectedSurveyStatus: selectedSurveyStatus,
        onSurveyStatusChanged: onSurveyStatusChanged,
        applyFilters: applyFilters,
      ),
    );
  }

  @override
  State<_FilterBottomSheetModal> createState() =>
      _FilterBottomSheetModalState();
}

class _FilterBottomSheetModalState extends State<_FilterBottomSheetModal> {
  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        value: value,
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text((item as dynamic).value),
              ),
            )
            .toList(),
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Filtres',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Status Filter
          _buildDropdown<ESheepStatus>(
            label: 'Statut',
            items: ESheepStatus.values,
            value: widget.selectedStatus,
            onChanged: (value) => setState(() => widget.onStatusChanged(value)),
          ),

          // Stage Filter
          _buildDropdown<ESheepStage>(
            label: 'Étape',
            items: ESheepStage.values,
            value: widget.selectedStage,
            onChanged: (value) => setState(() => widget.onStageChanged(value)),
          ),

          // Survey Status Filter
          _buildDropdown<ESheepSurveyStatus>(
            label: 'Statut du Sondage',
            items: ESheepSurveyStatus.values,
            value: widget.selectedSurveyStatus,
            onChanged: (v) => setState(() => widget.onSurveyStatusChanged(v)),
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              widget.applyFilters();
              Navigator.pop(context);
            },
            child: const Text('Appliquer les filtres'),
          ),
        ],
      ),
    );
  }
}
