import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc bloc;
  late MockGetPopularMovies mockUsecase;

  setUp(() {
    mockUsecase = MockGetPopularMovies();
    bloc = PopularMoviesBloc(mockUsecase);
  });

  final tMovie = Movie(adult: false, backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalTitle: "originalTitle", overview: "overview", popularity: 1.0, posterPath: "posterPath", releaseDate: "releaseDate", title: "title", video: false, voteAverage: 1.0, voteCount: 1);
  final tmovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(bloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(tmovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData(tmovieList),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoading(),
      const PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
