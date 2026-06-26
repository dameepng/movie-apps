import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';

part 'tv_season_detail_event.dart';
part 'tv_season_detail_state.dart';

class TVSeasonDetailBloc extends Bloc<TVSeasonDetailEvent, TVSeasonDetailState> {
  final GetTVSeasonDetail _usecase;

  TVSeasonDetailBloc(this._usecase) : super(TVSeasonDetailEmpty()) {
    on<FetchTVSeasonDetail>((event, emit) async {
      emit(TVSeasonDetailLoading());
      final result = await _usecase.execute(event.id, event.seasonNumber);
      result.fold(
        (failure) {
          emit(TVSeasonDetailError(failure.message));
        },
        (data) {
          emit(TVSeasonDetailHasData(data));
        },
      );
    });
  }
}
