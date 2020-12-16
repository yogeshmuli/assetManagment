class AssetsTypeModel {
  int id;
  String title;
  String notes;

  AssetsTypeModel({this.id, this.notes, this.title});

  AssetsTypeModel.fromMap(assetsTypeMap) {
    this.id = assetsTypeMap["id"];
    this.title = assetsTypeMap["title"];
    this.notes = assetsTypeMap["notes"];
  }

  Map<String, dynamic> toJson() {
    return ({"id": this.id, "title": this.title, "notes": this.notes});
  }
}
