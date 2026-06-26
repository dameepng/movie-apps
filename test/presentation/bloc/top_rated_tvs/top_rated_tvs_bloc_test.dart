import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVs])
void main() {
  late TopRatedTVsBloc bloc;
  late MockGetTopRatedTVs mockUsecase;

  setUp(() {
    mockUsecase = MockGetTopRatedTVs();
    bloc = TopRatedTVsBloc(mockUsecase);
  });

  final tTV = TV(backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalName: "originalName", overview: "overview", popularity: 1.0, posterPath: "posterPath", firstAirDate: "firstAirDate", name: "name", voteAverage: 1.0, voteCount: 1);
  final ttvList = <TV>[tTV];

  test('initial state should be empty', () {
    expect(bloc.state, TopRatedTVsEmpty());
  });

  blocTest<TopRatedTVsBloc, TopRatedTVsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(ttvList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVs()),
    expect: () => [
      TopRatedTVsLoading(),
      TopRatedTVsHasData(ttvList),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<TopRatedTVsBloc, TopRatedTVsState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVs()),
    expect: () => [
      TopRatedTVsLoading(),
      const TopRatedTVsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
