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
      create: (_) => AppointmentsCubit(Modular.get()),
      child: ScreenControllerBuilder(
        create: AppointmentsPageController.new,
        builder: (context, ctrl) {
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
            body: BlocBuilder<AppointmentsCubit, AsyncSnapshot<List<Session>>>(
              builder: (context, snap) {
                final filteredSessions = ctrl.getFilteredSessions();
                final dtF = DateFormat('E dd MMM yyyy');
                final current = ctrl.selectedDay != null
                    ? dtF.format(ctrl.selectedDay!)
                    : '${dtF.format(ctrl.selectedDateRange.start)}  au  ${dtF.format(ctrl.selectedDateRange.end)}';

                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snap.hasError) {
                  return Center(child: Text(snap.error?.toString() ?? ''));
                }

                return Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2024, 1, 1),
                      lastDay: DateTime.utc(2030, 1, 1),
                      currentDay: ctrl.selectedDay,
                      focusedDay: ctrl.focusedDay,
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      selectedDayPredicate: ctrl.selectedDayPredicate,
                      onDaySelected: ctrl.onDaySelected,
                      onPageChanged: ctrl.onSelectDateRange,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'RDV du $current',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        replacement: Text(AppStrings.noAppointments),
                        child: ListView.builder(
                          itemCount: filteredSessions.length,
                          itemBuilder: (context, i) => WeekViewSessionCard(
                            session: filteredSessions.elementAt(i),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
