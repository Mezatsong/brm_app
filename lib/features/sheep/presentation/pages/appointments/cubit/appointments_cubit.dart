import 'package:brm/core/usecases/usecase.dart';
import 'package:brm/features/sheep/domain/usecases/get_sheep_sessions_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/session.dart';
import '../../../../domain/usecases/get_all_sheep_use_case.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final GetAllSheepUseCase _getAllSheepUseCase;
  final GetSheepSessionsUseCase _getSheepSessionsUseCase;

  AppointmentsCubit(this._getAllSheepUseCase, this._getSheepSessionsUseCase)
      : super(const AppointmentsState());

  Future<void> loadAppointments() async {
    emit(state.copyWith(status: AppointmentsStatus.loading));

    final result = await _getAllSheepUseCase.call(NoParams());

    await result.fold(
      (failure) async => emit(state.copyWith(
        status: AppointmentsStatus.error,
        error: failure.message,
      )),
      (sheep) async {
        final allSessions = <Session>[];

        for (final s in sheep) {
          final sessionsResult = await _getSheepSessionsUseCase.call(
            SheepIdParams(id: s.id),
          );
          sessionsResult.fold(
            (failure) => null,
            (sessions) => allSessions.addAll(
              sessions.where((session) =>
                  !session.completed &&
                  session.appointmentDate.isAfter(DateTime.now())),
            ),
          );
        }

        allSessions
            .sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));

        emit(state.copyWith(
          status: AppointmentsStatus.success,
          appointments: allSessions,
        ));
      },
    );
  }
}
