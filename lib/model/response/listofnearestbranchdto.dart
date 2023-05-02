import 'package:dhanvarsha/model/response/nearestbranchdetailsresponse.dart';

class ListOfNearestBranchResponseDTO {
  List<NearestBrachDetailsResponseDTO>? nearestBranchDetailsDTO;

  ListOfNearestBranchResponseDTO.from(List<dynamic> json) {
    if (json != null) {
      nearestBranchDetailsDTO = [];
      json.forEach((v) {
        nearestBranchDetailsDTO!
            .add(new NearestBrachDetailsResponseDTO.fromJson(v));
      });
    }
  }
}
