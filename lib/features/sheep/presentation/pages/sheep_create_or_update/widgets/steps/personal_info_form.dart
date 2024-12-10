import 'package:flutter/material.dart';

import '../../sheep_create_or_update_controller.dart';

class PersonalInfoForm extends StatelessWidget {
  final SheepCreateOrUpdateController _ctrl;

  const PersonalInfoForm(this._ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _ctrl.personalInfoFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _ctrl.nameController,
            decoration: InputDecoration(labelText: 'Nom'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Svp entrer un nom' : null,
          ),
          TextFormField(
            controller: _ctrl.phoneController,
            decoration: InputDecoration(labelText: 'Téléphone'),
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.isEmpty
                ? 'Svp entrer un numéro de telephone'
                : null,
          ),
          StatefulBuilder(
            builder: (context, setState) => SwitchListTile(
              title: Text(
                'Numéro disponible aussi sur WhatsApp',
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              value: _ctrl.isWhatsAppNumber,
              onChanged: (bool value) {
                setState(() {
                  _ctrl.isWhatsAppNumber = value;
                });
              },
            ),
          ),
          TextFormField(
            controller: _ctrl.ageController,
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            validator: (value) =>
                value == null || value.isEmpty ? "Entrer l'âge" : null,
          ),
          TextFormField(
            controller: _ctrl.addressController,
            decoration: InputDecoration(labelText: 'Adresse'),
            validator: (value) =>
                value == null || value.isEmpty ? "Entrer l'adresse" : null,
          ),
        ],
      ),
    );
  }
}
