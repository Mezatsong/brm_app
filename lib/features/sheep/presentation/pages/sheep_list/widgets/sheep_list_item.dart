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
    final dtF = DateFormat('E dd MMM yyyy, hh:mm');
    final nextRdv = sheep.lastSession?.appointmentDate != null
        ? dtF.format(sheep.lastSession!.appointmentDate)
        : 'Aucun';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          '${sheep.name.trim()}, ${sheep.age}',
          overflow: TextOverflow.fade,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Étape: ${sheep.stateSummary}'),
            Text('Prochain RDV: $nextRdv'),
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
