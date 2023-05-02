import 'dart:convert';

import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/mastdto/master_super_dto.dart';

class MasterDocumentId {
  static MasterDocumentId builder = MasterDocumentId();
  MasterBloc? masterBloc;
  MasterSuperDTO? masterSuperDTO;

  List<MasterDataDTO>? countryDto;

  List<MasterDataDTO>? stateDTO;

  List<MasterDataDTO>? districtDTO;

  List<MasterDataDTO>? talukaDTO;
  MasterDocumentId() {
    print("Costructor called");
    masterBloc = BlocProvider.getBloc<MasterBloc>();

    countryDto = masterBloc?.countryDTO.value;
    stateDTO = masterBloc?.stateDTO.value;
    districtDTO = masterBloc?.districtDTO.value;
    talukaDTO = masterBloc?.talukaDTO.value;
    masterSuperDTO = masterBloc?.masterSuperDTO;
  }

  int getMasterID(String identifier) {
    List<MasterDataDTO> documentTags = masterSuperDTO?.documentTag ?? [];

    for (int i = 0; i < documentTags.length; i++) {
      if (documentTags[i].name == identifier) {
        return documentTags[i].value ?? 0;
      }
    }

    return 0;
  }

  String getProductIdGetter(String identifier){

    List<MasterDataDTO> productIds = masterSuperDTO?.productId ?? [];
    //
    // print("DOc Tags");
    // print(jsonEncode(productIds));

    for (int i = 0; i < productIds.length; i++) {
      if (productIds[i].name == identifier) {
        return productIds[i].value.toString();
      }
    }



    return "";
  }



  int getMasterProductIDInt(String identifier) {
    List<MasterDataDTO> productidInt = masterSuperDTO?.productId ?? [];

    for (int i = 0; i < productidInt.length; i++) {
      if (productidInt[i].name == identifier) {
        return productidInt[i].value ?? 0;
      }
    }

    return 0;
  }

  int getMasterAddressID(String identifier) {



    List<MasterDataDTO> documentTags = masterSuperDTO?.addressTypeOptions ?? [];

    print("DOc Tags");
    print(jsonEncode(documentTags));

    for (int i = 0; i < documentTags.length; i++) {
      if (documentTags[i].name == identifier) {
        return documentTags[i].value ?? 0;
      }
    }

    return 0;
  }


  int getMasterOwnYesNo(String identifier) {
    List<MasterDataDTO> documentTags = masterSuperDTO?.ownedAndCoownedPropertyAddress ?? [];

    print("hello");
    print(documentTags);
    print(identifier);

    for (int i = 0; i < documentTags.length; i++) {
      if (documentTags[i].name == identifier) {
        print("Here comes Yes");

        print(documentTags[i].value);
        return documentTags[i].value ?? 0;
      }
    }

    print("Here comes");
    return 0;
  }



  int getBankYesNoType(String identifier) {
    List<MasterDataDTO> documentTags = masterSuperDTO?.havingCurrentBankAccount ?? [];

    print("hello");
    print(documentTags);
    print(identifier);

    for (int i = 0; i < documentTags.length; i++) {
      if (documentTags[i].name == identifier) {
        print("Here comes Yes");

        print(documentTags[i].value);
        return documentTags[i].value ?? 0;
      }
    }

    print("Here comes");
    return 0;
  }



  int getGenderIndex(int id) {
    List<MasterDataDTO> genderOptions = masterSuperDTO?.genderOptions ?? [];

    print("ID IS");
    print(id);
    print("Encoded JSON");
    print(jsonEncode(genderOptions));
    for (int i = 0; i < genderOptions.length; i++) {
      if (genderOptions[i].value == id) {
        print(genderOptions[i].value);
        print("Index New is" + i.toString());
        return i;
      }
    }
    return -1;
  }



  int getNatureOfBusinessId(int id) {
    List<MasterDataDTO> natureofbusinesid = masterSuperDTO?.natureofBusiness ?? [];

    // print("ID IS");
    // print(id);
    // print("Encoded JSON");
    // print(jsonEncode(natureofbusinesid));
    for (int i = 0; i < natureofbusinesid.length; i++) {
      if (natureofbusinesid[i].value == id) {
        print(natureofbusinesid[i].value);
        print("Index New is" + i.toString());
        return i;
      }
    }
    return -1;
  }

