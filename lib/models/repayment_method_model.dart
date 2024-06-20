class RepaymentMethodModel {
  String img;
  String title;
  String titleColor;
  bool isChecked;
  bool isRecommended;

  RepaymentMethodModel({required String img, required String title, required bool isChecked, required bool isRecommended, String titleColor = '#FF3B414B'})
      : this.img = img,
        this.title = title,
        this.isChecked = isChecked,
        this.isRecommended = isRecommended,
        this.titleColor = titleColor;
}
