// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'color_bloc.dart';

abstract class ColorState extends Equatable {
  const ColorState();

  @override
  List<Object> get props => [];
}

class ColorInitial extends ColorState {}

class LoadingColorState extends ColorState {}

class ErrorColorsState extends ColorState {
  final String message;

  const ErrorColorsState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadedColorState extends ColorState {
  final ColorRandom color;

  const LoadedColorState({required this.color});

  @override
  List<Object> get props => [color];

  LoadedColorState copyWith({ColorRandom? color}) {
    return LoadedColorState(
      color: color ?? this.color,
    );
  }

  @override
  String toString() => 'LoadedCatsState(color: $color)';
}
