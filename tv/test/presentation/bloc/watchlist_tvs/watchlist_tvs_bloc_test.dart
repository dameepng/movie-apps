import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv/presentation/bloc/watchlist_tvs/watchlist_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTVs])
void main() {
  late WatchlistTVsBloc bloc;
  late MockGetWatchlistTVs mockUsecase;

  setUp(() {
    mockUsecase = MockGetWatchlistTVs();
    bloc = WatchlistTVsBloc(mockUsecase);
  });

  final tTV = TV(backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalName: "originalName", overview: "overview", popularity: 1.0, posterPath: "posterPath", firstAirDate: "firstAirDate", name: "name", voteAverage: 1.0, voteCount: 1);
  final ttvList = <TV>[tTV];

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistTVsEmpty());
  });

  blocTest<WatchlistTVsBloc, WatchlistTVsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(ttvList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTVs()),
    expect: () => [
      WatchlistTVsLoading(),
      WatchlistTVsHasData(ttvList),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<WatchlistTVsBloc, WatchlistTVsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTVs()),
    expect: () => [
      WatchlistTVsLoading(),
      const WatchlistTVsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
