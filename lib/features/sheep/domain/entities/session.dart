import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String id;
  final String sheepId;
  final DateTime appointmentDate;
  final String type; // witnessing, watering
  final int sessionNumber;
  final String? notes;
  final bool completed;
  final DateTime? completedAt;

  const Session({
    required this.id,
    required this.sheepId,
    required this.appointmentDate,
    required this.type,
    required this.sessionNumber,
    this.notes,
    required this.completed,
    this.completedAt,
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
  ];
}