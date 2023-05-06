import 'package:cleararchitecture/core/errors/exceptions.dart';
import 'package:cleararchitecture/core/network/network_info.dart';
import 'package:cleararchitecture/features/colors/domain/entities/color_entitie.dart';
import 'package:dartz/dartz.dart';

import 'package:cleararchitecture/core/errors/failures.dart';

import '../../domain/repositories/color_repository.dart';
import '../datasources/color_data_source.dart';

class ColorRepositoryImpl implements ColorRandomRepository {
  final ColorDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ColorRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, ColorRandom>> getRandomColor() async {
    try {
      final color = await remoteDataSource.getRandomColor();
      return Right(color);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
