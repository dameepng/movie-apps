import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final int? episodeCount;

  const SeasonModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodeCount,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
        episodeCount: json['episode_count'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'poster_path': posterPath,
        'season_number': seasonNumber,
        'episode_count': episodeCount,
      };

  Season toEntity() => Season(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
        episodeCount: episodeCount,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        episodeCount,
      ];
}
