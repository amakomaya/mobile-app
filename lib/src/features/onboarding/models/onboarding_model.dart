class GuidePagesList {
  int? pagePosition;
  String? image;
  String? title;
  String? description;

  GuidePagesList({this.pagePosition, this.image, this.title, this.description});

  factory GuidePagesList.fromJson(Map<String, dynamic> json) {
    return GuidePagesList(
        pagePosition: json['page_position'],
        image: json['image'],
        title: json['title'],
        description: json['description']);
  }

  Map<String, dynamic> toJson(GuidePagesList model) => <String, dynamic>{
        'page_position': model.pagePosition,
        'image': model.image,
        'title': model.title,
        'description': model.title
      };
}
