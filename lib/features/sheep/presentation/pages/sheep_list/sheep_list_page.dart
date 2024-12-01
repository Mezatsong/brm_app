import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../core/constants/app_strings.dart';
import 'cubit/sheep_list_cubit.dart';
import 'widgets/sheep_list_item.dart';
import '../../widgets/search_bar.dart';

class SheepListPage extends StatelessWidget {
  const SheepListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SheepListCubit(Modular.get())..loadSheep(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.sheep),
        ),
        body: Column(
          children: [
            const CustomSearchBar(),
            Expanded(
              child: BlocBuilder<SheepListCubit, SheepListState>(
                builder: (context, state) {
                  if (state.status == SheepListStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == SheepListStatus.error) {
                    return Center(child: Text(state.error!));
                  }

                  if (state.displaySheep.isEmpty) {
                    return const Center(child: Text(AppStrings.noSheepFound));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.displaySheep.length,
                    itemBuilder: (context, index) {
                      return SheepListItem(sheep: state.displaySheep[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
