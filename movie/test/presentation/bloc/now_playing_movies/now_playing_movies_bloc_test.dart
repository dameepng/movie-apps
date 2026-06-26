import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc bloc;
  late MockGetNowPlayingMovies mockUsecase;

  setUp(() {
    mockUsecase = MockGetNowPlayingMovies();
    bloc = NowPlayingMoviesBloc(mockUsecase);
  });

  final tMovie = Movie(adult: false, backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalTitle: "originalTitle", overview: "overview", popularity: 1.0, posterPath: "posterPath", releaseDate: "releaseDate", title: "title", video: false, voteAverage: 1.0, voteCount: 1);
  final tmovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(bloc.state, NowPlayingMoviesEmpty());
  });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(tmovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(tmovieList),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
