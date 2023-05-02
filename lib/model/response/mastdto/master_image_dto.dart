
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';

class MasterImageDTO extends MasterDataDTO{
  final String image;
  final String description;
  MasterImageDTO(String? name, int? value, this.image,this.description) : super(name, value,image: image,description: description);

}