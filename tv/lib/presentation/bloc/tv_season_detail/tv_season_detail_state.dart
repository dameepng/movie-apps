part of 'tv_season_detail_bloc.dart';

abstract class TVSeasonDetailState extends Equatable {
  const TVSeasonDetailState();

  @override
  List<Object> get props => [];
}

class TVSeasonDetailEmpty extends TVSeasonDetailState {}

class TVSeasonDetailLoading extends TVSeasonDetailState {}

class TVSeasonDetailError extends TVSeasonDetailState {
  final String message;

  const TVSeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeasonDetailHasData extends TVSeasonDetailState {
  final TVSeasonDetail result;

  const TVSeasonDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
