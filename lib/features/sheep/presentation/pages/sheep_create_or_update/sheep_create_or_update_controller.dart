import 'package:brm/features/sheep/domain/usecases/add_sheep_use_case.dart';
import 'package:brm/features/sheep/domain/usecases/update_sheep_use_case.dart';
import 'package:brm/features/sheep/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import '../../../domain/entities/enums/e_sheep_stage.dart';
import '../../../domain/entities/enums/e_sheep_status.dart';
import '../../../domain/entities/enums/e_sheep_survey_status.dart';
import '../../../domain/entities/sheep.dart';
import 'widgets/steps/activities_form.dart';
import 'widgets/steps/personal_info_form.dart';
import 'widgets/steps/provider_and_finder_form.dart';
import 'widgets/steps/summary_step.dart';

class SheepCreateOrUpdateController extends ScreenController {
  final AddSheepUseCase _addSheepUseCase;
  final UpdateSheepUseCase _updateSheepUseCase;
  final Sheep? _oldSheep;

  SheepCreateOrUpdateController(
    super.state,
    this._addSheepUseCase,
    this._updateSheepUseCase, {
    Sheep? editingSheep,
  }) : _oldSheep = editingSheep;

  final personalInfoFormKey = GlobalKey<FormState>();
  // Personal Info Fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isWhatsAppNumber = true;
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  // Provider and Finder Fields
  final providerNameController = TextEditingController();
  final providerPhoneController = TextEditingController();
  final relationWithProviderController = TextEditingController();
  final finderNameController = TextEditingController();
  final finderPhoneController = TextEditingController();
  bool sameAsPovider = true;

  // Activities Controllers
  int totalSessions = 8;
  int sessionsDone = 0;
  int wateringSessionsDone = 0;
  ESheepStatus status = ESheepStatus.active;
  ESheepStage stage = ESheepStage.survey;
  ESheepSurveyStatus surveyStatus = ESheepSurveyStatus.none;
  String? abandonReason;
  String? abandonDetails;

  // Step handling

  int _currentStep = 0;
  int get currentStep => _currentStep;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  @override
  @protected
  void onInit() {
    totalSessions = 8;
    // Listener to sync finder info when same as provider is checked
    providerNameController.addListener(_syncFinderName);
    providerPhoneController.addListener(_syncFinderPhone);

    // Update
    // Personal Info Fields
    final sheep = _oldSheep;
    if (sheep != null) {
      nameController.text = sheep.name;
      phoneController.text = sheep.phoneNumber;
      isWhatsAppNumber = sheep.isWhatsAppNumber;
      ageController.text = sheep.age.toString();
      addressController.text = sheep.address;

      // Provider and Finder Fields
      providerNameController.text = sheep.providerName;
      providerPhoneController.text = sheep.providerPhone;
      relationWithProviderController.text = sheep.relationWithProvider;
      finderNameController.text = sheep.finderName;
      finderPhoneController.text = sheep.finderPhone;
      sameAsPovider = sheep.providerName == sheep.finderName &&
          sheep.providerPhone == sheep.finderPhone;

      // Activities Controllers
      totalSessions = sheep.totalSessions;
      sessionsDone = sheep.sessionsDone;
      wateringSessionsDone = sheep.wateringSessionsDone;
      status = sheep.status;
      stage = sheep.stage;
      surveyStatus = sheep.surveyStatus;
      abandonReason = sheep.abandonReason;
      abandonDetails = sheep.abandonDetails;
    }
  }

  @override
  @protected
  void onDispose() {
    // Personal Info Controllers
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    addressController.dispose();

    // Provider and Finder Controllers
    providerNameController.dispose();
    providerPhoneController.dispose();
    relationWithProviderController.dispose();
    finderNameController.dispose();
    finderPhoneController.dispose();
  }

  void _syncFinderName() {
    if (sameAsPovider) {
      finderNameController.text = providerNameController.text;
    }
  }

  void _syncFinderPhone() {
    if (sameAsPovider) {
      finderPhoneController.text = providerPhoneController.text;
    }
  }

  List<Step> buildSteps() {
    return [
      // Personal Info Step
      Step(
        title: Text('Personal Info'),
        content: PersonalInfoForm(this),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      // Provider and Finder Step
      Step(
        title: Text('Provider & Finder Details'),
        content: ProviderAndFinderForm(this),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      // Activities Step
      Step(
        title: Text('Activities'),
        content: ActivitiesForm(this),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      // Summary and Submit Step
      Step(
        title: Text('Summary'),
        content: SummaryStep(this),
        isActive: _currentStep >= 3,
        state: _currentStep >= 3 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  onStepContinue() {
    // Existing step validation logic
    switch (_currentStep) {
      case 0: // Personal Info
        if (personalInfoFormKey.currentState!.validate()) {
          updateUI(() => _currentStep += 1);
        }
        break;
      case 1: // Provider and Finder
        if (providerNameController.text.isNotEmpty &&
            providerPhoneController.text.isNotEmpty &&
            relationWithProviderController.text.isNotEmpty) {
          if (!sameAsPovider) {
            if (finderNameController.text.isNotEmpty &&
                finderPhoneController.text.isNotEmpty) {
              updateUI(() => _currentStep += 1);
            }
          } else {
            updateUI(() => _currentStep += 1);
          }
        }
        break;
      case 2: // Activities
        updateUI(() => _currentStep += 1);
        break;
      case 3: // Summary
        _submitForm();
        break;
    }
  }

  void onStepCancel() {
    if (_currentStep > 0) {
      updateUI(() => _currentStep -= 1);
    }
  }

  Future<void> _submitForm() async {
    // Create Sheep object
    final sheep = Sheep(
      id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
      name: nameController.text,
      phoneNumber: phoneController.text,
      isWhatsAppNumber: isWhatsAppNumber,
      age: ageController.text,
      address: addressController.text,
      providerName: providerNameController.text,
      providerPhone: providerPhoneController.text,
      relationWithProvider: relationWithProviderController.text,
      finderName: finderNameController.text,
      finderPhone: finderPhoneController.text,
      createdAt: DateTime.now(),
      status: status,
      stage: stage,
      surveyStatus: surveyStatus,
      totalSessions: totalSessions,
      sessionsDone: sessionsDone,
      wateringSessionsDone: wateringSessionsDone,
      abandonReason: status == ESheepStatus.abandoned ? abandonReason : null,
      abandonDetails: status == ESheepStatus.abandoned ? abandonDetails : null,
    );

    updateUI(() => _isSubmitting = true);

    final result = _oldSheep != null
        ? await _updateSheepUseCase.call(UpdateSheepParams(sheep: sheep))
        : await _addSheepUseCase.call(AddSheepParams(sheep: sheep));

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
            'Brebis ${_oldSheep != null ? "mise à jour" : "enregistré"} avec succès !',
          ),
        ),
      );
      if (Modular.to.canPop()) {
        Modular.to.pop();
      } else {
        Modular.to.pushNamed(
          HomePage.pageRoute,
          arguments: HomePageArguments.sheepList,
        );
      }
    });
  }
}
