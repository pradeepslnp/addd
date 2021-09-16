import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

import 'model.dart';

class NoteController extends GetxController {
  RxList notes = [].obs;
  void add(Note t, Note nam,Note des,Note dep,Note rep,Note num) {
    notes.add(t);
    notes.add(nam);
    notes.add(des);
    notes.add(dep);
    notes.add(rep);
    notes.add(num);

  }

  @override
  void onInit() {
    List storedNotes = GetStorage().read<List>('notes');
    if (!storedNotes.isNull) {
      notes = storedNotes.map((e) => Note.fromJson(e)).toList().obs;
    }
    ever(notes, (_) {
      GetStorage().write('notes', notes.toList());
    });
    super.onInit();
  }
}
