import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;
  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  test('initial state should be initial', () {
    expect(bloc.state, MovieDetailState.initial());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Right(tMovieDetail));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    expect: () => [
      MovieDetailState.initial().copyWith(movieState: RequestState.Loading),
      MovieDetailState.initial().copyWith(
        movieState: RequestState.Loaded,
        movieDetail: tMovieDetail,
        recommendationState: RequestState.Loading,
      ),
      MovieDetailState.initial().copyWith(
        movieState: RequestState.Loaded,
        movieDetail: tMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: tMovies,
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
    expect: () => [
      MovieDetailState.initial().copyWith(movieState: RequestState.Loading),
      MovieDetailState.initial().copyWith(
        movieState: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
