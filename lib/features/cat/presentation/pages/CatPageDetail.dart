
import 'package:cleararchitecture/features/cat/presentation/widgets/catInfo.dart';
import 'package:flutter/material.dart';

import '../../../../core/strings/failures_strings.dart';
import '../../domain/entities/Cat.dart';

class CatPageDetail extends StatelessWidget {
  final Cats cat;
  const CatPageDetail({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cat.name,
          style: const TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Image.network(
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.2,
              cat.referenceImageId ?? '',
              errorBuilder: (context, error, stackTrace) {
            return const Text(errorImageNetwork);
          }),
          const SizedBox(
            height: 10,
          ),
          CatInfo(cat: cat)
        ],
      ),
    );
  }
}
