class RepaymentMethodModel {
  int id;
  String img;
  String title;
  String titleColor;
  bool isChecked;
  bool isRecommended;
  bool needsShowBarCode;

  RepaymentMethodModel({
    int id = 0,
    required String img,
    required String title,
    required bool isChecked,
    required bool isRecommended,
    String titleColor = '#FF3B414B',
    bool needsShowBarCode = false,
  })  : this.id = id,
        this.img = img,
        this.title = title,
        this.isChecked = isChecked,
        this.isRecommended = isRecommended,
        this.titleColor = titleColor,
        this.needsShowBarCode = needsShowBarCode;
}
