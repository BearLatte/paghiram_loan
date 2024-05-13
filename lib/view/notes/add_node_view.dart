import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/add_note_controller.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class AddNodeView extends StatelessWidget {
  AddNodeView({super.key});

  final controller = Get.find<AddNoteController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Add Notes',
      navTrailings: [IconButton(onPressed: controller.saveNote, icon: const Icon(Icons.check))],
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Title:', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)),
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: 52,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                    controller: controller.titleController,
                    decoration: const InputDecoration(hintText: "Please enter note's title", prefix: SizedBox(width: 12), border: InputBorder.none))),
            Container(margin: const EdgeInsets.symmetric(vertical: 20), child: Text('Content:', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16))),
            Container(
                padding: const EdgeInsets.all(12),
                height: 120,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    controller: controller.contentController,
                    decoration: const InputDecoration(hintText: "Please enter note's content", border: InputBorder.none)))
          ])),
    );
  }
}
