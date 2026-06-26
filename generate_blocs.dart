import 'dart:io';

void generateSimpleBloc(String featureName, String entityName, String usecaseClass, String usecaseFile, String folder) {
  final eventName = 'Fetch$featureName';
  final blocName = '${featureName}Bloc';
  final stateName = '${featureName}State';

  final eventContent = '''
part of '${folder}_bloc.dart';

abstract class ${featureName}Event extends Equatable {
  const ${featureName}Event();

  @override
  List<Object> get props => [];
}

class $eventName extends ${featureName}Event {}
''';

  final stateContent = '''
part of '${folder}_bloc.dart';

abstract class $stateName extends Equatable {
  const $stateName();

  @override
  List<Object> get props => [];
}

class ${featureName}Empty extends $stateName {}

class ${featureName}Loading extends $stateName {}

class ${featureName}Error extends $stateName {
  final String message;

  const ${featureName}Error(this.message);

  @override
  List<Object> get props => [message];
}

class ${featureName}HasData extends $stateName {
  final List<${entityName == 'movie' ? 'Movie' : 'TV'}> result;

  const ${featureName}HasData(this.result);

  @override
  List<Object> get props => [result];
}
''';

  final blocContent = '''
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/$entityName.dart';
import 'package:ditonton/domain/usecases/$usecaseFile.dart';

part '${folder}_event.dart';
part '${folder}_state.dart';

class $blocName extends Bloc<${featureName}Event, $stateName> {
  final $usecaseClass _get$featureName;

  $blocName(this._get$featureName) : super(${featureName}Empty()) {
    on<$eventName>((event, emit) async {
      emit(${featureName}Loading());
      final result = await _get$featureName.execute();

      result.fold(
        (failure) {
          emit(${featureName}Error(failure.message));
        },
        (data) {
          emit(${featureName}HasData(data));
        },
      );
    });
  }
}
''';

  Directory('lib/presentation/bloc/$folder').createSync(recursive: true);
  File('lib/presentation/bloc/$folder/${folder}_event.dart').writeAsStringSync(eventContent);
  File('lib/presentation/bloc/$folder/${folder}_state.dart').writeAsStringSync(stateContent);
  File('lib/presentation/bloc/$folder/${folder}_bloc.dart').writeAsStringSync(blocContent);
}

void generateSearchBloc(String featureName, String entityName, String usecaseClass, String usecaseFile, String folder) {
  final eventName = 'OnQueryChanged';
  final blocName = '${featureName}Bloc';
  final stateName = '${featureName}State';

  final eventContent = '''
part of '${folder}_bloc.dart';

abstract class ${featureName}Event extends Equatable {
  const ${featureName}Event();

  @override
  List<Object> get props => [];
}

class $eventName extends ${featureName}Event {
  final String query;

  const $eventName(this.query);

  @override
  List<Object> get props => [query];
}
''';

  final stateContent = '''
part of '${folder}_bloc.dart';

abstract class $stateName extends Equatable {
  const $stateName();

  @override
  List<Object> get props => [];
}

class ${featureName}Empty extends $stateName {}

class ${featureName}Loading extends $stateName {}

class ${featureName}Error extends $stateName {
  final String message;

  const ${featureName}Error(this.message);

  @override
  List<Object> get props => [message];
}

class ${featureName}HasData extends $stateName {
  final List<${entityName == 'movie' ? 'Movie' : 'TV'}> result;

  const ${featureName}HasData(this.result);

  @override
  List<Object> get props => [result];
}
''';

  final blocContent = '''
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ditonton/domain/entities/$entityName.dart';
import 'package:ditonton/domain/usecases/$usecaseFile.dart';

part '${folder}_event.dart';
part '${folder}_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class $blocName extends Bloc<${featureName}Event, $stateName> {
  final $usecaseClass _search${entityName == 'movie' ? 'Movies' : 'TVs'};

  $blocName(this._search${entityName == 'movie' ? 'Movies' : 'TVs'}) : super(${featureName}Empty()) {
    on<$eventName>((event, emit) async {
      final query = event.query;
      emit(${featureName}Loading());
      final result = await _search${entityName == 'movie' ? 'Movies' : 'TVs'}.execute(query);

      result.fold(
        (failure) {
          emit(${featureName}Error(failure.message));
        },
        (data) {
          emit(${featureName}HasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
''';

  Directory('lib/presentation/bloc/$folder').createSync(recursive: true);
  File('lib/presentation/bloc/$folder/${folder}_event.dart').writeAsStringSync(eventContent);
  File('lib/presentation/bloc/$folder/${folder}_state.dart').writeAsStringSync(stateContent);
  File('lib/presentation/bloc/$folder/${folder}_bloc.dart').writeAsStringSync(blocContent);
}

void main() {
  generateSimpleBloc('NowPlayingMovies', 'movie', 'GetNowPlayingMovies', 'get_now_playing_movies', 'now_playing_movies');
  generateSimpleBloc('PopularMovies', 'movie', 'GetPopularMovies', 'get_popular_movies', 'popular_movies');
  generateSimpleBloc('TopRatedMovies', 'movie', 'GetTopRatedMovies', 'get_top_rated_movies', 'top_rated_movies');
  
  generateSimpleBloc('OnTheAirTVs', 'tv', 'GetOnTheAirTVs', 'get_on_the_air_tvs', 'on_the_air_tvs');
  generateSimpleBloc('PopularTVs', 'tv', 'GetPopularTVs', 'get_popular_tvs', 'popular_tvs');
  generateSimpleBloc('TopRatedTVs', 'tv', 'GetTopRatedTVs', 'get_top_rated_tvs', 'top_rated_tvs');
  
  generateSearchBloc('MovieSearch', 'movie', 'SearchMovies', 'search_movies', 'movie_search');
  generateSearchBloc('TVSearch', 'tv', 'SearchTVs', 'search_tvs', 'tv_search');
  
  generateSimpleBloc('WatchlistMovies', 'movie', 'GetWatchlistMovies', 'get_watchlist_movies', 'watchlist_movies');
  generateSimpleBloc('WatchlistTVs', 'tv', 'GetWatchlistTVs', 'get_watchlist_tvs', 'watchlist_tvs');
  
  print('Blocs generated!');
}
