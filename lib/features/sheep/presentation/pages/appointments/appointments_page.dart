import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../cubit/appointments_cubit.dart';
import 'widgets/appointment_list_item.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentsCubit(context.read())..loadAppointments(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appointments),
        ),
        body: BlocBuilder<AppointmentsCubit, AppointmentsState>(
          builder: (context, state) {
            if (state.status == AppointmentsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == AppointmentsStatus.error) {
              return Center(child: Text(state.error!));
            }

            if (state.appointments.isEmpty) {
              return const Center(child: Text(AppStrings.noAppointments));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.appointments.length,
              itemBuilder: (context, index) {
                return AppointmentListItem(session: state.appointments[index]);
              },
            );
          },
        ),
      ),
    );
  }
}