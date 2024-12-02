import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/sheep_repository.dart';

class ImportFromExcelUseCase implements UseCase<void, ImportParams> {
  final SheepRepository repository;

  ImportFromExcelUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ImportParams params) async {
    return await repository.importFromExcel(params.bytes);
  }
}

class ImportParams extends Equatable {
  final Uint8List bytes;

  const ImportParams({required this.bytes});

  @override
  List<Object> get props => [bytes];
}
