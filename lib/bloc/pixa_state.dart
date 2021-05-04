part of 'pixa_bloc.dart';

@immutable
abstract class PixaState {}

class PixaInitial extends PixaState {}

class PixaLoading extends PixaState {}

class PixaLoadSuccess extends PixaState {
  final List<PixaList> pixalist;
  final List<String> images;
  PixaLoadSuccess({
    @required this.pixalist,
    this.images,
  });
}

class PixaLoadError extends PixaState {
  final Error error;
  PixaLoadError({
    @required this.error,
  });
}
