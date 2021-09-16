import 'package:flutter/material.dart';
import 'package:profile_app/screens/notes_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences logindata;
  String name = '';
  bool newuser;
  String password = '';
  final password_controller = TextEditingController();
  final username_controller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    trysubmit();
  }

   

  void trysubmit() async {
    // logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    String user = username_controller.text;
    if (isValid) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoteList()));
      _formkey.currentState.save();
    }
  }

  void save() {}

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formkey,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  // color: Color(0xFFFAFAFA),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Login',
                        style: TextStyle(fontSize: 35),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            name = value;
                          },
                          validator: (email) {
                            if (email.isEmpty &&
                                !email.contains(
                                  '@',
                                )) {
                              return 'please enter the valid email address';
                            }
                            return null;
                          },
                          controller: username_controller,
                          decoration: const InputDecoration(
                            labelText: ' Mail-id',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (value) {
                            password = value;
                          },
                          controller: password_controller,
                          validator: (pass) {
                            if (pass.isEmpty) {
                              return 'enter the password ';
                            }
                            if (pass.length < 6) {
                              return ' enter min 6 charecter';
                            }
                            if (pass.length > 15) {
                              return ' maximum 15 char only';
                            }
                            if (!pass
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Must contain  1 special character.';
                            }
                            if (!pass.contains(RegExp(r'[0-9]'))) {
                              return 'Must contain  1 numwrical` character.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'password',
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            String username = username_controller.text;
                            if (_formkey.currentState.validate()) {
                              logindata.setBool('login', false);
                              logindata.setString('username', username);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NoteList()));
                            } else {
                              print('enter the valid username and password');
                            }

                            // trysubmit();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                          child: Text('Login'))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
