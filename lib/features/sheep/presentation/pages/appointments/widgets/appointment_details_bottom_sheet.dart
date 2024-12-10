import 'package:brm/core/utils/strings.dart';
import 'package:brm/features/sheep/domain/entities/enums/e_sheep_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/session.dart';
import '../../../../domain/entities/sheep.dart';
import '../../../../domain/usecases/update_session_use_case.dart';
import '../../../helpers/appointment_helpers.dart';

class AppointmentDetailsBottomSheet extends StatefulWidget {
  final Session session;
  final Sheep sheep;

  const AppointmentDetailsBottomSheet({
    required this.session,
    required this.sheep,
    super.key,
  });

  @override
  State<AppointmentDetailsBottomSheet> createState() =>
      _AppointmentDetailsBottomSheetState();
}

class _AppointmentDetailsBottomSheetState
    extends State<AppointmentDetailsBottomSheet> {
  late DateTime _selectedDateTime;
  late ESheepStage _selectedType;
  late String _notes;

  // Appointment types
  final List<ESheepStage> _appointmentTypes = [
    ESheepStage.invitation,
    ESheepStage.survey,
    ESheepStage.witnessing,
    ESheepStage.watering,
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with current session details
    _selectedDateTime = widget.session.appointmentDate;
    _selectedType = widget.session.type;
    _notes = widget.session.notes ?? '';
  }

  // Date and Time Picker
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (!context.mounted) return;

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _updateAppointment() async {
    // Create updated Session object
    final updatedSession = Session(
      id: widget.session.id,
      sheepId: widget.session.sheepId,
      appointmentDate: _selectedDateTime,
      type: _selectedType,
      sessionNumber: widget.session.sessionNumber,
      notes: _notes.isNotEmpty ? _notes : null,
      completed: widget.session.completed,
      completedAt: widget.session.completedAt,
      sheep: widget.session.sheep,
    );

    final result = await Modular.get<UpdateSessionUseCase>().call(
      UpdateSessionParams(session: updatedSession),
    );

    result.fold((failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            failure.message, // "L'Opération a échoué"
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }, (_) {
      Navigator.pop(context, updatedSession);
    });
  }

  void _deleteAppointment() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Suppression'),
          content: const Text('êtes-vous sur de vouloir supprimer ce RDV ?'),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Supprimer'),
              onPressed: () {
                // TODO: Implement delete logic in your repository
                // For example:
                // _sessionRepository.deleteSession(widget.session.id)
                //   .then((_) {
                //     Navigator.of(context).pop(); // Dismiss dialog
                //     Navigator.pop(context, 'deleted'); // Close bottom sheet
                //   })
                //   .catchError((error) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Failed to delete appointment: $error'))
                //     );
                //   });

                // For now, just pop with 'deleted' indicator
                Navigator.of(context).pop();
                Navigator.pop(context, 'deleted');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Appointment Details',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Sheep Information
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Brebis: ${widget.sheep.name}, ${widget.sheep.age}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.info, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Etat: ${widget.sheep.stateSummary}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Appointment Date and Time
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Appointment Date and Time',
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.edit_calendar),
                  onPressed: () => _selectDateTime(context),
                ),
              ),
              readOnly: true,
              controller: TextEditingController(
                text: DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime),
              ),
            ),
            const SizedBox(height: 16),

            // Appointment Type Dropdown
            DropdownButtonFormField<ESheepStage>(
              decoration: const InputDecoration(
                labelText: 'Appointment Type',
                prefixIcon: Icon(Icons.category),
              ),
              value: _selectedType,
              items: _appointmentTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: typeColors[type],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(type.value.capitalize()),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Notes TextField
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes (Optional)',
                prefixIcon: Icon(Icons.notes),
              ),
              initialValue: _notes,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                _notes = value;
              },
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _updateAppointment,
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text(
                      'Mettre à jour',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // TODO:
                /*
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _deleteAppointment,
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'Supprimer',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ), */
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
