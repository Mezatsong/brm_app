import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import '../../../domain/entities/enums/e_sheep_stage.dart';
import '../../../domain/entities/enums/e_sheep_status.dart';
import '../../../domain/entities/enums/e_sheep_survey_status.dart';
import '../../../domain/entities/sheep.dart';
import '../../../domain/usecases/search_sheep_with_filters_use_case.dart';
import '../sheep_create_or_update/sheep_create_or_update_page.dart';
import '../sheep_detail/sheep_detail_page.dart';

part 'bloc/sheep_bloc.dart';
part 'bloc/sheep_events.dart';
part 'bloc/sheep_states.dart';
part 'widgets/filter_bottom_sheet_modal.dart';
part 'widgets/sheep_list_item.dart';

part 'sheep_list_controller.dart';

class SheepListPage extends StatelessWidget {
  static const pageRoute = '/sheeps';

  const SheepListPage({super.key});

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        label: Text(label),
        onDeleted: onDeleted,
        deleteIcon: const Icon(Icons.close, size: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _SheepBloc(Modular.get()),
      child: ScreenControllerBuilder(
        create: _SheepListController.new,
        builder: (context, ctrl) => Scaffold(
          appBar: AppBar(
            title: const Text('Brebis'),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _FilterBottomSheetModal.show(
                  context,
                  selectedStage: ctrl.selectedStage,
                  onStageChanged: ctrl.onSelectStage,
                  selectedStatus: ctrl.selectedStatus,
                  onStatusChanged: ctrl.onSelectStatus,
                  selectedSurveyStatus: ctrl.selectedSurveyStatus,
                  onSurveyStatusChanged: ctrl.onSelectSurveyStatus,
                  applyFilters: ctrl.applyFilters,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: ctrl.searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une brebis...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: ctrl.searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              ctrl.searchController.clear();
                              ctrl.applyFilters();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (_) => ctrl.applyFilters(),
                ),
              ),

              // Active Filters Display
              if (ctrl.selectedStatus != null ||
                  ctrl.selectedStage != null ||
                  ctrl.selectedSurveyStatus != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (ctrl.selectedStatus != null)
                        _buildFilterChip(
                          label: 'Statut: ${ctrl.selectedStatus!.value}',
                          onDeleted: ctrl.onResetStatusFilter,
                        ),
                      if (ctrl.selectedStage != null)
                        _buildFilterChip(
                          label: 'Étape: ${ctrl.selectedStage!.value}',
                          onDeleted: ctrl.onResetStageFilter,
                        ),
                      if (ctrl.selectedSurveyStatus != null)
                        _buildFilterChip(
                          label: 'Sondage: ${ctrl.selectedSurveyStatus!.value}',
                          onDeleted: ctrl.onResetSurveyStatusFilter,
                        ),
                    ],
                  ),
                ),

              // Sheep List
              Expanded(
                child: BlocBuilder<_SheepBloc, _SheepState>(
                  builder: (context, state) {
                    if (state is _SheepLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is _SheepErrorState) {
                      return Center(
                        child: Text(
                          'Erreur de chargement: ${state.message}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is _SheepLoadedState) {
                      return ListView.builder(
                        controller: ctrl.scrollController,
                        itemCount:
                            state.sheep.length + (state.hasReachedMax ? 0 : 1),
                        itemBuilder: (context, index) {
                          // Show loading indicator at the end if not reached max
                          if (index >= state.sheep.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final sheep = state.sheep[index];
                          return _SheepListItem(sheep);
                        },
                      );
                    }

                    return const Center(child: Text('Aucun brebis trouvé'));
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Modular.to.pushNamed(SheepCreateOrUpdatePage.pageRoute);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