  int getModeOfSalaryIndex(int id) {
    List<MasterDataDTO> genderOptions = masterSuperDTO?.modeOfSalary ?? [];

    for (int i = 0; i < genderOptions.length; i++) {
      print("Mode Of Salary");
      print(genderOptions[i].value);
      if (genderOptions[i].value == id) {
        return i;
      }
    }
    return 0;
  }

  int getIndexOfFirmType(int id){
    List<MasterDataDTO> businessFirmDTO = masterSuperDTO?.businessFirmType ?? [];

    for (int i = 0; i < businessFirmDTO.length; i++) {
      print("Mode Of Salary");
      print(businessFirmDTO[i].value);
      if (businessFirmDTO[i].value == id) {
        return i;
      }
    }
    return 0;
  }

  int getRelationshipIndex(int id) {
    List<MasterDataDTO> relationDTO = masterSuperDTO?.relationType ?? [];

    for (int i = 0; i < relationDTO.length; i++) {
      print("Mode Of Salary");
      print(relationDTO[i].value);
      if (relationDTO[i].value == id) {
        print("Into the relationship Id" + id.toString());
        print("Return ID IS" + i.toString());
        return i;
      }
    }
    return 0;
  }




  int getCoapplicantRelationshipId(int id) {
    List<MasterDataDTO> coapplicantrelationid = masterSuperDTO?.coApplicantRelationShip ?? [];

    for (int i = 0; i < coapplicantrelationid.length; i++) {
      print("Mode Of Salary");
      print(coapplicantrelationid[i].value);
      if (coapplicantrelationid[i].value == id) {
        return i;
      }
    }
    return 0;
  }

  List<MasterDataDTO> getMasterObjectCompany(int id) {
    List<MasterDataDTO> empType = masterSuperDTO?.companyType ?? [];



    print("ID FROM CUSTOMER");
    print(id);
    for (int i = 0; i < empType.length; i++) {
      if (empType[i].value == id) {
        return [empType[i]];
      }
    }
    return [];
  }

  List<MasterDataDTO> getMasterObjectEmployer(int id) {
    List<MasterDataDTO> empType = masterSuperDTO?.clientTypeOptions ?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].value == id) {
        return [empType[i]];
      }
    }
    return [];
  }

  List<MasterDataDTO> getMasterObjectEmpEng(int id) {
    List<MasterDataDTO> empType = masterSuperDTO?.empType ?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].value == id) {
        return [empType[i]];
      }
    }
    return [];
  }
  List<MasterDataDTO> getMasterObjectCountry(int id) {
    List<MasterDataDTO> empType = countryDto?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].value == id) {
        return [empType[i]];
      }
    }
    return [];
  }

  List<MasterDataDTO> getMasterObjectState(int id) {
    List<MasterDataDTO> empType = stateDTO ?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].value == id) {
        return [empType[i]];
      }
    }
    return [];
  }



  List<MasterDataDTO> getMasterObjectStateByName(String name) {
    List<MasterDataDTO> empType = stateDTO ?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].name == name) {
        return [empType[i]];
      }
    }
    return [];
  }
  List<MasterDataDTO> getMasterObjectDistrictByName(String name) {
    List<MasterDataDTO> empType = districtDTO ?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].name == name) {
        return [empType[i]];
      }
    }
    return [];
  }


  List<MasterDataDTO> getMasterObjectTaluka(String id) {
    List<MasterDataDTO> empType = talukaDTO ?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].name == id) {
        return [empType[i]];
      }
    }
    return [];
  }
  List<MasterDataDTO> getMasterObjectDistrict(int id) {
    List<MasterDataDTO> empType = districtDTO ?? [];

    for (int i = 0; i < empType.length; i++) {
      if (empType[i].value == id) {
        return [empType[i]];
      }
    }
    return [];
  }

}
