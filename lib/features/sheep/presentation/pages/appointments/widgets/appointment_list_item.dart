import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/session.dart';

class AppointmentListItem extends StatelessWidget {
  final Session session;

  const AppointmentListItem({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(
          session.type == 'witnessing' ? Icons.person : Icons.water_drop,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Session ${session.sessionNumber}'),
        subtitle: Text(dateFormat.format(session.appointmentDate)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to session details
        },
      ),
    );
  }
}