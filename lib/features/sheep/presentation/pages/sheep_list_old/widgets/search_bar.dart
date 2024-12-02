import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../cubit/sheep_list_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppStrings.search,
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          context.read<SheepListCubit>().filterSheep(value);
        },
      ),
    );
  }
}
