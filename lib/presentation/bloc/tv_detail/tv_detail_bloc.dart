import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchlistTVStatus getWatchListStatus;
  final SaveTVWatchlist saveWatchlist;
  final RemoveTVWatchlist removeWatchlist;

  TVDetailBloc({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TVDetailState.initial()) {
    on<FetchTVDetail>((event, emit) async {
      emit(state.copyWith(tvState: RequestState.Loading));

      final detailResult = await getTVDetail.execute(event.id);
      final recommendationResult =
          await getTVRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(state.copyWith(
            tvState: RequestState.Error,
            message: failure.message,
          ));
        },
        (tv) {
          emit(state.copyWith(
            recommendationState: RequestState.Loading,
            tvState: RequestState.Loaded,
            tvDetail: tv,
            watchlistMessage: '',
          ));
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                recommendationState: RequestState.Error,
                message: failure.message,
              ));
            },
            (tvs) {
              emit(state.copyWith(
                recommendationState: RequestState.Loaded,
                tvRecommendations: tvs,
              ));
            },
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );
      add(LoadWatchlistStatus(event.tv.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );
      add(LoadWatchlistStatus(event.tv.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
