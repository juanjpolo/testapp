part of 'cats_bloc.dart';

abstract class CatsEvent extends Equatable {
  const CatsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCatsEvent extends CatsEvent {}

class RefreshCatsEvent extends CatsEvent {}

class SearchCatEvent extends CatsEvent {
  final String wordTyping;
  final List<Cats> cats;

  const SearchCatEvent(this.wordTyping, this.cats);

  @override
  List<Object> get props => [wordTyping, cats];
}

