import 'package:core/common/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tv/data/models/tv_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchlist(TVTable tv);
  Future<String> removeWatchlist(TVTable tv);
  Future<TVTable?> getTVById(int id);
  Future<List<TVTable>> getWatchlistTVs();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TVTable tv) async {
    try {
      final db = await databaseHelper.database;
      await db!.insert(DatabaseHelper.tblTVWatchlist, tv.toJson());
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVTable tv) async {
    try {
      final db = await databaseHelper.database;
      await db!.delete(
        DatabaseHelper.tblTVWatchlist,
        where: 'id = ?',
        whereArgs: [tv.id],
      );
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVTable?> getTVById(int id) async {
    final db = await databaseHelper.database;
    final results = await db!.query(
      DatabaseHelper.tblTVWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return TVTable.fromMap(results.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVTable>> getWatchlistTVs() async {
    final db = await databaseHelper.database;
    final results = await db!.query(DatabaseHelper.tblTVWatchlist);
    return results.map((data) => TVTable.fromMap(data)).toList();
  }
}
