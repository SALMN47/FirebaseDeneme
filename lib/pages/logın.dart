import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  FirebaseAuth myAuth = FirebaseAuth.instance;
  GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String mail = '';
  String password = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: myFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            fieldarea(
              'EMAIL',
              emailController,
            ),
            fieldarea(
              'PASSWORD',
              passwordController,
            ),
            SizedBox(
              height: 20,
            ),
            isLoading ? CircularProgressIndicator() : loginButton(context),
            createButton(context)
          ],
        ),
      ),
    );
  }

  TextButton createButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/signup');
        },
        child: Text(' CREATE ACCOUNT'));
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        if (myFormKey.currentState!.validate()) {
          setState(() {
            mail = emailController.text;
            password = passwordController.text;
          });
          try {
            await myAuth.signInWithEmailAndPassword(
                email: mail, password: password);
            Navigator.pushNamed(context, '/home');
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('NO USER FOUND FOR THAT EMAIL');
            } else if (e.code == 'wrong-password') {
              print('WRONG PASSWORD PROVIDED');
            } else if (e.code == 'invalid-email') {
              print('INVALID EMAIL');
            } else if (e.code == 'user-disabled') {
              print('USER DISABLED');
            } else {
              print('Error: ${e.message}');
            }
          } catch (e) {
            print('Error: $e');
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        }
      },
      child: Text('LOG IN'),
    );
  }

  Widget fieldarea(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'PLEASE ENTER YOUR $text';
          }
          return null;
        },
        decoration: InputDecoration(
          labelStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.green[900], fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.green, width: 2)),
          labelText: text,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
