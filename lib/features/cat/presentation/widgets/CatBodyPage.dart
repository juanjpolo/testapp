import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/texts.dart';
import '../../../../core/widgets/LoadingWidget.dart';
import '../../../../core/widgets/errorComponent.dart';
import '../bloc/cats/bloc/cats_bloc.dart';
import 'cats_list_widget.dart';

class buildBody extends StatefulWidget {
  const buildBody({super.key});

  @override
  State<buildBody> createState() => _buildBodyState();
}

class _buildBodyState extends State<buildBody> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: BlocBuilder<CatsBloc, CatsState>(
        builder: (context, state) {
          if (state is ErrorCatsState) {
            return ErrorContainer(
              context: context,
              img: 'assets/apierrorImage.webp',
              title: 'ERROR',
              message: state.message,
              buttonText: TRY,
              onPressed: () => _refreshInfo(context),
              heightMultiplier: 0.35,
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<CatsBloc, CatsState>(
                listener: (context, state) {
                  if (state is LoadedCatsState) {
                    myController.addListener(() {
                      context
                          .read<CatsBloc>()
                          .add(SearchCatEvent(myController.text, state.cats));
                    });
                    return;
                  }
                },
                child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: myController,
                    decoration: InputDecoration(
                        hintText: SEARCH_HINT,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          child: const Icon(Icons.close_outlined),
                          onTap: () {
                            myController.text='';
                          },
                        ))),
              ),
              const SizedBox(
                height: 10,
              ),
              state is LoadedCatsState
                  ? CatsListWidget(
                      cats:
                          state.auxcats.isNotEmpty ? state.auxcats : state.cats,
                      isSearchResults: state.isSearchResults)
                  : const LoadingWidget()
            ],
          );
        },
      ),
    );
  }

  Future<void> _refreshInfo(BuildContext context) async {
    BlocProvider.of<CatsBloc>(context).add(RefreshCatsEvent());
  }
}
