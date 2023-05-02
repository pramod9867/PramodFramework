import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/networkurl.dart';
import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';
import 'package:dio/dio.dart';

class RejectReasonBloc extends Bloc {
  addRejectReason(FormData formData) {
    DioDhanvarshaWrapper((SuccessfulResponseDTO dto) {}, () {}, () {}, formData,
            NetworkConstants.networkUrl.addReason())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
