import 'package:cleararchitecture/core/errors/exceptions.dart';
import 'package:cleararchitecture/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

import 'package:cleararchitecture/features/cat/domain/entities/Cat.dart';

import 'package:cleararchitecture/core/errors/failures.dart';

import '../../domain/repositories/cat_repository.dart';
import '../datasources/cat_local_data_source.dart';
import '../datasources/cat_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class CatsRepositoryImpl implements CatssRepository {
  final CatRemoteDataSource remoteDataSource;
  final CatLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CatsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Cats>>> getAllCats() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllCats();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();

        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
