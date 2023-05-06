import 'package:cleararchitecture/features/cat/presentation/bloc/cats/bloc/cats_bloc.dart';
import 'package:cleararchitecture/features/colors/presentation/bloc/cats/bloc/color_bloc.dart';
import 'package:cleararchitecture/features/colors/presentation/pages/ColorPage.dart';
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
          BlocProvider(
              create: (_) => di.sl<ColorBloc>()..add(GetRandomColorEvent())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: const BottomTabs(),
        ));
  }
}

class BottomTabs extends StatefulWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ColorPage(),
    const CatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.palette_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search_off), label: ''),
        ],
      ),
    );
  }
}
