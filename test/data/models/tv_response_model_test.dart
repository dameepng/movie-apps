import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTVModel = TVModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTVResponse = TVResponse(tvList: [tTVModel]);

  final tTVResponseJson = {
    "results": [
      {
        "backdrop_path": "backdropPath",
        "genre_ids": [1, 2, 3],
        "id": 1,
        "original_name": "originalName",
        "overview": "overview",
        "popularity": 1.0,
        "poster_path": "posterPath",
        "first_air_date": "firstAirDate",
        "name": "name",
        "vote_average": 1.0,
        "vote_count": 1
      }
    ]
  };

  test('should return a valid model from JSON', () async {
    final result = TVResponse.fromJson(tTVResponseJson);
    expect(result, tTVResponse);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tTVResponse.toJson();
    expect(result, tTVResponseJson);
  });
}
