import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:cleararchitecture/core/errors/failures.dart';
import 'package:cleararchitecture/features/cat/domain/usecases/get_all_cats.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/strings/failures_strings.dart';
import '../../../../domain/entities/Cat.dart';

part 'cats_event.dart';
part 'cats_state.dart';

class CatsBloc extends Bloc<CatsEvent, CatsState> {
  final GetAllCats getAllCats;

  CatsBloc({required this.getAllCats}) : super(CatsInitial()) {
    on<GetAllCatsEvent>((event, emit) => _getAllCats(event, emit));
    on<RefreshCatsEvent>((event, emit) => _refreshCats(event, emit));
    on<SearchCatEvent>(((event, emit) => _searchCatsEvent(event, emit)));
  }

  Future<void> _getAllCats(event, emit) async {
    try {
      final posts = await getAllCats();

      emit(_mapFailureOrPostsToState(posts, state));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _refreshCats(event, emit) async {
    try {
      emit(LoadingCatsState());
      final posts = await getAllCats();
      emit(_mapFailureOrPostsToState(posts, state));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _searchCatsEvent(SearchCatEvent event, Emitter<CatsState> emit) async {
    
    emit(LoadingCatsState());

    final catsSearch = event.cats.where((element) {
      return element.name
          .toLowerCase()
          .contains(event.wordTyping.toLowerCase());
    }).toList();
    await Future.delayed(const Duration(milliseconds: 300));

    if (catsSearch.isEmpty) {
      emit(const LoadedCatsState().copyWith(isSearchResults: false, cats: event.cats));
    } else {
      emit(const LoadedCatsState().copyWith(auxcats: catsSearch, cats: event.cats));
    }
  }

  CatsState _mapFailureOrPostsToState(
      Either<Failure, List<Cats>> either, CatsState state) {
    return either.fold(
      (failure) => ErrorCatsState(message: _mapFailureToMessage(failure)),
      (cats) {
        return LoadedCatsState(cats: cats);
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
