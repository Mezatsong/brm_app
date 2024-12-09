import 'package:brm/features/sheep/domain/entities/enums/e_sheep_stage.dart';
import 'package:equatable/equatable.dart';

import 'sheep.dart';

class Session extends Equatable {
  final int id;
  final int sheepId;
  final DateTime appointmentDate;
  final ESheepStage type; // witnessing, watering, etc.
  final int sessionNumber;
  final String? notes;
  final bool completed;
  final DateTime? completedAt;
  final Sheep? sheep; // Optional reference to associated sheep

  const Session({
    required this.id,
    required this.sheepId,
    required this.appointmentDate,
    required this.type,
    required this.sessionNumber,
    required this.completed,
    this.notes,
    this.completedAt,
    this.sheep,
  });

  @override
  List<Object?> get props => [
        id,
        sheepId,
        appointmentDate,
        type,
        sessionNumber,
        notes,
        completed,
        completedAt,
        sheep
      ];
}
