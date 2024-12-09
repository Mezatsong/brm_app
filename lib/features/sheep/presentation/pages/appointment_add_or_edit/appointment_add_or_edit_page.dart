import 'package:brm/core/utils/strings.dart';
import 'package:brm/features/sheep/domain/entities/enums/e_sheep_stage.dart';
import 'package:brm/features/sheep/domain/entities/session.dart';
import 'package:brm/features/sheep/presentation/pages/appointment_add_or_edit/appointment_add_or_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/sheep.dart';
import '../../helpers/appointment_helpers.dart';

class AppointmentAddOrEditPageArgs {
  final Sheep sheep;
  final Session? editingSession;

  AppointmentAddOrEditPageArgs.create(this.sheep) : editingSession = null;

  AppointmentAddOrEditPageArgs.edit(this.sheep, Session this.editingSession);
}

class AppointmentAddOrEditPage extends StatelessWidget {
  final Sheep sheep;
  final Session? editingSession;

  static String pageRoute = 'appointment_add_or_edit';

  AppointmentAddOrEditPage(
    AppointmentAddOrEditPageArgs args, {
    super.key,
  })  : sheep = args.sheep,
        editingSession = args.editingSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Appointment for ${sheep.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ScreenControllerBuilder(
          create: (s) => AppointmentAddOrEditController(s, sheep: sheep),
          builder: (context, ctrl) => Form(
            key: ctrl.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sheep Information Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details sur la brebis',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Text('Nom & Age: ${sheep.name}, ${sheep.age}'),
                        Text('Etape: ${sheep.stateSummary}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Appointment Date and Time
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date & Heure du RDV',
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.edit_calendar),
                      onPressed: () => ctrl.selectDateTime(context),
                    ),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text: DateFormat('yyyy-MM-dd HH:mm')
                        .format(ctrl.selectedDateTime),
                  ),
                  validator: (value) {
                    if (ctrl.selectedDateTime.isBefore(DateTime.now())) {
                      return 'Le RDV ne peut pas être dans le passé 😂';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Appointment Type Dropdown
                DropdownButtonFormField<ESheepStage>(
                  decoration: const InputDecoration(
                    labelText: 'Type de RDV',
                    prefixIcon: Icon(Icons.category),
                  ),
                  value: ctrl.selectedType,
                  hint: const Text('Choix du type de RDV'),
                  items: ctrl.appointmentTypes.map(
                    (type) {
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
                    },
                  ).toList(),
                  onChanged: ctrl.onSelectedType,
                  validator: (value) {
                    if (value == null) {
                      return 'Svp choisissez le type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Notes TextField
                TextFormField(
                  controller: ctrl.notesCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Notes (Optionel)',
                    prefixIcon: Icon(Icons.notes),
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton(
                  onPressed: ctrl.submitAppointment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Soumettre'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
