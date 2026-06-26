import 'package:tv/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final int id;
  final int episodeNumber;
  final String name;
  final String overview;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  const EpisodeModel({
    required this.id,
    required this.episodeNumber,
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        episodeNumber: json["episode_number"],
        name: json["name"],
        overview: json["overview"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "episode_number": episodeNumber,
        "name": name,
        "overview": overview,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Episode toEntity() {
    return Episode(
      id: id,
      episodeNumber: episodeNumber,
      name: name,
      overview: overview,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        episodeNumber,
        name,
        overview,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
