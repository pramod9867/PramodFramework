class FaceRegonizeResponseDTO {
  double? matchScore;
  String? match;
  double? confidence;
  String? reviewNeeded;

  FaceRegonizeResponseDTO(
      {this.matchScore, this.match, this.confidence, this.reviewNeeded});

  FaceRegonizeResponseDTO.fromJson(Map<String, dynamic> json) {
    matchScore = json['matchScore'];
    match = json['match'];
    confidence = json['confidence'];
    reviewNeeded = json['reviewNeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchScore'] = this.matchScore;
    data['match'] = this.match;
    data['confidence'] = this.confidence;
    data['reviewNeeded'] = this.reviewNeeded;
    return data;
  }
}