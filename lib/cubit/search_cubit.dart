import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../getdatas/pixa_getresponce.dart';
import '../getdatas/pixa_list.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final repo = PixaRepository();
  SearchCubit() : super(SearchState.loading());
  void getImages(String image) async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final list = await repo.getSearchPic(image);
      emit(state.copyWith(
          status: SearchStatus.success, pixaList: list.pixalist));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.error));
    }
  }
}
