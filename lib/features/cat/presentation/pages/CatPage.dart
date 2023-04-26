import 'package:cleararchitecture/core/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/failures_strings.dart';
import '../bloc/network/bloc/network_bloc.dart';

import '../widgets/CatBodyPage.dart';

class CatPage extends StatelessWidget {
  const CatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CatBreeds',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) async {
          if (state is NetworkFailure) {
            await showDialog(
                context: context,
                builder: (_) => Alert(
                      title: 'Error',
                      content: OFFLINE_FAILURE_MESSAGE,
                      actions: <Widget>[
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
          }
        },
        child: const buildBody(),
      ),
    );
  }
}

