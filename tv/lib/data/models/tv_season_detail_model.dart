import 'package:tv/data/models/episode_model.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeasonDetailModel extends Equatable {
  final int id;
  final String name;
  final String? posterPath;
  final int seasonNumber;
  final List<EpisodeModel> episodes;

  const TVSeasonDetailModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  factory TVSeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      TVSeasonDetailModel(
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

  TVSeasonDetail toEntity() {
    return TVSeasonDetail(
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
