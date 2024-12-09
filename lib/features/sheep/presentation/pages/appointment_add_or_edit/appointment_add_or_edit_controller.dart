import 'package:brm/features/sheep/domain/entities/enums/e_sheep_stage.dart';
import 'package:brm/features/sheep/domain/usecases/add_session_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import '../../../domain/entities/session.dart';
import '../../../domain/entities/sheep.dart';
import '../home/home_page.dart';

class AppointmentAddOrEditController extends ScreenController {
  AppointmentAddOrEditController(
    super.state, {
    required this.sheep,
    this.editingSession,
  });

  final Sheep sheep;
  final Session? editingSession;

  final formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;
  // Form controllers
  late DateTime selectedDateTime;
  ESheepStage? _selectedType;
  final notesCtrl = TextEditingController();

  // Appointment types
  final List<ESheepStage> appointmentTypes = [
    ESheepStage.invitation,
    ESheepStage.survey,
    ESheepStage.witnessing,
    ESheepStage.watering,
  ];

  ESheepStage? get selectedType => _selectedType;

  bool get isSubmitting => _isSubmitting;

  @override
  @protected
  void onInit() {
    // Initialize with current date and time
    selectedDateTime = DateTime.now().add(const Duration(hours: 1));
    // Update
    // Personal Info Fields
    final session = editingSession;
    if (session != null) {
      selectedDateTime = session.appointmentDate;
      _selectedType = session.type;
      notesCtrl.text = session.notes ?? '';
    }
  }

  void onSelectedType(ESheepStage? newType) {
    _selectedType = newType;
    refreshUI();
  }

  // Calculate the next session number
  int _calculateNextSessionNumber(Sheep sheep) {
    return sheep.sessionsDone + 1;
  }

  // Date and Time Picker
  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (!context.mounted) return;

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        updateUI(() {
          selectedDateTime = DateTime(
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

  void submitAppointment() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      final type = _selectedType;
      final appointmentDate = selectedDateTime;

      // Validate type selection
      if (type == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Svp veillir choisir le type du RDV')),
        );
        return;
      }

      final sessionToSave = Session(
        id: editingSession?.id ?? 0, // Will be assigned by database if 0
        sheepId: sheep.id,
        appointmentDate: appointmentDate,
        type: type,
        sessionNumber: _calculateNextSessionNumber(sheep),
        notes: notesCtrl.text.isNotEmpty ? notesCtrl.text : null,
        completed: editingSession?.completed ?? false,
        completedAt: editingSession?.completedAt,
        sheep: sheep,
      );

      updateUI(() => _isSubmitting = true);

      final result = editingSession == null
          ? await Modular.get<AddSessionUseCase>().call(
              AddSessionParams(session: sessionToSave),
            )
          : await Modular.get<AddSessionUseCase>().call(
              // TODO put the right
              AddSessionParams(session: sessionToSave),
            );

      result.fold((failure) {
        updateUI(() => _isSubmitting = false);
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Brebis ${editingSession != null ? "mise à jour" : "enregistré"} avec succès !',
            ),
          ),
        );
        if (Modular.to.canPop()) {
          Modular.to.pop();
        } else {
          Modular.to.pushNamed(
            HomePage.pageRoute,
            arguments: HomePageArguments.appointments,
          );
        }
      });
    }
  }
}
