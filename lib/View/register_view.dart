import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _passaword;
  @override
  void initState() {
    _email = TextEditingController();
    _passaword = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _passaword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // is the owner of the homepage
      appBar: AppBar(title: const Text(' Register to Temple Guard')),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            /*one thing that we do need in
this snapshot is its state you see a future has a start point it has a line
where it processes its information and it has an end point it either ends
successfully or it fails now the snapshot is your way of getting the

results of your future whether it has it started is it processing is it
    */
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(children: [
                  TextField(
                    controller: _email,
                    obscureText: false,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(hintText: 'Enter your email'),
                  ),
                  TextField(
                    controller: _passaword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: 'Enter your Password'),
                  ),
                  TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _passaword.text;
                       // try {
                          final usercreadentials = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          print(usercreadentials);
                       /* } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('Weak Password');
                          } else if(e.code=='email-already-in-use'){
                               final usercreadentials = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                            print(usercreadentials);
                            print('Email Already in Use');
                          }else if(e.code=='invalid email'){
                            print('Invalided Email entered, check if is missing some caracter ');
                          }
                        }*/
                      },
                      child: const Text('Register')),
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).pushNamedAndRemoveUntil('/Login/', (route) => false);
                          
                        }), 
                      
                      child: const Text('Already register? Login Here'))
                ]);
              default:
                return const Text('Loading');
            }
          }),
    );
  }
}
