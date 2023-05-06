import 'package:cleararchitecture/core/network/network_info.dart';
import 'package:cleararchitecture/features/cat/data/datasources/cat_local_data_source.dart';
import 'package:cleararchitecture/features/cat/data/datasources/cat_remote_data_source.dart';
import 'package:cleararchitecture/features/cat/data/repositories/cat_repository_imp.dart';
import 'package:cleararchitecture/features/cat/domain/repositories/cat_repository.dart';
import 'package:cleararchitecture/features/cat/domain/usecases/get_all_cats.dart';
import 'package:cleararchitecture/features/cat/presentation/bloc/network/bloc/network_bloc.dart';
import 'package:cleararchitecture/features/cat/presentation/bloc/cats/bloc/cats_bloc.dart';
import 'package:cleararchitecture/features/colors/data/datasources/color_data_source.dart';
import 'package:cleararchitecture/features/colors/data/repositories/color_repository_imp.dart';
import 'package:cleararchitecture/features/colors/domain/repositories/color_repository.dart';
import 'package:cleararchitecture/features/colors/presentation/bloc/cats/bloc/color_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/colors/domain/usecases/get_random_color.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //features - posts

  //Bloc

  sl.registerFactory(() => CatsBloc(getAllCats: sl()));
  sl.registerFactory(() => NetworkBloc());
  sl.registerFactory(() => ColorBloc(getColor: sl()));

  //useCases
  sl.registerLazySingleton(() => GetAllCats(sl()));
  sl.registerLazySingleton(() => GetRandomColor(sl()));

  //repositories
  sl.registerLazySingleton<CatssRepository>(() => CatsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ColorRandomRepository>(
      () => ColorRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //Datasources
  sl.registerLazySingleton<CatRemoteDataSource>(
      () => CatRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ColorDataSource>(
      () => ColorDataSourceImpl(client: sl()));

  sl.registerLazySingleton<CatLocalDataSource>(
      () => CatLocalDataSourceImpl(sharedPreferences: sl()));

//core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

//External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
