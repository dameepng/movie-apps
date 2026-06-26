import 'package:core/common/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:movie/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      final db = await databaseHelper.database;
      await db!.insert(DatabaseHelper.tblWatchlist, movie.toJson());
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      final db = await databaseHelper.database;
      await db!.delete(
        DatabaseHelper.tblWatchlist,
        where: 'id = ?',
        whereArgs: [movie.id],
      );
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final db = await databaseHelper.database;
    final results = await db!.query(
      DatabaseHelper.tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return MovieTable.fromMap(results.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final db = await databaseHelper.database;
    final results = await db!.query(DatabaseHelper.tblWatchlist);
    return results.map((data) => MovieTable.fromMap(data)).toList();
  }
}
