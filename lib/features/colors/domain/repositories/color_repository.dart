import '../../../../core/errors/failures.dart';
import '../entities/color_entitie.dart';
import 'package:dartz/dartz.dart';

abstract class ColorRandomRepository {
  Future<Either<Failure, ColorRandom>> getRandomColor();
}
