//farmer model
class FarmersModel {
  String? fullName;
  String? gender;
  String? address;
  double? plotArea;
  String? crop;
  String? variety;
  String? plantingDate;
  String? ageOfCrop;

  FarmersModel(
      {this.fullName,
      this.gender,
      this.address,
      this.plotArea,
      this.crop,
      this.variety,
      this.plantingDate,
      this.ageOfCrop});

  FarmersModel.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    gender = json["gender"];
    address = json["address"];
    plotArea = json["plotArea"].toDouble();
    crop = json["crop"];
    variety = json["variety"];
    plantingDate = json["plantingDate"];
    ageOfCrop = json["ageOfCrop"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fullName"] = fullName;
    data["gender"] = gender;
    data["address"] = address;
    data["plotArea"] = plotArea;
    data["crop"] = crop;
    data["variety"] = variety;
    data["plantingDate"] = plantingDate;
    data["ageOfCrop"] = ageOfCrop;
    return data;
  }
}
