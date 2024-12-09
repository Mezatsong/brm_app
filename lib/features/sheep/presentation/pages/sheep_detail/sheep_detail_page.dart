import 'package:brm/features/sheep/domain/usecases/get_sheep_by_id_use_case.dart';
import 'package:brm/features/sheep/presentation/pages/appointment_add_or_edit/appointment_add_or_edit_page.dart';
import 'package:brm/features/sheep/presentation/pages/sheep_create_or_update/sheep_create_or_update_page.dart';
import 'package:brm/features/sheep/presentation/pages/sheep_detail/widgets/abandon_sheep_bottom_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../domain/entities/enums/e_sheep_status.dart';
import '../../../domain/entities/sheep.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SheepDetailPage extends StatelessWidget {
  final int sheepId;
  final Sheep? sheep;

  static String pageRoute(int id) => '/sheeps/$id/details';

  SheepDetailPage({int? sheepId, this.sheep, super.key})
      : sheepId = sheepId ?? sheep!.id;

  Future<Sheep?> _future() async {
    final result = await Modular.get<GetSheepByIdUseCase>().call(sheepId);
    return result.fold((_) => null, (s) => s);
  }

  String _formatPhoneNumber(String phoneNumber) {
    // Remove all non-numeric characters
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Ensure the phone number starts with "237"
    if (!phoneNumber.startsWith('237')) {
      phoneNumber = '237$phoneNumber';
    }

    // Remove any spaces
    phoneNumber = phoneNumber.replaceAll(' ', '');

    return phoneNumber;
  }

  void _handlePhoneTapped(String phoneNumber, [bool isWhatsAppNumber = true]) {
    var phone = _formatPhoneNumber(phoneNumber);
    // Remove all non-numeric characters
    phone = phone.replaceAll(RegExp(r'\D'), '');
    // Ensure the phone number starts with "237"
    if (!phone.startsWith('237')) {
      phone = '237$phone';
    }
    // Remove any spaces
    phone = phone.replaceAll(' ', '');

    var url = 'tel://$phone';
    if (isWhatsAppNumber) {
      url = 'whatsapp://send?phone=$phone';
    }

    launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la brebis #$sheepId'),
        actions: [
          if (sheep != null)
            IconButton(
              icon: const Icon(Icons.add_alarm),
              onPressed: () {
                Modular.to.pushNamed(
                  AppointmentAddOrEditPage.pageRoute,
                  arguments: AppointmentAddOrEditPageArgs.create(sheep!),
                );
              },
            ),

          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Modular.to.pushNamed(
                SheepCreateOrUpdatePage.pageRoute,
                arguments: sheep,
              );
            },
          ),

          // Abandon button (only if not already abandoned)
          if (sheep?.status != ESheepStatus.abandoned)
            IconButton(
              icon: const Icon(Icons.warning_amber_rounded),
              color: Colors.red,
              onPressed: () => AbandonSheepBottomSheet.show(
                context,
                sheepId,
                sheep,
              ),
            ),
        ],
      ),
      body: FutureBuilder(
        initialData: sheep,
        future: _future(),
        builder: (context, snap) {
          if (!snap.hasData &&
              snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snap.hasData && snap.hasError) {
            return Center(child: Text('Un problème est survenue'));
          }

          final sheep = snap.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header with Status and Stage
              _buildStatusHeader(sheep),

              const SizedBox(height: 16),

              // Personal Information Section
              _buildSectionCard(
                title: 'Informations sur la Brebis',
                icon: Icons.person,
                children: [
                  _buildDetailRow('Nom', sheep.name),
                  _buildDetailRow('Âge', '${sheep.age} ans'),
                  _buildDetailRow('Adresse', sheep.address),
                ],
              ),

              const SizedBox(height: 16),

              // Contact Information Section
              _buildSectionCard(
                title: 'Coordonnées de la Brebis',
                icon: Icons.phone,
                children: [
                  InkWell(
                    onTap: () => _handlePhoneTapped(
                      sheep.phoneNumber,
                      sheep.isWhatsAppNumber,
                    ),
                    child: _buildContactRow(
                      'Numéro de téléphone',
                      sheep.phoneNumber,
                      sheep.isWhatsAppNumber ? '(WhatsApp)' : '',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Provider Information Section
              _buildSectionCard(
                title: 'Informations du Fournisseur',
                icon: Icons.business,
                children: [
                  _buildDetailRow('Nom', sheep.providerName),
                  InkWell(
                    onTap: () => _handlePhoneTapped(sheep.providerPhone),
                    child: _buildDetailRow('Téléphone', sheep.providerPhone),
                  ),
                  _buildDetailRow('Relation', sheep.relationWithProvider),
                ],
              ),

              const SizedBox(height: 16),

              // Finder Information Section
              _buildSectionCard(
                title: 'Informations du Chercheur',
                icon: Icons.person_search,
                children: [
                  _buildDetailRow('Nom', sheep.finderName),
                  InkWell(
                    onTap: () => _handlePhoneTapped(sheep.finderPhone),
                    child: _buildDetailRow('Téléphone', sheep.finderPhone),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Project Progress Section
              _buildSectionCard(
                title: 'Progression',
                icon: Icons.timeline,
                children: [
                  _buildProgressRow(
                    'Témoingnages',
                    '${sheep.sessionsDone} / ${sheep.totalSessions}',
                    sheep.sessionsDone / sheep.totalSessions,
                  ),
                  _buildProgressRow(
                    'Sessions d\'arrosage',
                    '${sheep.wateringSessionsDone} / ${AppConstants.wateringtotalSessions}',
                    sheep.wateringSessionsDone /
                        AppConstants.wateringtotalSessions,
                  ),
                ],
              ),

              // Abandonment Details (if applicable)
              if (sheep.status == ESheepStatus.abandoned) ...[
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: 'Détails de l\'abandon',
                  icon: Icons.warning,
                  children: [
                    _buildDetailRow(
                      'Raison',
                      sheep.abandonReason ?? 'Non spécifié',
                    ),
                    _buildDetailRow(
                      'Détails',
                      sheep.abandonDetails ?? 'Aucun détail',
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 16),

              // Metadata Section
              _buildSectionCard(
                title: 'Métadonnées',
                icon: Icons.info_outline,
                children: [
                  _buildDetailRow(
                    'Date de création',
                    DateFormat.yMMMMd('fr_FR').format(sheep.createdAt),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusHeader(Sheep sheep) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getStatusColor(sheep),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Statut: ${sheep.status.value.toUpperCase()}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'Étape: ${sheep.stage.value.toUpperCase()}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(Sheep sheep) {
    switch (sheep.status) {
      case ESheepStatus.active:
        return Colors.blue;
      case ESheepStatus.abandoned:
        return Colors.red;
      case ESheepStatus.won:
        return Colors.green;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildContactRow(String label, String value, [String? suffix]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: FittedBox(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                FittedBox(
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
                if (suffix != null)
                  Text(
                    suffix,
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String label, String value, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: _getProgressColor(progress),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.3) return Colors.red;
    if (progress < 0.6) return Colors.orange;
    if (progress < 0.9) return Colors.blue;
    return Colors.green;
  }
}
