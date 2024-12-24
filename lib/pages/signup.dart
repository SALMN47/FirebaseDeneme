import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String mail = '';
  String password = '';
  bool isLoading = false;

  FirebaseAuth myAuth = FirebaseAuth.instance;
  GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: myFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER YOUR EMAİL';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'EMAİL',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER YOUR PASSWORD';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (myFormKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                              mail = emailController.text;
                              password = passwordController.text;
                            });
                            try {
                              await myAuth.createUserWithEmailAndPassword(
                                  email: mail, password: password);
                              Navigator.pushNamed(context, '/login');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User Created')));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              } else if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
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
                        child: Text('CREATE YOUR ACCOUNT'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
