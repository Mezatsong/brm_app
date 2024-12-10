import 'package:flutter/material.dart';

import '../../../../../domain/entities/enums/e_sheep_stage.dart';
import '../../../../../domain/entities/enums/e_sheep_status.dart';
import '../../../../../domain/entities/enums/e_sheep_survey_status.dart';
import '../../sheep_create_or_update_controller.dart';

class ActivitiesForm extends StatefulWidget {
  final SheepCreateOrUpdateController _ctrl;

  const ActivitiesForm(this._ctrl, {super.key});

  @override
  State<ActivitiesForm> createState() => _ActivitiesFormState();
}

class _ActivitiesFormState extends State<ActivitiesForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total Sessions
        Text(
          'Total Sessions: ${widget._ctrl.totalSessions}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Slider(
          value: widget._ctrl.totalSessions.toDouble(),
          min: 1,
          max: 16,
          divisions: 15,
          label: widget._ctrl.totalSessions.toString(),
          onChanged: (double value) {
            setState(() {
              widget._ctrl.totalSessions = value.toInt();
            });
          },
        ),

        // Sessions Done
        TextFormField(
          initialValue: '0',
          decoration: InputDecoration(labelText: 'Sessions Done'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              widget._ctrl.sessionsDone = int.tryParse(value) ?? 0;
            });
          },
        ),

        // Watering Sessions Done
        TextFormField(
          initialValue: '0',
          decoration: InputDecoration(labelText: 'Watering Sessions Done'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              widget._ctrl.wateringSessionsDone = int.tryParse(value) ?? 0;
            });
          },
        ),

        // Status
        DropdownButtonFormField<ESheepStatus>(
          value: widget._ctrl.status,
          decoration: InputDecoration(labelText: 'Status'),
          items: ESheepStatus.values
              .map((status) =>
                  DropdownMenuItem(value: status, child: Text(status.value)))
              .toList(),
          onChanged: (value) {
            setState(() {
              widget._ctrl.status = value!;
            });
          },
        ),

        // Stage
        DropdownButtonFormField<ESheepStage>(
          value: widget._ctrl.stage,
          decoration: InputDecoration(labelText: 'Stage'),
          items: ESheepStage.values
              .map((stage) =>
                  DropdownMenuItem(value: stage, child: Text(stage.value)))
              .toList(),
          onChanged: (value) {
            setState(() {
              widget._ctrl.stage = value!;
            });
          },
        ),

        // Survey Status
        DropdownButtonFormField<ESheepSurveyStatus>(
          value: widget._ctrl.surveyStatus,
          decoration: InputDecoration(labelText: 'Status sondage'),
          items: ESheepSurveyStatus.values
              .map((surveyStatus) => DropdownMenuItem(
                    value: surveyStatus,
                    child: Text(surveyStatus.value),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              widget._ctrl.surveyStatus = value!;
            });
          },
        ),

        // Abandon Reason (only if status is abandoned)
        if (widget._ctrl.status == ESheepStatus.abandoned) ...[
          TextFormField(
            decoration: InputDecoration(labelText: "Raison de l'abandon"),
            onChanged: (value) {
              setState(() {
                widget._ctrl.abandonReason = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Details sur l'abandon"),
            onChanged: (value) {
              setState(() {
                widget._ctrl.abandonDetails = value;
              });
            },
          ),
        ],
      ],
    );
  }
}
