import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/$entityName.dart';
import 'package:ditonton/domain/usecases/$usecaseFile.dart';

part '${folder}_event.dart';
part '${folder}_state.dart';

class $blocName extends Bloc<${featureName}Event, $stateName> {
  final $usecaseClass _usecase;

  $blocName(this._usecase) : super(${featureName}Empty()) {
    on<$eventName>((event, emit) async {
      emit(${featureName}Loading());
      final result = await _usecase.execute();
      result.fold(
        (failure) {
          emit(${featureName}Error(failure.message));
        },
        (data) {
          emit(${featureName}HasData(data));
        },
      );
    });
  }
}
