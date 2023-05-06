import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/color_entitie.dart';
import '../repositories/color_repository.dart';

class GetRandomColor {
  final ColorRandomRepository repository;
  GetRandomColor(this.repository);

  Future<Either<Failure, ColorRandom>> call() async {
    return await repository.getRandomColor();
  }
}
