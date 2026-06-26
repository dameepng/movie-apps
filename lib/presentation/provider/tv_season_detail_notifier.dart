import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter/foundation.dart';

class TvSeasonDetailNotifier extends ChangeNotifier {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailNotifier({required this.getTvSeasonDetail});

  late TvSeasonDetail _seasonDetail;
  TvSeasonDetail get seasonDetail => _seasonDetail;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonDetail(int id, int seasonNumber) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeasonDetail.execute(id, seasonNumber);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _seasonDetail = data;
        notifyListeners();
      },
    );
  }
}
