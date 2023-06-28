class DeliveryModel {
  String problem;
  String problemNp;
  String key;
  int id;
  bool isSelected;
  bool selected;
  DeliveryModel(
      {required this.id,
        this.key = '',
        required this.isSelected,
        required this.problem,
        required this.problemNp,
        this.selected = false});

  @override
  String toString() {
    return 'DeliveryModel(problem: $problem,problemNp: $problemNp, key: $key, id: $id, isSelected: $isSelected, selected: $selected)';
  }
}