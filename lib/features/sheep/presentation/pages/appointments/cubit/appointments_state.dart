part of 'appointments_cubit.dart';

enum AppointmentsStatus { initial, loading, success, error }

class AppointmentsState extends Equatable {
  final AppointmentsStatus status;
  final List<Session> appointments;
  final String? error;

  const AppointmentsState({
    this.status = AppointmentsStatus.initial,
    this.appointments = const [],
    this.error,
  });

  AppointmentsState copyWith({
    AppointmentsStatus? status,
    List<Session>? appointments,
    String? error,
  }) {
    return AppointmentsState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, appointments, error];
}