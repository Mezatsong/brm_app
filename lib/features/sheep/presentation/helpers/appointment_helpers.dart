import 'package:flutter/material.dart';

import '../../domain/entities/enums/e_sheep_stage.dart';

final Map<ESheepStage, Color> typeColors = {
  ESheepStage.invitation: Colors.red,
  ESheepStage.survey: Colors.yellow,
  ESheepStage.witnessing: Colors.blue.shade300,
  ESheepStage.watering: Colors.green.shade300,
};
