class WizardModel {
  int? id;
  String? title;
  String? motto;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? hierarchy;

  WizardModel(
      {this.id,
      this.image,
      this.title,
      this.motto,
      this.createdAt,
      this.hierarchy,
      this.updatedAt});

  factory WizardModel.fromJson(Map<String, dynamic> json) {
    return WizardModel(
      image: json["image"],
      title: json["title"],
      createdAt: json["created_at"],
      hierarchy: json["hierarchy"],
      id: json["id"],
      motto: json["motto"],
      updatedAt: json["updated_at"],
    );
  }
}
