import 'dart:convert';
import '../models/certify_selection_data_entity.dart';
import 'constant.dart';
import 'file_manager.dart';

enum SelectionType { usage, edu, industry, experience, salary, marital, numOfChildren, religion, ownership }

class VerifySelectionUtil {
  static Future<CertifySelectionDataEntity> get optionalsData async {
    var data = await FileManager.getFileContentFromTempDirectory(Constant.CERTIFICATION_OPTIONAL_CONTENT);
    var optionalsData = CertifySelectionDataEntity.fromJson(jsonDecode(data));
    return optionalsData;
  }

  static Future<List<String>> getOptions(SelectionType type) async {
    var options = await optionalsData;

    List list = [];
    switch (type) {
      case SelectionType.usage:
        list = options.loanPur;
      case SelectionType.edu:
        list = options.eschool;
      case SelectionType.industry:
        list = options.branch;
      case SelectionType.experience:
        list = options.userWork;
      case SelectionType.salary:
        list = options.mySalary;
      case SelectionType.marital:
        list = options.merryState;
      case SelectionType.numOfChildren:
        list = options.kidNumber;
      case SelectionType.religion:
        list = options.userReligion;
      case SelectionType.ownership:
        list = options.lvlTime;
    }

    List<String> curOptions = [];
    list.forEach((element) {
      curOptions.add(element.title);
    });

    return curOptions;
  }
}
