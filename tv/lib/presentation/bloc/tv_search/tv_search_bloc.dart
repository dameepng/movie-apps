import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tvs.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TVSearchBloc extends Bloc<TVSearchEvent, TVSearchState> {
  final SearchTVs _searchTVs;

  TVSearchBloc(this._searchTVs) : super(TVSearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(TVSearchLoading());
      final result = await _searchTVs.execute(query);

      result.fold(
        (failure) {
          emit(TVSearchError(failure.message));
        },
        (data) {
          emit(TVSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
