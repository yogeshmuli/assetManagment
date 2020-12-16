class AssetsModel {
  String id;
  String assetType;
  String assetStatus;
  String companyName;
  String serialNo;
  String color;
  String macAddress;
  String operatingSystem;
  String purchasedFrom;
  DateTime purchasedOn;
  double price;
  String notes;

  AssetsModel(
      {this.id,
      this.assetStatus,
      this.assetType,
      this.color,
      this.companyName,
      this.macAddress,
      this.notes,
      this.operatingSystem,
      this.price,
      this.purchasedOn,
      this.serialNo,
      this.purchasedFrom});

  AssetsModel.fromMap(assetMap) {
    this.assetStatus = assetMap["assetStatus"];
    this.id = assetMap["id"];
    this.assetType = assetMap["assetType"];
    this.color = assetMap["color"];
    this.companyName = assetMap["companyName"];
    this.macAddress = assetMap["macAddress"];
    this.notes = assetMap["notes"];
    this.operatingSystem = assetMap["operatingSystem"];
    this.price = assetMap["price"];
    this.serialNo = assetMap["serialNo"];
    this.purchasedFrom = assetMap["purchasedFrom"];
    this.purchasedOn = DateTime.parse(assetMap["purchasedOn"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "assetType": this.assetType,
      "assetStatus": this.assetStatus,
      "companyName": this.companyName,
      "serialNo": this.serialNo,
      "color": this.color,
      "macAddress": this.macAddress,
      "operatingSystem": this.operatingSystem,
      "purchasedFrom": this.purchasedFrom,
      "purchasedOn": this.purchasedOn.toIso8601String(),
      "price": this.price,
      "notes": this.notes
    };
  }
}
