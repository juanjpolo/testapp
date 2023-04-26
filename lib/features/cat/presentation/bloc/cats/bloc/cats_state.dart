part of 'cats_bloc.dart';

abstract class CatsState extends Equatable {
  const CatsState();

  @override
  List<Object> get props => [];
}

class CatsInitial extends CatsState {}

class LoadingCatsState extends CatsState {}

class LoadedCatsState extends CatsState {
  final List<Cats> cats;
  final List<Cats> auxcats;
  final bool isSearchResults;
  const LoadedCatsState({
    bool? isSearchResults,
    List<Cats>? cats,
    List<Cats>? auxcats,
  })  : cats = cats ?? const [],
        auxcats = auxcats ?? const [],
        isSearchResults = isSearchResults ?? true;
  @override
  List<Object> get props => [auxcats, cats, isSearchResults];

  LoadedCatsState copyWith(
      {List<Cats>? cats, List<Cats>? auxcats, bool? isSearchResults}) {
    return LoadedCatsState(
        cats: cats ?? this.cats,
        auxcats: auxcats ?? this.auxcats,
        isSearchResults: isSearchResults ?? this.isSearchResults);
  }
}

class ErrorCatsState extends CatsState {
  final String message;

  const ErrorCatsState({required this.message});
  @override
  List<Object> get props => [message];
}
