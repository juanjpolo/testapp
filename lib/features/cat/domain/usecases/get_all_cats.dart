import 'package:cleararchitecture/features/cat/domain/repositories/cat_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/Cat.dart';

class GetAllCats {
  final CatssRepository repository;
  GetAllCats(this.repository);

  Future<Either<Failure, List<Cats>>> call() async {
    return await repository.getAllCats();
  }
}
