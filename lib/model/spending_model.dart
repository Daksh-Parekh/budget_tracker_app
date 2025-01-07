class SpendingModel {
  int id, categoryId;
  String desc, mode, date;
  num amount;

  SpendingModel(
      {required this.id,
      required this.desc,
      required this.amount,
      required this.mode,
      required this.date,
      required this.categoryId});

  factory SpendingModel.fromMap(Map data) {
    return SpendingModel(
        id: data['spend_id'],
        desc: data['spend_desc'],
        amount: data['spend_amount'],
        mode: data['spend_mode'],
        date: data['spend_date'],
        categoryId: data['spen_category_id']);
  }
}
