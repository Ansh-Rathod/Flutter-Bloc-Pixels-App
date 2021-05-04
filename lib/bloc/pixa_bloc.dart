import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../getdatas/pixa_getresponce.dart';
import '../getdatas/pixa_list.dart';

part 'pixa_event.dart';
part 'pixa_state.dart';

class PixaBloc extends Bloc<PixaEvent, PixaState> {
  PixaBloc() : super(PixaInitial());
  final pixaRepo = PixaRepository();
  @override
  Stream<PixaState> mapEventToState(
    PixaEvent event,
  ) async* {
    if (event is PixaEvent) {
      yield PixaLoading();
      try {
        final pixaList = await pixaRepo.getPics();
        yield PixaLoadSuccess(pixalist: pixaList.pixalist);
      } catch (e) {
        yield PixaLoadError(error: e);
      }
    }
  }
}
