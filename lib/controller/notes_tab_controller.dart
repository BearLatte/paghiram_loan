import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'dart:convert' as convert;
import 'package:paghiram_loan/util/file_manager.dart';
import '../models/note.dart';

class NotesTabController extends GetxController {
  var notes = [].obs;

  @override
  void onInit() async {
    super.onInit();
    notes.value = await _getNotes();
  }

  Future<List<Note>> _getNotes() async {
    String json = await FileManager.getContents('notes.json');
    if(json.isNotEmpty) {
      List<dynamic> list = convert.jsonDecode(json);
      return list.map((item) => Note.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  void go2AddNotePage() async {
     var result = await Get.toNamed(ApplicationRoutes.addNote, arguments: notes.value);
     if(result == 'saved') {
      notes.value = await _getNotes();
     }
  }

  void deleteNote(int index) {
    List<Note> ns = [];
    notes.value.forEach((element) {
      ns.add(element);
    });
    ns.removeAt(index);
    FileManager.saveFile('notes.json', convert.jsonEncode(ns));
    notes.value = ns;
  }
}
