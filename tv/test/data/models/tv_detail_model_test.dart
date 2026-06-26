import 'package:core/data/models/genre_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTVDetailResponse = TVDetailResponse(
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

  const tTVDetail = TVDetail(
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

  final tTVDetailJson = {
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

  test('should be a subclass of TVDetail entity', () async {
    final result = tTVDetailResponse.toEntity();
    expect(result, tTVDetail);
  });

  test('should return a valid model from JSON', () async {
    final result = TVDetailResponse.fromJson(tTVDetailJson);
    expect(result, tTVDetailResponse);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tTVDetailResponse.toJson();
    expect(result, tTVDetailJson);
  });
}
