import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/session.dart';
import '../../../../domain/usecases/get_weekly_sessions_use_case.dart';

class AppointmentsCubit extends Cubit<AsyncSnapshot<List<Session>>> {
  final GetWeeklySessionsUseCase _getWeeklySessionsUseCase;

  AppointmentsCubit(this._getWeeklySessionsUseCase)
      : super(const AsyncSnapshot.nothing());

  Future<void> loadAppointments({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    emit(AsyncSnapshot.waiting());

    final result = await _getWeeklySessionsUseCase.call(
      GetWeeklySessionsParams(startDate: startDate, endDate: endDate),
    );

    emit(
      result.fold(
        (fail) => AsyncSnapshot.withError(ConnectionState.done, fail.message),
        (sessions) => AsyncSnapshot.withData(ConnectionState.done, sessions),
      ),
    );
  }
}
