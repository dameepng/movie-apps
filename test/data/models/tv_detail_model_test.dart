import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvDetailResponse = TvDetailResponse(
    backdropPath: 'backdropPath',
    genres: [GenreModel(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
    seasons: [
      SeasonModel(
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ],
  );

  const tTvDetail = TvDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
    seasons: [
      Season(
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ],
  );

  final tTvDetailJson = {
    "backdrop_path": "backdropPath",
    "genres": [
      {
        "id": 1,
        "name": "Action",
      }
    ],
    "id": 1,
    "original_name": "originalName",
    "overview": "overview",
    "poster_path": "posterPath",
    "first_air_date": "firstAirDate",
    "name": "name",
    "vote_average": 1.0,
    "vote_count": 1,
    "seasons": [
      {
        "episode_count": 1,
        "id": 1,
        "name": "name",
        "overview": "overview",
        "poster_path": "posterPath",
        "season_number": 1,
      }
    ],
  };

  test('should be a subclass of TvDetail entity', () async {
    final result = tTvDetailResponse.toEntity();
    expect(result, tTvDetail);
  });

  test('should return a valid model from JSON', () async {
    final result = TvDetailResponse.fromJson(tTvDetailJson);
    expect(result, tTvDetailResponse);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tTvDetailResponse.toJson();
    expect(result, tTvDetailJson);
  });
}
