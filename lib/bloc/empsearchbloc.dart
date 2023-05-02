import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/model/response/empresponsedto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum ListListner { INITIAL, EMPTY, INPROGRESS, SUCCESSFUL, ERROR }

class EmpSearchBloc extends Bloc {
  List<EmployerResponseDTO>? _empList;

  ValueNotifier<ListListner> listNotifier = ValueNotifier(ListListner.INITIAL);

  EmpSearchBloc() {
    listNotifier.value = ListListner.INITIAL;
  }

  getEmpSearchOptions(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  _empList = jsonDecode(dto.data!) != null
                      ? jsonDecode(dto.data!) as List != null
                          ? (jsonDecode(dto.data!) as List).map((i) {
                              return EmployerResponseDTO.fromJson(i);
                            }).toList()
                          : []
                      : [],
                  if (_empList!.length > 0) {
                    listNotifier.value=ListListner.SUCCESSFUL
                  } else {
                    listNotifier.value=ListListner.EMPTY
                  }
                },
            () => {
              listNotifier.value=ListListner.INPROGRESS
            },
            () => {
              listNotifier.value=ListListner.ERROR
            },
            formData,
            NetworkConstants.networkUrl.getEmployerName())
        .postDioResponse();
  }

  List<EmployerResponseDTO> get empList => _empList!;

  set empList(List<EmployerResponseDTO> value) {
    _empList = value;
  }

  @override
  dispose() {
    return null;
  }
}
