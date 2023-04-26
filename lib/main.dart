import 'package:cleararchitecture/features/cat/presentation/bloc/cats/bloc/cats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/cat/presentation/bloc/network/bloc/network_bloc.dart';
import 'features/cat/presentation/pages/CatPage.dart';
import 'injection_container.dart' as di;
import 'core/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<CatsBloc>()..add(GetAllCatsEvent())),
          BlocProvider(
              create: (_) => di.sl<NetworkBloc>()..add(NetworkObserve())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: const CatPage(),
        ));
  }
}
