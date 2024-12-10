import 'package:brm/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/session.dart';
import '../../../helpers/appointment_helpers.dart';
import 'appointment_details_bottom_sheet.dart';

class WeekViewSessionCard extends StatelessWidget {
  final Session session;

  const WeekViewSessionCard({required this.session, super.key});

  void _onTap(BuildContext context) {
    final sheep = session.sheep;
    if (sheep == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => AppointmentDetailsBottomSheet(
        session: session,
        sheep: sheep,
      ),
    ).then((result) {
      if (result != null && context.mounted) {
        if (result == 'deleted') {
          // Handle deletion
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('RDV Supprimé !')),
          );
        } else if (result is Session) {
          // Handle update
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('RDV Modifié !')),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: typeColors[session.type] ?? Colors.grey.shade300,
      child: ListTile(
        onTap: () => _onTap(context),
        title: Text(
          "${session.sheep?.name ?? 'Unknown Sheep'}, ${session.sheep?.age}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.sheep?.stateSummary ?? session.type.value.capitalize(),
            ),
            if (session.notes != null)
              Text(
                session.notes!,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
          ],
        ),
        trailing: Text(
          DateFormat('E (dd MMM) à HH:mm').format(session.appointmentDate),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
