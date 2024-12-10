import 'package:flutter/material.dart';

import '../../sheep_create_or_update_controller.dart';

class ProviderAndFinderForm extends StatelessWidget {
  final SheepCreateOrUpdateController _ctrl;

  const ProviderAndFinderForm(this._ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Provider Section
        Text(
          'Details sur le fournisseur',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TextFormField(
          controller: _ctrl.providerNameController,
          decoration: InputDecoration(labelText: 'Nom du fournisseur'),
          validator: (value) => value == null || value.isEmpty
              ? 'Entrer le nom du fournisseur'
              : null,
        ),
        TextFormField(
          controller: _ctrl.providerPhoneController,
          decoration: InputDecoration(labelText: 'Tel du fournisseur'),
          keyboardType: TextInputType.phone,
          validator: (value) => value == null || value.isEmpty
              ? 'Entrer le telephone du fournisseur'
              : null,
        ),
        TextFormField(
          controller: _ctrl.relationWithProviderController,
          decoration:
              InputDecoration(labelText: 'Relation avec le fournisseur'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Champ obligatoire' : null,
        ),

        // Finder Section
        SizedBox(height: 16),
        Text(
          'Details sur le chercheur',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        StatefulBuilder(
          builder: (context, setState) => SwitchListTile(
            title: Text('Fournisseur = chercheur'),
            value: _ctrl.sameAsPovider,
            onChanged: (bool value) {
              setState(() {
                _ctrl.sameAsPovider = value;
                if (value) {
                  _ctrl.finderNameController.text =
                      _ctrl.providerNameController.text;
                  _ctrl.finderPhoneController.text =
                      _ctrl.providerPhoneController.text;
                }
              });
            },
          ),
        ),
        TextFormField(
          controller: _ctrl.finderNameController,
          decoration: InputDecoration(labelText: 'Nom du chercheur'),
          enabled: !_ctrl.sameAsPovider,
          validator: (value) => value == null || value.isEmpty
              ? 'Entrer le nom du chercheur'
              : null,
        ),
        TextFormField(
          controller: _ctrl.finderPhoneController,
          decoration: InputDecoration(labelText: 'Tel duu chercheur'),
          keyboardType: TextInputType.phone,
          enabled: !_ctrl.sameAsPovider,
          validator: (value) => value == null || value.isEmpty
              ? 'Numéro du telephone du chercheur'
              : null,
        ),
      ],
    );
  }
}
