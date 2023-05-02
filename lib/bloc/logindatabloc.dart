import 'package:dhanvarsha/framework/bloc_provider.dart';

class LoginDataBloc extends Bloc{
  int? count;

  void setInteger(){
    count=2;
  }

  @override
  dispose() {
    return null;
  }

}