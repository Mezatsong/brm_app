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
          'Provider Details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TextFormField(
          controller: _ctrl.providerNameController,
          decoration: InputDecoration(labelText: 'Provider Name'),
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter provider name'
              : null,
        ),
        TextFormField(
          controller: _ctrl.providerPhoneController,
          decoration: InputDecoration(labelText: 'Provider Phone'),
          keyboardType: TextInputType.phone,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter provider phone'
              : null,
        ),
        TextFormField(
          controller: _ctrl.relationWithProviderController,
          decoration: InputDecoration(labelText: 'Relation with Provider'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter relation' : null,
        ),

        // Finder Section
        SizedBox(height: 16),
        Text(
          'Finder Details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        StatefulBuilder(
          builder: (context, setState) => SwitchListTile(
            title: Text('Same as Provider'),
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
          decoration: InputDecoration(labelText: 'Finder Name'),
          enabled: !_ctrl.sameAsPovider,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter finder name'
              : null,
        ),
        TextFormField(
          controller: _ctrl.finderPhoneController,
          decoration: InputDecoration(labelText: 'Finder Phone'),
          keyboardType: TextInputType.phone,
          enabled: !_ctrl.sameAsPovider,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter finder phone'
              : null,
        ),
      ],
    );
  }
}
