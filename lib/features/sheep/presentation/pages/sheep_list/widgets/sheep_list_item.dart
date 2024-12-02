part of '../sheep_list_page.dart';

class _SheepListItem extends StatelessWidget {
  final Sheep sheep;

  const _SheepListItem(this.sheep);

  IconData _getStatusIcon(ESheepStatus status) {
    switch (status) {
      case ESheepStatus.active:
        return Icons.check_circle;
      case ESheepStatus.abandoned:
        return Icons.cancel;
    }
  }

  Color _getStatusColor(ESheepStatus status) {
    switch (status) {
      case ESheepStatus.active:
        return Colors.green;
      case ESheepStatus.abandoned:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          sheep.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Étape: ${sheep.stage.value}'),
            Text('Statut: ${sheep.status.value}'),
          ],
        ),
        trailing: Icon(
          _getStatusIcon(sheep.status),
          color: _getStatusColor(sheep.status),
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
}
