// class NearestBranchDetails {
//   bool? status;
//   String? message;
//   List<BranchDetailsData>? branchDetailsData;
//
//   NearestBranchDetails({this.status, this.message, this.branchDetailsData});
//
//   NearestBranchDetails.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['BranchDetailsData'] != null) {
//       branchDetailsData = [];
//       json['BranchDetailsData'].forEach((v) {
//         branchDetailsData!.add(new BranchDetailsData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.branchDetailsData != null) {
//       data['BranchDetailsData'] =
//           this.branchDetailsData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class BranchDetailsData{
//
// }
