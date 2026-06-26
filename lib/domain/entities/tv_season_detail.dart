import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetail extends Equatable {
  final int id;
  final String name;
  final String? posterPath;
  final int seasonNumber;
  final List<Episode> episodes;

  const TvSeasonDetail({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        seasonNumber,
        episodes,
      ];
}
