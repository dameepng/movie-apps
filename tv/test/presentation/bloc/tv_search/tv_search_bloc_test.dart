import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tvs.dart';
import 'package:tv/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTVs])
void main() {
  late TVSearchBloc bloc;
  late MockSearchTVs mockUsecase;

  setUp(() {
    mockUsecase = MockSearchTVs();
    bloc = TVSearchBloc(mockUsecase);
  });

  final tTV = TV(backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalName: "originalName", overview: "overview", popularity: 1.0, posterPath: "posterPath", firstAirDate: "firstAirDate", name: "name", voteAverage: 1.0, voteCount: 1);
  final ttvList = <TV>[tTV];
  final tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(bloc.state, TVSearchEmpty());
  });

  blocTest<TVSearchBloc, TVSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => Right(ttvList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    expect: () => [
      TVSearchLoading(),
      TVSearchHasData(ttvList),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(tQuery));
    },
  );

  blocTest<TVSearchBloc, TVSearchState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    expect: () => [
      TVSearchLoading(),
      const TVSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute(tQuery));
    },
  );
}
