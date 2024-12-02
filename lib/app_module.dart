import 'package:brm/features/sheep/domain/entities/sheep.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'features/sheep/data/datasources/local/drift/database.dart';
import 'features/sheep/data/datasources/local/sheep_local_datasource.dart';
import 'features/sheep/data/repositories/sheep_repository_impl.dart';
import 'features/sheep/domain/repositories/sheep_repository.dart';
import 'features/sheep/domain/usecases/abandon_sheep_use_case.dart';
import 'features/sheep/domain/usecases/add_session_use_case.dart';
import 'features/sheep/domain/usecases/add_sheep_use_case.dart';
import 'features/sheep/domain/usecases/export_to_excel_use_case.dart';
import 'features/sheep/domain/usecases/get_all_sheep_use_case.dart';
import 'features/sheep/domain/usecases/get_sheep_by_id_use_case.dart';
import 'features/sheep/domain/usecases/get_sheep_sessions_use_case.dart';
import 'features/sheep/domain/usecases/import_from_excel_use_case.dart';
import 'features/sheep/domain/usecases/search_sheep_with_filters_use_case.dart';
import 'features/sheep/domain/usecases/update_session_use_case.dart';
import 'features/sheep/domain/usecases/update_sheep_use_case.dart';
import 'features/sheep/presentation/pages/home/home_page.dart';
import 'features/sheep/presentation/pages/sheep_create_or_update/sheep_create_or_update_page.dart';
import 'features/sheep/presentation/pages/sheep_detail/sheep_detail_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(MyDatabase.new);
    i.addSingleton<SheepLocalDataSource>(SheepLocalDataSourceImpl.new);
    i.addSingleton<SheepRepository>(SheepRepositoryImpl.new);

    // Usecases
    i.addLazySingleton(GetAllSheepUseCase.new);
    i.addLazySingleton(SearchSheepWithFiltersUseCase.new);
    i.addLazySingleton(GetSheepByIdUseCase.new);
    i.addLazySingleton(AddSheepUseCase.new);
    i.addLazySingleton(UpdateSheepUseCase.new);
    i.addLazySingleton(AbandonSheepUseCase.new);
    i.addLazySingleton(GetSheepSessionsUseCase.new);
    i.addLazySingleton(AddSessionUseCase.new);
    i.addLazySingleton(UpdateSessionUseCase.new);
    i.addLazySingleton(ExportToExcelUseCase.new);
    i.addLazySingleton(ImportFromExcelUseCase.new);
  }

  @override
  void routes(r) {
    r.child(
      HomePage.pageRoute,
      child: (_) => HomePage(
        r.args.data is HomePageArguments ? r.args.data : null,
      ),
    );
    r.child(
      SheepCreateOrUpdatePage.pageRoute,
      child: (_) => SheepCreateOrUpdatePage(
        editingSheep: r.args.data is Sheep ? r.args.data : null,
      ),
    );
    r.child(
      SheepDetailPage.pageRoute(0).replaceFirst('0', ':id'),
      child: (_) => SheepDetailPage(
        sheepId: int.tryParse(r.args.params['id'] ?? ''),
        sheep: r.args.data,
      ),
    );
  }
}
