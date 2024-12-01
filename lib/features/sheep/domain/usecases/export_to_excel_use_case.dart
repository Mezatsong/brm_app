import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/sheep_repository.dart';

class ExportToExcelUseCase implements UseCase<void, ExportParams> {
  final SheepRepository repository;

  ExportToExcelUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ExportParams params) async {
    return await repository.exportToExcel(params.path);
  }
}

class ExportParams extends Equatable {
  final String path;

  const ExportParams({required this.path});

  @override
  List<Object> get props => [path];
}
