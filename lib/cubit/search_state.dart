part of 'search_cubit.dart';

enum SearchStatus { loading, success, error }

class SearchState extends Equatable {
  final List<PixaList> pixaList;
  final SearchStatus status;
  SearchState({
    @required this.pixaList,
    @required this.status,
  });
  factory SearchState.loading() {
    return SearchState(
      pixaList: null,
      status: SearchStatus.loading,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [pixaList, status];

  SearchState copyWith({
    List<PixaList> pixaList,
    SearchStatus status,
  }) {
    return SearchState(
      pixaList: pixaList ?? this.pixaList,
      status: status ?? this.status,
    );
  }
}
