part of '../sheep_list_page.dart';

class _SheepListItem extends StatelessWidget {
  final Sheep sheep;

  const _SheepListItem(this.sheep);

  Icon _getStatusIcon(ESheepStatus status) {
    switch (status) {
      case ESheepStatus.active:
        return Icon(Icons.pending, color: Colors.blue);
      case ESheepStatus.abandoned:
        return Icon(Icons.cancel, color: Colors.red);
      case ESheepStatus.won:
        return Icon(Icons.check_circle, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: FittedBox(
          child: Text(
            '${sheep.name}, ${sheep.age}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Étape: ${sheep.stateSummary}'),
            Text(
              'Prochain RDV: ${sheep.lastSession?.appointmentDate ?? "Aucun"}',
            ),
          ],
        ),
        trailing: _getStatusIcon(sheep.status),
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
