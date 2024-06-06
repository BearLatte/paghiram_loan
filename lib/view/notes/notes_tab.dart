import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/controller/notes_tab_controller.dart';
import 'package:paghiram_loan/models/note.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class NotesTab extends StatelessWidget {
  NotesTab({super.key});

  final controller = Get.find<NotesTabController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
            width: 52,
            height: 52,
            child: ElevatedButton(
                onPressed: controller.go2AddNotePage,
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Constant.themeColor), padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: const Icon(Icons.add, size: 24, color: Colors.white))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
            color: HexColor('#FFFAFAFA'),
            child: Column(children: [
              Stack(children: [
                Container(color: Constant.themeColor, height: 140),
                const Positioned(right: 0, left: 0, bottom: 0, child: CommonImage(src: 'asset/images/bubble_mask.png', fit: BoxFit.cover)),
                const Positioned(left: 22, bottom: 16, child: Text('Repayment\nNotepad', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                const Positioned(bottom: 2, right: 24, child: CommonImage(src: 'asset/icons/calendar.png'))
              ]),
              Obx(() => controller.notes.isEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 62),
                      child: Column(
                          children: [const CommonImage(src: 'asset/icons/note_no_data_icon.png'), Text('No notes', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15))]),
                    )
                  : Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              itemCount: controller.notes.length,
                              itemBuilder: (context, index) => _listItem(controller.notes[index] as Note, () => controller.deleteNote(index)))))),
              // Expanded(child: SingleChildScrollView())
            ])));
  }

  Widget _listItem(Note note, void Function() deleteAction) {
    return Slidable(
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) => deleteAction(),
            backgroundColor: Colors.transparent,
            foregroundColor: HexColor('#FFFE4A49'),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(note.date, style: TextStyle(fontSize: 15, color: HexColor('#FF00A9B8'))),
                Text(note.year, style: TextStyle(fontSize: 15, color: HexColor('#FF00A9B8')))
              ]),
              Container(color: HexColor('#FFCCCCCC'), width: 0.5, height: 24, margin: const EdgeInsets.symmetric(horizontal: 12)),
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 13)),
              ]))
            ],
          ),
        ));
  }
}
