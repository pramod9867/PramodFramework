// @dart=2.9

abstract class Bloc {
  dispose();
}

class BlocProvider {
  static Map<Type, Bloc> _singletonBlocMap = {};
  static Map<Type, Map<String, Bloc>> _blocMap = {};

  static printAllBlocs() {
    print(_singletonBlocMap);
    print(_blocMap);
  }

  static setBloc<T extends Bloc>(T bloc, {String identifier}) {
    if (identifier == null) {
      _singletonBlocMap[T] = bloc;
    } else {
      Map<String, Bloc> blocIdentifierMap = _blocMap[T];
      print(blocIdentifierMap);
      if (blocIdentifierMap == null) {
        blocIdentifierMap = {};
        _blocMap[T] = blocIdentifierMap;
        print(blocIdentifierMap);
      }
      blocIdentifierMap[identifier] = bloc;
    }
  }

  static T getBloc<T extends Bloc>({String identifier}) {
    if (identifier == null) {
      return _singletonBlocMap[T];
    } else {
      Map<String, Bloc> blocIdentifierMap = _blocMap[T];
      if (blocIdentifierMap != null) {
        print(blocIdentifierMap);
        return blocIdentifierMap[identifier];
      }
    }
    return null;
  }

  static disposeAllBlocs() {
    _singletonBlocMap = {};
    _blocMap = {};
  }
}
