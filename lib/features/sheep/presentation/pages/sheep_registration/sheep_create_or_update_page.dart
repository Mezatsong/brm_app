import 'package:brm/features/sheep/domain/entities/sheep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import 'sheep_create_or_update_controller.dart';

class SheepCreateOrUpdatePage extends StatelessWidget {
  static const pageRoute = '/sheep_create_or_update';

  final Sheep? editingSheep;

  const SheepCreateOrUpdatePage({this.editingSheep, super.key});

  @override
  Widget build(BuildContext context) {
    final title = editingSheep != null
        ? 'Edition de la brebis #${editingSheep?.id}'
        : "Création d'une brebis";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ScreenControllerBuilder(
        create: (state) => SheepCreateOrUpdateController(
          state,
          Modular.get(),
          Modular.get(),
          editingSheep: editingSheep,
        ),
        builder: (context, ctrl) => Stack(
          children: [
            Stepper(
              currentStep: ctrl.currentStep,
              onStepContinue: ctrl.onStepContinue,
              onStepCancel: ctrl.onStepCancel,
              steps: ctrl.buildSteps(),
            ),

            // Loading indicator
            if (ctrl.isSubmitting)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black54,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
