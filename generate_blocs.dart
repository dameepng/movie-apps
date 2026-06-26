import 'dart:io';

void generateSearchBloc(String featureName, String entityName, String usecaseClass, String usecaseFile, String folder) {
  final eventName = 'OnQueryChanged';
  final blocName = '\${featureName}Bloc';
  final stateName = '\${featureName}State';

  final content = '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/\$entityName.dart';
import 'package:ditonton/domain/usecases/\$usecaseFile.dart';

part '\${folder}_event.dart';
part '\${folder}_state.dart';

class \$blocName extends Bloc<\${featureName}Event, \$stateName> {
  final \$usecaseClass _usecase;

  \$blocName(this._usecase) : super(\${featureName}Empty()) {
    on<\$eventName>((event, emit) async {
      emit(\${featureName}Loading());
      final result = await _usecase.execute(event.query);
      result.fold(
        (failure) {
          emit(\${featureName}Error(failure.message));
        },
        (data) {
          emit(\${featureName}HasData(data));
        },
      );
    });
  }
}
''';

  final eventContent = '''
part of '\${folder}_bloc.dart';

abstract class \${featureName}Event extends Equatable {
  const \${featureName}Event();

  @override
  List<Object> get props => [];
}

class \$eventName extends \${featureName}Event {
  final String query;
  const \$eventName(this.query);

  @override
  List<Object> get props => [query];
}
''';

  final stateContent = '''
part of '\${folder}_bloc.dart';

abstract class \$stateName extends Equatable {
  const \$stateName();
  
  @override
  List<Object> get props => [];
}

class \${featureName}Empty extends \$stateName {}

class \${featureName}Loading extends \$stateName {}

class \${featureName}Error extends \$stateName {
  final String message;

  const \${featureName}Error(this.message);

  @override
  List<Object> get props => [message];
}

class \${featureName}HasData extends \$stateName {
  final List<\${entityName.toUpperCase()}> result;

  const \${featureName}HasData(this.result);

  @override
  List<Object> get props => [result];
}
''';

  final fixedState = stateContent.replaceAll('List<TV>', 'List<TV>');

  Directory('lib/presentation/bloc/\$folder').createSync(recursive: true);
  File('lib/presentation/bloc/\$folder/\${folder}_bloc.dart').writeAsStringSync(content);
  File('lib/presentation/bloc/\$folder/\${folder}_event.dart').writeAsStringSync(eventContent);
  File('lib/presentation/bloc/\$folder/\${folder}_state.dart').writeAsStringSync(fixedState);
}

void generateBloc(String featureName, String entityName, String usecaseClass, String usecaseFile, String folder) {
  final eventName = 'Fetch\$featureName';
  final blocName = '\${featureName}Bloc';
  final stateName = '\${featureName}State';

  final content = '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/\$entityName.dart';
import 'package:ditonton/domain/usecases/\$usecaseFile.dart';

part '\${folder}_event.dart';
part '\${folder}_state.dart';

class \$blocName extends Bloc<\${featureName}Event, \$stateName> {
  final \$usecaseClass _usecase;

  \$blocName(this._usecase) : super(\${featureName}Empty()) {
    on<\$eventName>((event, emit) async {
      emit(\${featureName}Loading());
      final result = await _usecase.execute();
      result.fold(
        (failure) {
          emit(\${featureName}Error(failure.message));
        },
        (data) {
          emit(\${featureName}HasData(data));
        },
      );
    });
  }
}
''';

  final eventContent = '''
part of '\${folder}_bloc.dart';

abstract class \${featureName}Event extends Equatable {
  const \${featureName}Event();

  @override
  List<Object> get props => [];
}

class \$eventName extends \${featureName}Event {}
''';

  final stateContent = '''
part of '\${folder}_bloc.dart';

abstract class \$stateName extends Equatable {
  const \$stateName();
  
  @override
  List<Object> get props => [];
}

class \${featureName}Empty extends \$stateName {}

class \${featureName}Loading extends \$stateName {}

class \${featureName}Error extends \$stateName {
  final String message;

  const \${featureName}Error(this.message);

  @override
  List<Object> get props => [message];
}

class \${featureName}HasData extends \$stateName {
  final List<\${entityName.toUpperCase()}> result;

  const \${featureName}HasData(this.result);

  @override
  List<Object> get props => [result];
}
''';

  final fixedState = stateContent.replaceAll('List<TV>', 'List<TV>');

  Directory('lib/presentation/bloc/\$folder').createSync(recursive: true);
  File('lib/presentation/bloc/\$folder/\${folder}_bloc.dart').writeAsStringSync(content);
  File('lib/presentation/bloc/\$folder/\${folder}_event.dart').writeAsStringSync(eventContent);
  File('lib/presentation/bloc/\$folder/\${folder}_state.dart').writeAsStringSync(fixedState);
}


void main() {
  generateSearchBloc('MovieSearch', 'movie', 'SearchMovies', 'search_movies', 'movie_search');
  generateSearchBloc('TVSearch', 'tv', 'SearchTVs', 'search_tvs', 'tv_search');
  
  generateBloc('WatchlistMovies', 'movie', 'GetWatchlistMovies', 'get_watchlist_movies', 'watchlist_movies');
  generateBloc('WatchlistTVs', 'tv', 'GetWatchlistTVs', 'get_watchlist_tvs', 'watchlist_tvs');
  
  print('Search and Watchlist Blocs generated successfully!');
}
