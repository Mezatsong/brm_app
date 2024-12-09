import 'package:brm/features/sheep/presentation/pages/appointments/appointments_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../domain/entities/session.dart';
import 'cubit/appointments_cubit.dart';
import 'widgets/week_view_session_card.dart';

class AppointmentsPage extends StatelessWidget {
  static const pageRoute = '/appointments';

  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppointmentsCubit(Modular.get())..loadAppointments();
      },
      child: BlocBuilder<AppointmentsCubit, AsyncSnapshot<List<Session>>>(
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.appointments)),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (snap.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.appointments)),
              body: Center(child: Text(snap.error?.toString() ?? '')),
            );
          }

          if (snap.requireData.isEmpty) {
            return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.appointments)),
              body: const Center(child: Text(AppStrings.noAppointments)),
            );
          }

          return ScreenControllerBuilder(
            create: (s) => AppointmentsPageController(s, snap.requireData),
            builder: (context, ctrl) {
              final filteredSessions = ctrl.getFilteredSessions();

              return Scaffold(
                appBar: AppBar(
                  title: const Text(AppStrings.appointments),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: ctrl.openDateRangeSelector,
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: ctrl.showFilterBottomSheet,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    if (ctrl.selectedDateRange != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Interval: ${DateFormat('dd MMM yyyy').format(ctrl.selectedDateRange!.start)} - ${DateFormat('dd MMM yyyy').format(ctrl.selectedDateRange!.end)}',
                        ),
                      ),
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: ctrl.focusedDay,
                      calendarFormat: CalendarFormat.week,
                      selectedDayPredicate: ctrl.selectedDayPredicate,
                      onDaySelected: ctrl.onDaySelected,
                    ),
                    Expanded(
                      child: Visibility(
                        visible: filteredSessions.isNotEmpty,
                        replacement: const Center(
                          child: Text('No appointments found'),
                        ),
                        child: ListView.builder(
                          itemCount: filteredSessions.length,
                          itemBuilder: (context, index) {
                            return WeekViewSessionCard(
                              session: filteredSessions[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
