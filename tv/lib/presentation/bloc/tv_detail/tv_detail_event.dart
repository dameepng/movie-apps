part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTVDetail extends TVDetailEvent {
  final int id;

  const FetchTVDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TVDetailEvent {
  final TVDetail tv;

  const AddWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchlist extends TVDetailEvent {
  final TVDetail tv;

  const RemoveFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistStatus extends TVDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
