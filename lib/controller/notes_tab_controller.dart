import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'dart:convert' as convert;
import 'package:paghiram_loan/util/file_manager.dart';
import 'package:paghiram_loan/util/global.dart';
import '../models/note.dart';

class NotesTabController extends GetxController {
  var notes = [].obs;

  Future<List> getNotes() async {
    if (!Global.isLogin) return [];
    String json = await FileManager.getContents(Global.phoneNumber! + '_notes');
    if (json.isNotEmpty) {
      List<dynamic> list = convert.jsonDecode(json);
      return list.map((item) => Note.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  void go2AddNotePage() async {
    if (!Global.isLogin) {
      var result = await Get.toNamed(ApplicationRoutes.login);
      notes.value = await getNotes();
      return;
    }
    var result = await Get.toNamed(ApplicationRoutes.addNote, arguments: notes);
    if (result == 'saved') {
      notes.value = await getNotes();
    }
  }

  void deleteNote(int index) {
    List<Note> ns = [];
    notes.forEach((element) {
      ns.add(element);
    });
    ns.removeAt(index);
    FileManager.saveFile(Global.phoneNumber!, convert.jsonEncode(ns));
    notes.value = ns;
  }
}
