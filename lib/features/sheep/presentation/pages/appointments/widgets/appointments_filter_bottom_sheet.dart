import 'package:brm/core/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/enums/e_sheep_stage.dart';

class AppointmentsFilterBottomSheet extends StatefulWidget {
  final bool showCompletedSessions;
  final void Function(bool) onShowCompletedSessionsChanged;

  final ESheepStage? selectedType;
  final void Function(ESheepStage?) onSelectedTypeChanged;

  const AppointmentsFilterBottomSheet({
    required this.showCompletedSessions,
    required this.onShowCompletedSessionsChanged,
    this.selectedType,
    required this.onSelectedTypeChanged,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AppointmentsFilterBottomSheetState();
}

class _AppointmentsFilterBottomSheetState
    extends State<AppointmentsFilterBottomSheet> {
  void _refresh() => setState(() {});

  void _onShowCompletedSessionsChanged(bool value) {
    widget.onShowCompletedSessionsChanged(value);
    _refresh();
  }

  void _onSelectedTypeChanged(ESheepStage? newType) {
    widget.onSelectedTypeChanged(newType);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: const Text('Show Completed Sessions'),
            value: widget.showCompletedSessions,
            onChanged: _onShowCompletedSessionsChanged,
          ),
          DropdownButtonFormField<ESheepStage>(
            decoration: const InputDecoration(
              labelText: 'Filter by Type',
            ),
            value: widget.selectedType,
            onChanged: _onSelectedTypeChanged,
            items: [
              const DropdownMenuItem<ESheepStage>(
                value: null,
                child: Text('All Types'),
              ),
              ...(ESheepStage.values.map((ESheepStage type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.value.capitalize()),
                );
              }).toList())
            ],
          ),
        ],
      ),
    );
  }
}
