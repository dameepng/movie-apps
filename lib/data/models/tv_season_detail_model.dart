import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetailModel extends Equatable {
  final int id;
  final String name;
  final String? posterPath;
  final int seasonNumber;
  final List<EpisodeModel> episodes;

  const TvSeasonDetailModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  factory TvSeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailModel(
        id: json["id"] ?? json["_id"], // Sometimes API returns id or _id
        name: json["name"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };

  TvSeasonDetail toEntity() {
    return TvSeasonDetail(
      id: id,
      name: name,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        seasonNumber,
        episodes,
      ];
}
