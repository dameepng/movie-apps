import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/$entityName.dart';
import 'package:ditonton/domain/usecases/$usecaseFile.dart';
import 'package:ditonton/presentation/bloc/$folder/${folder}_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '${folder}_bloc_test.mocks.dart';

@GenerateMocks([$usecaseClass])
void main() {
  late $blocName bloc;
  late Mock$usecaseClass mockUsecase;

  setUp(() {
    mockUsecase = Mock$usecaseClass();
    bloc = $blocName(mockUsecase);
  });

  final t$entityName = ${entityName == 'movie' ? 'Movie(adult: false, backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalTitle: "originalTitle", overview: "overview", popularity: 1.0, posterPath: "posterPath", releaseDate: "releaseDate", title: "title", video: false, voteAverage: 1.0, voteCount: 1)' : 'TV(backdropPath: "backdropPath", genreIds: [1, 2, 3], id: 1, originalName: "originalName", overview: "overview", popularity: 1.0, posterPath: "posterPath", firstAirDate: "firstAirDate", name: "name", voteAverage: 1.0, voteCount: 1)'};
  final t${entityName}List = <TV>[t$entityName];

  test('initial state should be empty', () {
    expect(bloc.state, ${featureName}Empty());
  });

  blocTest<$blocName, $stateName>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(t${entityName}List));
      return bloc;
    },
    act: (bloc) => bloc.add($eventName()),
    expect: () => [
      ${featureName}Loading(),
      ${featureName}HasData(t${entityName}List),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<$blocName, $stateName>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add($eventName()),
    expect: () => [
      ${featureName}Loading(),
      const ${featureName}Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
