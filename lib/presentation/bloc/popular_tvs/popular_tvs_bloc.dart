import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';

part 'popular_tvs_event.dart';
part 'popular_tvs_state.dart';

class PopularTVsBloc extends Bloc<PopularTVsEvent, PopularTVsState> {
  final GetPopularTVs _getPopularTVs;

  PopularTVsBloc(this._getPopularTVs) : super(PopularTVsEmpty()) {
    on<FetchPopularTVs>((event, emit) async {
      emit(PopularTVsLoading());
      final result = await _getPopularTVs.execute();

      result.fold(
        (failure) {
          emit(PopularTVsError(failure.message));
        },
        (data) {
          emit(PopularTVsHasData(data));
        },
      );
    });
  }
}
