import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTVSeasonDetail {
  final TVRepository repository;

  GetTVSeasonDetail(this.repository);

  Future<Either<Failure, TVSeasonDetail>> execute(int id, int seasonNumber) {
    return repository.getTVSeasonDetail(id, seasonNumber);
  }
}
