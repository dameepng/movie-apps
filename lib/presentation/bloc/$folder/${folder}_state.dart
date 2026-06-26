part of '${folder}_bloc.dart';

abstract class $stateName extends Equatable {
  const $stateName();
  
  @override
  List<Object> get props => [];
}

class ${featureName}Empty extends $stateName {}

class ${featureName}Loading extends $stateName {}

class ${featureName}Error extends $stateName {
  final String message;

  const ${featureName}Error(this.message);

  @override
  List<Object> get props => [message];
}

class ${featureName}HasData extends $stateName {
  final List<${entityName.toUpperCase()}> result;

  const ${featureName}HasData(this.result);

  @override
  List<Object> get props => [result];
}
