import '../../../../core/errors/failures.dart';
import '../entities/Cat.dart';
import 'package:dartz/dartz.dart';

abstract class CatssRepository {
  Future<Either<Failure, List<Cats>>> getAllCats();
}
