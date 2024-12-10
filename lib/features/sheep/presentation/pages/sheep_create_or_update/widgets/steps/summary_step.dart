import 'package:brm/core/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/entities/enums/e_sheep_status.dart';
import '../../sheep_create_or_update_controller.dart';

class SummaryStep extends StatelessWidget {
  final SheepCreateOrUpdateController _ctrl;

  const SummaryStep(this._ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    final labelStyle =
        textTheme.titleMedium?.copyWith(decoration: TextDecoration.underline);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Infos. Personel:', style: titleStyle),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Nom: ', style: labelStyle),
            TextSpan(text: _ctrl.nameController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Telephone: ', style: labelStyle),
            TextSpan(text: _ctrl.phoneController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(
              text: 'Disponible sur WhatsApp: ',
              style: labelStyle,
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
            TextSpan(text: 'Age: ', style: labelStyle),
            TextSpan(text: _ctrl.ageController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Adresse: ', style: labelStyle),
            TextSpan(text: _ctrl.addressController.text),
          ],
        )),
        SizedBox(height: 16),
        Text('Details fournisseur:', style: titleStyle),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Nom: ', style: labelStyle),
            TextSpan(text: _ctrl.providerNameController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Telephone: ', style: labelStyle),
            TextSpan(text: _ctrl.providerPhoneController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Relation: ', style: labelStyle),
            TextSpan(text: _ctrl.relationWithProviderController.text),
          ],
        )),
        SizedBox(height: 16),
        Text('Details chercheur:', style: titleStyle),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Nom: ', style: labelStyle),
            TextSpan(text: _ctrl.finderNameController.text),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Telephone: ', style: labelStyle),
            TextSpan(text: _ctrl.finderPhoneController.text),
          ],
        )),
        SizedBox(height: 16),
        Text('Activités:', style: titleStyle),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Total des sujets: ', style: labelStyle),
            TextSpan(text: _ctrl.totalSessions.toString()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Sujets fait: ', style: labelStyle),
            TextSpan(text: _ctrl.sessionsDone.toString()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(
              text: "Sessions d'arrosage faites: ",
              style: labelStyle,
            ),
            TextSpan(text: _ctrl.wateringSessionsDone.toString()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Status: ', style: labelStyle),
            TextSpan(text: _ctrl.status.value.capitalize()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Etape: ', style: labelStyle),
            TextSpan(text: _ctrl.stage.value.capitalize()),
          ],
        )),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: 'Status Sondage: ', style: labelStyle),
            TextSpan(
              text: _ctrl.surveyStatus.value.replaceAll('_', ' ').capitalize(),
            ),
          ],
        )),
        if (_ctrl.status == ESheepStatus.abandoned) ...[
          Text.rich(TextSpan(
            children: [
              TextSpan(text: 'Abandon Reason: ', style: labelStyle),
              TextSpan(text: _ctrl.abandonReason ?? "N/A"),
            ],
          )),
          Text.rich(TextSpan(
            children: [
              TextSpan(text: 'Abandon Details: ', style: labelStyle),
              TextSpan(text: _ctrl.abandonDetails ?? "N/A"),
            ],
          )),
        ],
      ],
    );
  }
}
