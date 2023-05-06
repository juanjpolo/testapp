import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:cleararchitecture/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/strings/failures_strings.dart';
import '../../../../domain/entities/color_entitie.dart';
import '../../../../domain/usecases/get_random_color.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  final GetRandomColor getColor;

  ColorBloc({required this.getColor}) : super(ColorInitial()) {
    on<GetRandomColorEvent>((event, emit) => _getRandomColor(event, emit));
   
  }

  Future<void> _getRandomColor(event, emit) async {
    try {
      final posts = await getColor();

      emit(_mapFailureOrPostsToState(posts, state));
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  ColorState _mapFailureOrPostsToState(
      Either<Failure, ColorRandom> either, ColorState state) {
    return either.fold(
      (failure) => ErrorColorsState(message: _mapFailureToMessage(failure)),
      (color) {
        return LoadedColorState(color: color);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
