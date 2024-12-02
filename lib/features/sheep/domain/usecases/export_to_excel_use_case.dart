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
    return await repository.exportToExcel(params.filePath);
  }
}

class ExportParams extends Equatable {
  final String filePath;

  const ExportParams({required this.filePath});

  @override
  List<Object> get props => [filePath];
}
