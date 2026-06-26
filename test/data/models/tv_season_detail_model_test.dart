import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/tv_season_detail_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    id: 1,
    episodeNumber: 1,
    name: "name",
    overview: "overview",
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTvSeasonDetailModel = TvSeasonDetailModel(
    id: 1,
    name: "name",
    posterPath: "posterPath",
    seasonNumber: 1,
    episodes: [tEpisodeModel],
  );

  const tEpisode = Episode(
    id: 1,
    episodeNumber: 1,
    name: "name",
    overview: "overview",
    stillPath: "stillPath",
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTvSeasonDetail = TvSeasonDetail(
    id: 1,
    name: "name",
    posterPath: "posterPath",
    seasonNumber: 1,
    episodes: [tEpisode],
  );

  test('should be a subclass of TvSeasonDetail entity', () async {
    final result = tTvSeasonDetailModel.toEntity();
    expect(result, tTvSeasonDetail);
  });
}
