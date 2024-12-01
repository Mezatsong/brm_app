import 'package:flutter_modular/flutter_modular.dart';
import 'features/sheep/data/datasources/local/drift/database.dart';
import 'features/sheep/data/datasources/local/sheep_local_datasource.dart';
import 'features/sheep/data/repositories/sheep_repository_impl.dart';
import 'features/sheep/domain/repositories/sheep_repository.dart';
import 'features/sheep/presentation/pages/home/home_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(MyDatabase.new);
    i.addSingleton<SheepLocalDataSource>(SheepLocalDataSourceImpl.new);
    i.addSingleton<SheepRepository>(SheepRepositoryImpl.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}