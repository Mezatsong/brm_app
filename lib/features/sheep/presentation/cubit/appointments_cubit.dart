import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/sheep_repository.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final SheepRepository repository;

  AppointmentsCubit(this.repository) : super(const AppointmentsState());

  Future<void> loadAppointments() async {
    emit(state.copyWith(status: AppointmentsStatus.loading));

    final result = await repository.getAllSheep();
    
    await result.fold(
      (failure) async => emit(state.copyWith(
        status: AppointmentsStatus.error,
        error: failure.message,
      )),
      (sheep) async {
        final allSessions = <Session>[];
        
        for (final s in sheep) {
          final sessionsResult = await repository.getSheepSessions(s.id);
          sessionsResult.fold(
            (failure) => null,
            (sessions) => allSessions.addAll(
              sessions.where((session) => 
                !session.completed && 
                session.appointmentDate.isAfter(DateTime.now())
              ),
            ),
          );
        }

        allSessions.sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));
        
        emit(state.copyWith(
          status: AppointmentsStatus.success,
          appointments: allSessions,
        ));
      },
    );
  }
}