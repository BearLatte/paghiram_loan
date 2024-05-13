import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:paghiram_loan/models/note.dart';
import 'package:paghiram_loan/util/file_manager.dart';
import 'dart:convert' as convert;

import 'package:paghiram_loan/util/random_util.dart';

class AddNoteController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  late List<Note> _notes;

  @override
  void onReady() {
    super.onReady();
    _notes = Get.arguments;
  }

  void saveNote() async {
    if (titleController.text.trim().isEmpty) {
      return CommonSnackBar.showSnackBar("Note's title cannot be empty.");
    }

    if (contentController.text.trim().isEmpty) {
      return CommonSnackBar.showSnackBar("Note's content cannot be empty.");
    }

    var formattedDate = DateFormat.MMMd().format(DateTime.now());
    var formattedYear = DateFormat.y().format(DateTime.now());

    _notes.insert(0, Note(id: RandomUtil.generateRandomString(16),year: formattedYear, date: formattedDate, title: titleController.text, content: contentController.text));
    var result = await FileManager.saveFile('notes.json', convert.jsonEncode(_notes));
    if (result != null) {
      Get.back(result: 'saved');
    }
  }
}
