import 'package:flutter/material.dart';

import '../../../../../domain/entities/sheep.dart';
import '../../sheep_create_or_update_controller.dart';

class SummaryStep extends StatelessWidget {
  final SheepCreateOrUpdateController _ctrl;

  const SummaryStep(this._ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Info:', style: Theme.of(context).textTheme.titleMedium),
        Text('Name: ${_ctrl.nameController.text}'),
        Text('Phone: ${_ctrl.phoneController.text}'),
        Text(
          'Disponible sur WhatsApp: ${_ctrl.isWhatsAppNumber ? "Oui" : "Non"}',
        ),
        Text('Age: ${_ctrl.ageController.text}'),
        Text('Address: ${_ctrl.addressController.text}'),
        SizedBox(height: 16),
        Text('Provider Details:',
            style: Theme.of(context).textTheme.titleMedium),
        Text('Name: ${_ctrl.providerNameController.text}'),
        Text('Phone: ${_ctrl.providerPhoneController.text}'),
        Text('Relation: ${_ctrl.relationWithProviderController.text}'),
        SizedBox(height: 16),
        Text('Finder Details:', style: Theme.of(context).textTheme.titleMedium),
        Text('Name: ${_ctrl.finderNameController.text}'),
        Text('Phone: ${_ctrl.finderPhoneController.text}'),
        SizedBox(height: 16),
        Text('Activities:', style: Theme.of(context).textTheme.titleMedium),
        Text('Total Sessions: $_ctrl.totalSessions'),
        Text('Sessions Done: $_ctrl.sessionsDone'),
        Text('Watering Sessions Done: $_ctrl.wateringSessionsDone'),
        Text('Status: $_ctrl.status'),
        Text('Stage: $_ctrl.stage'),
        Text('Survey Status: $_ctrl.surveyStatus'),
        if (_ctrl.status == ESheepStatus.abandoned) ...[
          Text('Abandon Reason: ${_ctrl.abandonReason ?? "N/A"}'),
          Text('Abandon Details: ${_ctrl.abandonDetails ?? "N/A"}'),
        ],
      ],
    );
  }
}
