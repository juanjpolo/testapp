import 'package:cleararchitecture/features/colors/presentation/bloc/cats/bloc/color_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/failures_strings.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ColorBloc, ColorState>(
        builder: (context, state) {
          if (state is LoadedColorState) {
            return GestureDetector(
              onTap: () => getRandomColor(context),
              child: Container(
                color: Colors.primaries[int.parse(state.color.color)],
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(helloMessage),
                ),
              ),
            );
          }
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Future<void> getRandomColor(BuildContext context) async {
    BlocProvider.of<ColorBloc>(context).add(GetRandomColorEvent());
  }
}
