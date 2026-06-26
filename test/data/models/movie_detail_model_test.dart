import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 100,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'en',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 100,
    runtime: 120,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
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

  final tMovieDetailJson = {
    "adult": false,
    "backdrop_path": "backdropPath",
    "budget": 100,
    "genres": [
      {"id": 1, "name": "Action"}
    ],
    "homepage": "homepage",
    "id": 1,
    "imdb_id": "imdbId",
    "original_language": "en",
    "original_title": "originalTitle",
    "overview": "overview",
    "popularity": 1.0,
    "poster_path": "posterPath",
    "release_date": "releaseDate",
    "revenue": 100,
    "runtime": 120,
    "status": "status",
    "tagline": "tagline",
    "title": "title",
    "video": false,
    "vote_average": 1.0,
    "vote_count": 1,
  };

  test('should be a subclass of MovieDetail entity', () async {
    final result = tMovieDetailResponse.toEntity();
    expect(result, tMovieDetail);
  });

  test('should return a valid model from JSON', () async {
    final result = MovieDetailResponse.fromJson(tMovieDetailJson);
    expect(result, tMovieDetailResponse);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tMovieDetailResponse.toJson();
    expect(result, tMovieDetailJson);
  });
}
