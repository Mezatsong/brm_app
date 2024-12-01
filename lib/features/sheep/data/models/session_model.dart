import '../../domain/entities/session.dart';

class SessionModel extends Session {
  const SessionModel({
    required super.id,
    required super.sheepId,
    required super.appointmentDate,
    required super.type,
    required super.sessionNumber,
    super.notes,
    required super.completed,
    super.completedAt,
  });

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
    };
  }
}