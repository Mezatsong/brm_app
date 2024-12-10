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
  AppointmentsPageController(super.state);

  late DateTimeRange _selectedDateRange;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _showCompletedSessions = false;
  ESheepStage? _selectedType;

  DateTime get focusedDay => _focusedDay;

  DateTime? get selectedDay => _selectedDay;

  DateTimeRange get selectedDateRange => _selectedDateRange;

  @override
  @protected
  void onInit() {
    onSelectDateRange(DateTime.now());
  }

  List<Session> getFilteredSessions() {
    final data = BlocProvider.of<AppointmentsCubit>(context).state.data ?? [];
    return data.where((session) {
      // Filter by selected day
      if (_selectedDay != null &&
          _selectedDay?.difference(session.appointmentDate).inDays != 0) {
        return false;
      }

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
        startDate: _selectedDateRange.start,
        endDate: _selectedDateRange.end,
      );
    }
  }

  void onSelectDateRange(DateTime anyWeekDay) {
    _selectedDateRange = DateTimeRange(
      start: anyWeekDay.subtract(
        Duration(days: anyWeekDay.weekday - DateTime.monday),
      ),
      end: anyWeekDay.add(Duration(days: DateTime.sunday - anyWeekDay.weekday)),
    );
    BlocProvider.of<AppointmentsCubit>(context).loadAppointments(
      startDate: _selectedDateRange.start,
      endDate: _selectedDateRange.end,
    );
    updateUI(() => _focusedDay = anyWeekDay);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    updateUI(() {
      _selectedDay = isSameDay(selectedDay, _selectedDay) ? null : selectedDay;
      _focusedDay = _focusedDay;
    });
  }

  bool selectedDayPredicate(DateTime day) {
    final snap = BlocProvider.of<AppointmentsCubit>(context).state;
    final days = snap.data?.map((e) => e.appointmentDate).toList();
    if (days != null) {
      for (final dayItem in days) {
        if (isSameDay(dayItem, day)) return true;
      }
    }

    return false;
  }
}
