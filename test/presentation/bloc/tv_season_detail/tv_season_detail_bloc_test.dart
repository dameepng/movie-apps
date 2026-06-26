import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/presentation/bloc/tv_season_detail/tv_season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeasonDetail])
void main() {
  late TVSeasonDetailBloc bloc;
  late MockGetTVSeasonDetail mockGetTVSeasonDetail;

  setUp(() {
    mockGetTVSeasonDetail = MockGetTVSeasonDetail();
    bloc = TVSeasonDetailBloc(mockGetTVSeasonDetail);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  const tTVSeasonDetail = TVSeasonDetail(
    id: 1,
    name: 'Season 1',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    episodes: [],
  );

  test('initial state should be empty', () {
    expect(bloc.state, TVSeasonDetailEmpty());
  });

  blocTest<TVSeasonDetailBloc, TVSeasonDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => const Right(tTVSeasonDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTVSeasonDetail(tId, tSeasonNumber)),
    expect: () => [
      TVSeasonDetailLoading(),
      const TVSeasonDetailHasData(tTVSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetTVSeasonDetail.execute(tId, tSeasonNumber));
    },
  );

  blocTest<TVSeasonDetailBloc, TVSeasonDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTVSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTVSeasonDetail(tId, tSeasonNumber)),
    expect: () => [
      TVSeasonDetailLoading(),
      const TVSeasonDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVSeasonDetail.execute(tId, tSeasonNumber));
    },
  );
}
