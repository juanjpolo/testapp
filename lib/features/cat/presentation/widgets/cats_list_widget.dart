import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/failures_strings.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../../domain/entities/Cat.dart';
import '../bloc/cats/bloc/cats_bloc.dart';
import 'cat_card.dart';

class CatsListWidget extends StatelessWidget {
  final List<Cats> cats;
  final bool isSearchResults;
  const CatsListWidget({
    super.key,
    required this.cats,
    required this.isSearchResults,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearchResults) {
      return Expanded(
          child: RefreshIndicator(
              onRefresh: () => _refreshInfo(context),
              child: ListView.builder(
                itemCount: cats.length,
                itemBuilder: (context, index) {
                  return CatWidget(cat: cats[index]);
                },
              )));
    } else {
      return const MessageDisplay(message: NO_RESULTS);
    }
  }

  Future<void> _refreshInfo(BuildContext context) async {
    BlocProvider.of<CatsBloc>(context).add(RefreshCatsEvent());
  }
}
                //    
