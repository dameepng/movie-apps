import 'dart:io';

void generateSimpleBlocTest(String featureName, String entityName, String usecaseClass, String usecaseFile, String folder) {
  final eventName = 'Fetch\$featureName';
  final blocName = '\${featureName}Bloc';
  final stateName = '\${featureName}State';

  final content = '''
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/\$entityName.dart';
import 'package:ditonton/domain/usecases/\$usecaseFile.dart';
import 'package:ditonton/presentation/bloc/\$folder/\${folder}_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '\${folder}_bloc_test.mocks.dart';

@GenerateMocks([\$usecaseClass])
void main() {
  late \$blocName bloc;
  late Mock\$usecaseClass mockUsecase;

  setUp(() {
    mockUsecase = Mock\$usecaseClass();
    bloc = \$blocName(mockUsecase);
  });

  final t\$entityName = \${entityName == 'movie' ? 'Movie(adult: false, backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalTitle: "originalTitle", overview: "overview", popularity: 1.0, posterPath: "posterPath", releaseDate: "releaseDate", title: "title", video: false, voteAverage: 1.0, voteCount: 1)' : 'TV(backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalName: "originalName", overview: "overview", popularity: 1.0, posterPath: "posterPath", firstAirDate: "firstAirDate", name: "name", voteAverage: 1.0, voteCount: 1)'};
  final t\${entityName}List = <\${entityName.toUpperCase()}>[t\$entityName];

  test('initial state should be empty', () {
    expect(bloc.state, \${featureName}Empty());
  });

  blocTest<\$blocName, \$stateName>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(t\${entityName}List));
      return bloc;
    },
    act: (bloc) => bloc.add(\$eventName()),
    expect: () => [
      \${featureName}Loading(),
      \${featureName}HasData(t\${entityName}List),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<\$blocName, \$stateName>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(\$eventName()),
    expect: () => [
      \${featureName}Loading(),
      const \${featureName}Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
''';

  final fixedContent = content.replaceAll('List<TV>', 'List<TV>').replaceAll('<\${entityName.toUpperCase()}>', '<${entityName == 'tv' ? 'TV' : 'Movie'}>');

  Directory('test/presentation/bloc/\$folder').createSync(recursive: true);
  File('test/presentation/bloc/\$folder/\${folder}_bloc_test.dart').writeAsStringSync(fixedContent);
}

void generateSearchBlocTest(String featureName, String entityName, String usecaseClass, String usecaseFile, String folder) {
  final eventName = 'OnQueryChanged';
  final blocName = '\${featureName}Bloc';
  final stateName = '\${featureName}State';

  final content = '''
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/\$entityName.dart';
import 'package:ditonton/domain/usecases/\$usecaseFile.dart';
import 'package:ditonton/presentation/bloc/\$folder/\${folder}_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '\${folder}_bloc_test.mocks.dart';

@GenerateMocks([\$usecaseClass])
void main() {
  late \$blocName bloc;
  late Mock\$usecaseClass mockUsecase;

  setUp(() {
    mockUsecase = Mock\$usecaseClass();
    bloc = \$blocName(mockUsecase);
  });

  final t\$entityName = \${entityName == 'movie' ? 'Movie(adult: false, backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalTitle: "originalTitle", overview: "overview", popularity: 1.0, posterPath: "posterPath", releaseDate: "releaseDate", title: "title", video: false, voteAverage: 1.0, voteCount: 1)' : 'TV(backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalName: "originalName", overview: "overview", popularity: 1.0, posterPath: "posterPath", firstAirDate: "firstAirDate", name: "name", voteAverage: 1.0, voteCount: 1)'};
  final t\${entityName}List = <\${entityName.toUpperCase()}>[t\$entityName];
  final tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(bloc.state, \${featureName}Empty());
  });

  blocTest<\$blocName, \$stateName>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => Right(t\${entityName}List));
      return bloc;
    },
    act: (bloc) => bloc.add(const \$eventName(tQuery)),
    expect: () => [
      \${featureName}Loading(),
      \${featureName}HasData(t\${entityName}List),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(tQuery));
    },
  );

  blocTest<\$blocName, \$stateName>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const \$eventName(tQuery)),
    expect: () => [
      \${featureName}Loading(),
      const \${featureName}Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(tQuery));
    },
  );
}
''';

  final fixedContent = content.replaceAll('List<TV>', 'List<TV>').replaceAll('<\${entityName.toUpperCase()}>', '<${entityName == 'tv' ? 'TV' : 'Movie'}>');

  Directory('test/presentation/bloc/\$folder').createSync(recursive: true);
  File('test/presentation/bloc/\$folder/\${folder}_bloc_test.dart').writeAsStringSync(fixedContent);
}

void main() {
  generateSimpleBlocTest('NowPlayingMovies', 'movie', 'GetNowPlayingMovies', 'get_now_playing_movies', 'now_playing_movies');
  generateSimpleBlocTest('PopularMovies', 'movie', 'GetPopularMovies', 'get_popular_movies', 'popular_movies');
  generateSimpleBlocTest('TopRatedMovies', 'movie', 'GetTopRatedMovies', 'get_top_rated_movies', 'top_rated_movies');
  
  generateSimpleBlocTest('OnTheAirTVs', 'tv', 'GetOnTheAirTVs', 'get_on_the_air_tvs', 'on_the_air_tvs');
  generateSimpleBlocTest('PopularTVs', 'tv', 'GetPopularTVs', 'get_popular_tvs', 'popular_tvs');
  generateSimpleBlocTest('TopRatedTVs', 'tv', 'GetTopRatedTVs', 'get_top_rated_tvs', 'top_rated_tvs');
  
  generateSearchBlocTest('MovieSearch', 'movie', 'SearchMovies', 'search_movies', 'movie_search');
  generateSearchBlocTest('TVSearch', 'tv', 'SearchTVs', 'search_tvs', 'tv_search');
  
  generateSimpleBlocTest('WatchlistMovies', 'movie', 'GetWatchlistMovies', 'get_watchlist_movies', 'watchlist_movies');
  generateSimpleBlocTest('WatchlistTVs', 'tv', 'GetWatchlistTVs', 'get_watchlist_tvs', 'watchlist_tvs');
  
  print('Tests generated!');
}
