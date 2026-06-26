import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
  GetWatchlistTVStatus,
  SaveTVWatchlist,
  RemoveTVWatchlist,
])
void main() {
  late TVDetailBloc bloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchlistTVStatus mockGetWatchlistTVStatus;
  late MockSaveTVWatchlist mockSaveTVWatchlist;
  late MockRemoveTVWatchlist mockRemoveTVWatchlist;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchlistTVStatus = MockGetWatchlistTVStatus();
    mockSaveTVWatchlist = MockSaveTVWatchlist();
    mockRemoveTVWatchlist = MockRemoveTVWatchlist();
    bloc = TVDetailBloc(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getWatchListStatus: mockGetWatchlistTVStatus,
      saveWatchlist: mockSaveTVWatchlist,
      removeWatchlist: mockRemoveTVWatchlist,
    );
  });

  const tId = 1;
  const tTVDetail = TVDetail(
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
    seasons: [],
  );
  final tTV = TV(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTVs = <TV>[tTV];

  test('initial state should be initial', () {
    expect(bloc.state, TVDetailState.initial());
  });

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => const Right(tTVDetail));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVs));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTVDetail(tId)),
    expect: () => [
      TVDetailState.initial().copyWith(tvState: RequestState.Loading),
      TVDetailState.initial().copyWith(
        tvState: RequestState.Loaded,
        tvDetail: tTVDetail,
        recommendationState: RequestState.Loading,
      ),
      TVDetailState.initial().copyWith(
        tvState: RequestState.Loaded,
        tvDetail: tTVDetail,
        recommendationState: RequestState.Loaded,
        tvRecommendations: tTVs,
      ),
    ],
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVs));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTVDetail(tId)),
    expect: () => [
      TVDetailState.initial().copyWith(tvState: RequestState.Loading),
      TVDetailState.initial().copyWith(
        tvState: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
