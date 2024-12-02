import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/entities/sheep.dart';
import '../../../../domain/usecases/abandon_sheep_use_case.dart';

class AbandonSheepBottomSheet extends StatefulWidget {
  final int sheepId;
  final Sheep? sheep;

  const AbandonSheepBottomSheet({required this.sheepId, this.sheep, super.key});

  static Future<void> show(BuildContext context, int sheepId, Sheep? sheep) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AbandonSheepBottomSheet(
        sheepId: sheepId,
        sheep: sheep,
      ),
    );
  }

  @override
  State<AbandonSheepBottomSheet> createState() {
    return _AbandonSheepBottomSheetState();
  }
}

class _AbandonSheepBottomSheetState extends State<AbandonSheepBottomSheet> {
  String? _selectedReason;
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _customReasonController = TextEditingController();
  bool _isCustomReason = false;
  bool _isProcessing = false;

  final predefinedReasons = [
    "Sondage mauvais",
    "Indisponibilité",
    "Refus de la vérité",
    "Désistement"
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    _customReasonController.dispose();
    super.dispose();
  }

  Future<void> _onSubmitAbandonSheep() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);
    // Validate inputs
    final reason =
        _isCustomReason ? _customReasonController.text.trim() : _selectedReason;

    if (reason == null || reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner ou entrer une raison'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final details = _detailsController.text.trim();
    if (details.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez donner les détails sur ce qui s'est réellement passé",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = await Modular.get<AbandonSheepUseCase>().call(
      AbandonSheepParams(
        id: widget.sheepId,
        reason: reason,
        details: details,
      ),
    );

    result.fold(
      (failure) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${failure.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
      (_) {
        // Close bottom sheet and potentially navigate or show success message
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Brebis #${widget.sheepId} abandonné avec succès')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            'Abandonner la brebis #${widget.sheepId} - ${widget.sheep?.name}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Reason Selection
          const Text(
            "Raison de l'abandon",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          // Toggle between predefined and custom reasons
          Row(
            children: [
              Expanded(
                child: Visibility(
                  visible: !_isCustomReason,
                  replacement: TextField(
                    enabled: !_isProcessing,
                    controller: _customReasonController,
                    decoration: InputDecoration(
                      hintText: 'Entrez une raison personnalisée',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Sélectionnez une raison',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _selectedReason,
                    items: predefinedReasons
                        .map((reason) => DropdownMenuItem(
                              value: reason,
                              child: Text(reason),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(_isCustomReason ? Icons.list : Icons.add),
                onPressed: () {
                  setState(() {
                    _isCustomReason = !_isCustomReason;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Details Text Field
          const Text(
            'Détails supplémentaires',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _detailsController,
            enabled: !_isProcessing,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Décrivez plus en détail la situation',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Submit Button
          ElevatedButton(
            onPressed: _isProcessing ? null : _onSubmitAbandonSheep,
            child: Visibility(
              visible: _isProcessing,
              replacement: const Text('Abandonner la brebis'),
              child: const CircularProgressIndicator(),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
