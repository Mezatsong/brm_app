import 'package:flutter/material.dart';

import '../../../../../domain/entities/enums/e_sheep_status.dart';
import '../../sheep_create_or_update_controller.dart';

class SummaryStep extends StatelessWidget {
  final SheepCreateOrUpdateController _ctrl;

  const SummaryStep(this._ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Info:', style: textTheme.titleLarge),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Name: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.nameController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Phone: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.phoneController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(
              text: 'Disponible sur WhatsApp: ',
              style: textTheme.titleMedium,
            ),
            TextSpan(
              text: _ctrl.isWhatsAppNumber ? "Oui" : "Non",
              style: _ctrl.isWhatsAppNumber
                  ? TextStyle(color: Colors.green)
                  : null,
            ),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Age: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.ageController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Address: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.addressController.text),
          ],
        )),
        SizedBox(height: 16),
        Text('Provider Details:', style: textTheme.titleLarge),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Name: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.providerNameController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Phone: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.providerPhoneController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Relation: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.relationWithProviderController.text),
          ],
        )),
        SizedBox(height: 16),
        Text('Finder Details:', style: textTheme.titleLarge),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Name: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.finderNameController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Phone: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.finderPhoneController.text),
          ],
        )),
        SizedBox(height: 16),
        Text('Activities:', style: textTheme.titleLarge),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Total Sessions: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.totalSessions.toString()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Sessions Done: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.sessionsDone.toString()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(
              text: 'Watering Sessions Done: ',
              style: textTheme.titleMedium,
            ),
            TextSpan(text: _ctrl.wateringSessionsDone.toString()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Status: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.status.value),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Stage: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.stage.value),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Survey Status: ', style: textTheme.titleMedium),
            TextSpan(text: _ctrl.surveyStatus.value.replaceAll('_', ' ')),
          ],
        )),
        if (_ctrl.status == ESheepStatus.abandoned) ...[
          Text.rich(TextSpan(
            children: [
              TextSpan(text: 'Abandon Reason: ', style: textTheme.titleMedium),
              TextSpan(text: _ctrl.abandonReason ?? "N/A"),
            ],
          )),
          Text.rich(TextSpan(
            children: [
              TextSpan(text: 'Abandon Details: ', style: textTheme.titleMedium),
              TextSpan(text: _ctrl.abandonDetails ?? "N/A"),
            ],
          )),
        ],
      ],
    );
  }
}
