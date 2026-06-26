import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';

part 'on_the_air_tvs_event.dart';
part 'on_the_air_tvs_state.dart';

class OnTheAirTVsBloc extends Bloc<OnTheAirTVsEvent, OnTheAirTVsState> {
  final GetOnTheAirTVs _getOnTheAirTVs;

  OnTheAirTVsBloc(this._getOnTheAirTVs) : super(OnTheAirTVsEmpty()) {
    on<FetchOnTheAirTVs>((event, emit) async {
      emit(OnTheAirTVsLoading());
      final result = await _getOnTheAirTVs.execute();

      result.fold(
        (failure) {
          emit(OnTheAirTVsError(failure.message));
        },
        (data) {
          emit(OnTheAirTVsHasData(data));
        },
      );
    });
  }
}
