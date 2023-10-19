import 'package:assignment_jit/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool passwordVisible = false;

  showAlertDialog(BuildContext context, String content) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        if (content == "Login Success") {
          Navigator.of(context).pop();
          _email.text = "";
          _password.text = "";
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Login"),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 212, 212),
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color.fromARGB(255, 245, 202, 72),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: const Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.1,
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _password,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        })),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 98, 87, 87), width: 2)),
            child: TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email.text, password: _password.text);
                  showAlertDialog(context, "Login Success");
                } on FirebaseAuthException catch (e) {
                  showAlertDialog(context, e.message.toString());
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
