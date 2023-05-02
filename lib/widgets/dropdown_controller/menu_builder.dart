import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:flutter/cupertino.dart';

class MenueBuilder{
  ValueNotifier<List<MasterDataDTO>> menuNotifier = ValueNotifier([]);


  onItemSelect(MasterDataDTO masterDataDTO){
    if(menuNotifier.value.length==0){
      menuNotifier.value.add(masterDataDTO);
    }else{
      menuNotifier.value.removeAt(0);
      menuNotifier.value.add(masterDataDTO);
    }

    print(menuNotifier.value.elementAt(0).name);
    menuNotifier.notifyListeners();
  }

  setInitialValue(List<MasterDataDTO> dto) {
    print("Dto is");
    print(dto);
    menuNotifier.value= dto;
  }
}