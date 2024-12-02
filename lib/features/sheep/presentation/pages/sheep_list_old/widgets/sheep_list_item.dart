import 'package:brm/features/sheep/presentation/pages/sheep_detail/sheep_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../domain/entities/sheep.dart';

class SheepListItem extends StatelessWidget {
  final Sheep sheep;

  const SheepListItem({super.key, required this.sheep});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(sheep.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sheep.phoneNumber),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildChip(sheep.stage.value),
                const SizedBox(width: 8),
                _buildChip(sheep.status.value),
              ],
            ),
          ],
        ),
        trailing: CircularProgressIndicator(
          value: sheep.sessionsDone / sheep.totalSessions,
          backgroundColor: Colors.grey[200],
        ),
        onTap: () {
          Modular.to.pushNamed(
            SheepDetailPage.pageRoute(sheep.id),
            arguments: sheep,
          );
        },
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      padding: const EdgeInsets.all(4),
    );
  }
}
