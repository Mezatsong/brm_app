import '../../domain/entities/session.dart';
import 'sheep_model.dart';

class SessionModel extends Session {
  final SheepModel? sheepModel;

  const SessionModel({
    required super.id,
    required super.sheepId,
    required super.appointmentDate,
    required super.type,
    required super.sessionNumber,
    super.notes,
    required super.completed,
    super.completedAt,
    this.sheepModel,
  });

  factory SessionModel.fromSession(Session session) {
    return SessionModel(
      id: session.id,
      sheepId: session.sheepId,
      appointmentDate: session.appointmentDate,
      type: session.type,
      sessionNumber: session.sessionNumber,
      notes: session.notes,
      completed: session.completed,
      completedAt: session.completedAt,
      sheepModel:
          session.sheep == null ? null : SheepModel.fromSheep(session.sheep!),
    );
  }

  Session toSession() {
    return Session(
      id: id,
      sheepId: sheepId,
      appointmentDate: appointmentDate,
      type: type,
      sessionNumber: sessionNumber,
      notes: notes,
      completed: completed,
      completedAt: completedAt,
      sheep: sheepModel?.toSheep(),
    );
  }

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      sheepId: json['sheepId'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      type: json['type'],
      sessionNumber: json['sessionNumber'],
      notes: json['notes'],
      completed: json['completed'],
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      sheepModel:
          json['sheep'] != null ? SheepModel.fromJson(json['sheep']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sheepId': sheepId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'type': type,
      'sessionNumber': sessionNumber,
      'notes': notes,
      'completed': completed,
      'completedAt': completedAt?.toIso8601String(),
      'sheep': sheepModel?.toJson(),
    };
  }
}
