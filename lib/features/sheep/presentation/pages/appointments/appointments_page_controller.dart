import 'package:brm/features/sheep/presentation/pages/appointments/cubit/appointments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../domain/entities/enums/e_sheep_stage.dart';
import '../../../domain/entities/session.dart';
import 'widgets/appointments_filter_bottom_sheet.dart';
import 'widgets/date_range_filter_bottom_sheet.dart';

class AppointmentsPageController extends ScreenController {
  final List<Session> _allSessions;

  AppointmentsPageController(super.state, this._allSessions);

  DateTimeRange? _selectedDateRange;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _showCompletedSessions = false;
  ESheepStage? _selectedType;

  DateTime get focusedDay => _focusedDay;

  DateTimeRange? get selectedDateRange => _selectedDateRange;

  List<Session> getFilteredSessions() {
    return _allSessions.where((session) {
      // Filter by date
      bool matchesDate = session.appointmentDate.year == _focusedDay.year &&
          session.appointmentDate.month == _focusedDay.month;

      // Filter by completed status
      bool matchesCompletedStatus =
          _showCompletedSessions || !session.completed;

      // Filter by type
      bool matchesType = _selectedType == null || session.type == _selectedType;

      return matchesDate && matchesCompletedStatus && matchesType;
    }).toList();
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => AppointmentsFilterBottomSheet(
        selectedType: _selectedType,
        showCompletedSessions: _showCompletedSessions,
        onShowCompletedSessionsChanged: (value) {
          updateUI(() => _showCompletedSessions = value);
        },
        onSelectedTypeChanged: (newType) {
          updateUI(() => _selectedType = newType);
        },
      ),
    );
  }

  void openDateRangeSelector() async {
    final result = await DateRangeFilterBottomSheet.show(
      context,
      initialStartDate: DateTime.now().subtract(const Duration(days: 30)),
      initialEndDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if (result != null && context.mounted) {
      updateUI(() {
        _selectedDateRange = result;
      });

      BlocProvider.of<AppointmentsCubit>(context).loadAppointments(
        startDate: _selectedDateRange?.start,
        endDate: _selectedDateRange?.end,
      );
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      updateUI(() {
        _selectedDay = selectedDay;
        _focusedDay = _focusedDay;
      });
    }
  }

  bool selectedDayPredicate(DateTime day) => isSameDay(_selectedDay, day);
}
