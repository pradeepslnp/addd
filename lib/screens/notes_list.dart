import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_app/screens/login.dart';
import 'package:profile_app/screens/model.dart';
import '../sharedpreferences.dart';
import 'controller.dart';
import 'my_note.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  SharedPreferences logindata;
  String user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    awsa();
  }

  void awsa() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      user = logindata.getString('username');
    });
  }
  SharedPref sharedPref = SharedPref();

loadSharedPrefs() async {
  try {
    Note user = Note.fromJson(await sharedPref.read("user"));
    setState(() {
      var userLoad = user;
    });
  } catch (Excepetion) {
    // do something
  }
}
  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.put(NoteController());
    Widget getNoteList() {
      return Obx(
        () => nc.notes.length == 0
            ? Center(
                child: Text(
                  'Empty',
                  style: TextStyle(fontSize: 25),
                ),
                // child: Image.asset('assets/lists.jpeg'),
              )
            : ListView.builder(
                itemCount: nc.notes.length,
                itemBuilder: (context, index) => Card(
                      child: SingleChildScrollView(
                        child: InkWell(
                          onTap: () {
                            Get.to(MyNote(index: index));
                          },
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(nc.notes[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20)),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Department: ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    nc.notes[index].designation,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      // Text('Dep'+nc.notes[index].designation,
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.w500)),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Contact:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: nc.notes[index].number,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // child: ListTile(
                      //     title: Text(nc.notes[index].title,
                      //         style: TextStyle(fontWeight: FontWeight.w500)),
                      //     leading: Text(
                      //       (index + 1).toString() + ".",
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //     trailing: Wrap(children: <Widget>[
                      //       IconButton(
                      //           icon: Icon(Icons.create),
                      //           onPressed: () => Get.to(MyNote(index: index))),
                      //       IconButton(
                      //           icon: Icon(Icons.delete),
                      //           onPressed: () {
                      //             Get.defaultDialog(
                      //                 title: 'Delete Note',
                      //                 middleText: nc.notes[index].title,
                      //                 onCancel: () => Get.back(),
                      //                 confirmTextColor: Colors.white,
                      //                 onConfirm: () {
                      //                   nc.notes.removeAt(index);
                      //                   Get.back();
                      //                 });
                      //           })
                      //     ])),
                    )),
      );
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Employee List'),
              actions: [
                RaisedButton(
                  onPressed: () {
                    logindata.setBool('login', true);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Icon(Icons.logout),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Expanded(
              child: FloatingActionButton.extended(
                label: Text('Add Empoyee'),
                onPressed: () {
                  Get.to(MyNote());
                },
              ),
            ),
            body: Container(
              child: Padding(padding: EdgeInsets.all(5), child: getNoteList()),
            )));
  }
}
