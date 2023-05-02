
import 'package:dhanvarsha/model/successfulresponsedto.dart';

abstract class AppLoading{
  void isSuccessful(SuccessfulResponseDTO dto);
  void hideProgress();
  void showProgress();
  void showError();
}


abstract class AppLoadingMultiple{
  void isSuccessful(SuccessfulResponseDTO dto,int type);
  void hideProgress();
  void showProgress();
  void showError();
}

abstract class AppLoadingGeneric{
void isAllSuccessResponse(SuccessfulResponseDTO dto,int type);
void hideProgress();
void showProgress();
void showError();
}


abstract class AddRefLoading extends AppLoading{

  void isSuccessful2(SuccessfulResponseDTO dto);
}

