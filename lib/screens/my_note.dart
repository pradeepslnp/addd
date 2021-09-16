import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller.dart';
import 'model.dart';

class MyNote extends StatelessWidget {
  int index;

  MyNote({this.index});
  final keyy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.find();
    String name = "";
    String desig = "";

    String dept = "";

    String repo = "";
    String numb = "";

    name = index == null ? " " : nc.notes[index].name;
    TextEditingController nameEditingController =
        new TextEditingController(text: name);
    desig = index == null ? " " : nc.notes[index].designation;
    TextEditingController desigEditingController =
        new TextEditingController(text: desig);
    dept = index == null ? " " : nc.notes[index].department;
    TextEditingController deptEditingController =
        new TextEditingController(text: dept);
    repo = index == null ? " " : nc.notes[index].report;
    TextEditingController repoEditingController =
        new TextEditingController(text: repo);
    numb = index == null ? " " : nc.notes[index].number;
    TextEditingController numbEditingController =
        new TextEditingController(text: numb);
    final List<Map<String, dynamic>> _items = [
      {
        'value': 'Manager',
        'label': 'Manager',
      },
      {
        'value': 'Sr.Consultant',
        'label': 'Sr.Consultant',
      },
      {
        'value': 'Jr. Consultant',
        'label': 'Jr. Consultant',
      },
      {
        'value': 'Trainee',
        'label': 'Trainee',
      },
    ];
    final List<Map<String, dynamic>> _dept = [
//      HR,TECH,ACCOUNT,ADMIN]
      {
        'value': 'HR',
        'label': 'HR',
      },
      {
        'value': 'TECH',
        'label': 'TECH',
      },
      {
        'value': 'ACCOUNT',
        'label': 'ACCOUNT',
      },
      {
        'value': 'ADMIN',
        'label': 'ADMIN',
      },
    ];

    return Form(
      key: keyy,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: index == null
                    ? Text('Add a New Employee ')
                    : Text('Add a New Employee '),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          validator: (name) {
                            if (name.isEmpty) {
                              return 'enter the name';
                            }
                            return null;
                          },
                          controller: nameEditingController,
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.text,
                          // maxLines: 5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SelectFormField(
                          controller: desigEditingController,
                          labelText: 'select your designation',
                          items: _items,
                          validator: (designation) {
                            if (name.isEmpty) {
                              return 'select the designation';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            desig = val;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SelectFormField(
                          controller: deptEditingController,
                          labelText: 'select your Department',
                          style: TextStyle(color: Colors.black),
                          items: _dept,
                          validator: (department) {
                            if (name.isEmpty) {
                              return 'select the Department';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            dept = val;
                          },
                        ),
                        TextFormField(
                          validator: (number) {
                            if (number.isEmpty) {
                              return 'select the Department';
                            }
                            return null;
                          },
                          controller: numbEditingController,
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: ' number',
                          ),
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          // maxLines: 5,
                        ),
                        TextField(
                          controller: repoEditingController,
                          autofocus: true,
                          // maxLines: 4,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: ' report',
                          ),
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.text,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Cancel'),
                                // color: Colors.red,
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  save(String key, value) async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString(key, json.encode(value));
                                  }

                                  read(String key) async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    return json.decode(prefs.getString(key));
                                  }

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'name', nameEditingController.text);
                                  prefs.setString(
                                    'desig',
                                    desig,
                                  );
                                  prefs.setString(
                                    'desig',
                                    desig,
                                  );
                                  prefs.setString(
                                    'repoEditingController',
                                    repoEditingController.text,
                                  );
                                  prefs.setString(
                                    'numbEditingController',
                                    numbEditingController.text,
                                  );

                                  if (index == null) {
                                    nc.notes.add(
                                      Note(
                                        name: nameEditingController.text,
                                        designation: desig,
                                        department: desig,
                                        report: repoEditingController.text,
                                        number: numbEditingController.text,
                                      ),
                                    );
                                  } else {
                                    var updatenote = nc.notes[index];
                                    updatenote.name =
                                        nameEditingController.text;
                                    updatenote.designation =
                                        desigEditingController.text;
                                    updatenote.department =
                                        deptEditingController.text;
                                    updatenote.report =
                                        repoEditingController.text;
                                    updatenote.number =
                                        numbEditingController.text;

                                    nc.notes[index] = updatenote;
                                  }

                                  Get.back();
                                },
                                child: index == null
                                    ? Text('Add')
                                    : Text('Update'),
                                color: Colors.green,
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}
