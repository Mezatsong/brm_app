import 'package:brm/features/sheep/domain/entities/sheep.dart';
import 'package:brm/features/sheep/domain/usecases/get_recent_sheep_use_case.dart';
import 'package:brm/features/sheep/presentation/pages/app_lock_screen.dart';
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
import 'features/sheep/domain/usecases/get_dashboard_data_use_case.dart';
import 'features/sheep/domain/usecases/get_sheep_by_id_use_case.dart';
import 'features/sheep/domain/usecases/get_sheep_sessions_use_case.dart';
import 'features/sheep/domain/usecases/get_weekly_sessions_use_case.dart';
import 'features/sheep/domain/usecases/import_from_excel_use_case.dart';
import 'features/sheep/domain/usecases/search_sheep_with_filters_use_case.dart';
import 'features/sheep/domain/usecases/update_session_use_case.dart';
import 'features/sheep/domain/usecases/update_sheep_use_case.dart';
import 'features/sheep/presentation/helpers/device_authentication_guard.dart';
import 'features/sheep/presentation/pages/appointment_add_or_edit/appointment_add_or_edit_page.dart';
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
    i.addLazySingleton(AbandonSheepUseCase.new);
    i.addLazySingleton(AddSessionUseCase.new);
    i.addLazySingleton(AddSheepUseCase.new);
    i.addLazySingleton(ExportToExcelUseCase.new);
    i.addLazySingleton(GetAllSheepUseCase.new);
    i.addLazySingleton(GetDashboardDataUseCase.new);
    i.addLazySingleton(GetRecentSheepUseCase.new);
    i.addLazySingleton(GetSheepByIdUseCase.new);
    i.addLazySingleton(GetWeeklySessionsUseCase.new);
    i.addLazySingleton(GetSheepSessionsUseCase.new);
    i.addLazySingleton(ImportFromExcelUseCase.new);
    i.addLazySingleton(UpdateSessionUseCase.new);
    i.addLazySingleton(UpdateSheepUseCase.new);
    i.addLazySingleton(SearchSheepWithFiltersUseCase.new);
  }

  @override
  void routes(r) {
    r.child(
      HomePage.pageRoute,
      guards: [DeviceAuthenticationGuard()],
      child: (_) => HomePage(
        r.args.data is HomePageArguments ? r.args.data : null,
      ),
    );
    r.child(
      SheepCreateOrUpdatePage.pageRoute,
      guards: [DeviceAuthenticationGuard()],
      child: (_) => SheepCreateOrUpdatePage(
        editingSheep: r.args.data is Sheep ? r.args.data : null,
      ),
    );
    r.child(
      SheepDetailPage.pageRoute(0).replaceFirst('0', ':id'),
      guards: [DeviceAuthenticationGuard()],
      child: (_) => SheepDetailPage(
        sheepId: int.tryParse(r.args.params['id'] ?? ''),
        sheep: r.args.data,
      ),
    );
    r.child(
      AppointmentAddOrEditPage.pageRoute,
      guards: [DeviceAuthenticationGuard()],
      child: (_) => AppointmentAddOrEditPage(r.args.data),
    );
    r.child(AppLockScreen.pageRoute, child: (_) => const AppLockScreen());
  }
}
