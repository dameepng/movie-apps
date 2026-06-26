import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc bloc;
  late MockSearchMovies mockUsecase;

  setUp(() {
    mockUsecase = MockSearchMovies();
    bloc = MovieSearchBloc(mockUsecase);
  });

  final tMovie = Movie(adult: false, backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalTitle: "originalTitle", overview: "overview", popularity: 1.0, posterPath: "posterPath", releaseDate: "releaseDate", title: "title", video: false, voteAverage: 1.0, voteCount: 1);
  final tmovieList = <Movie>[tMovie];
  final tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(bloc.state, MovieSearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => Right(tmovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchHasData(tmovieList),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(tQuery));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    expect: () => [
      MovieSearchLoading(),
      const MovieSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(tQuery));
    },
  );
}
