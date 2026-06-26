part of 'tv_detail_bloc.dart';

class TVDetailState extends Equatable {
  final TVDetail? tvDetail;
  final RequestState tvState;
  final List<TV> tvRecommendations;
  final RequestState recommendationState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const TVDetailState({
    required this.tvDetail,
    required this.tvState,
    required this.tvRecommendations,
    required this.recommendationState,
    required this.message,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
  });

  factory TVDetailState.initial() {
    return const TVDetailState(
      tvDetail: null,
      tvState: RequestState.Empty,
      tvRecommendations: [],
      recommendationState: RequestState.Empty,
      message: '',
      isAddedToWatchlist: false,
      watchlistMessage: '',
    );
  }

  TVDetailState copyWith({
    TVDetail? tvDetail,
    RequestState? tvState,
    List<TV>? tvRecommendations,
    RequestState? recommendationState,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return TVDetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvState: tvState ?? this.tvState,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvDetail,
        tvState,
        tvRecommendations,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
