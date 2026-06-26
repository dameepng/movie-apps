import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  Database,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
