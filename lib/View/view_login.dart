import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'verify_email_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => LoginViewState();
}

///********************HomePageState Class ********************
class LoginViewState extends State<LoginView> {
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
      appBar: AppBar(title: const Text('Login to Your Temple Guard')),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            /*   one thing that we do need in
this snapshot is its state you see a future has a start point it has a line
where it processes its information and it has an end point it either ends
successfully or it fails now the snapshot is your way of getting the

results of your future whether it has it started is it processing is it*/

            switch (snapshot.connectionState) {
              case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              print(user);

              if (user !=
                  null) //verification could be read as true or false and if you can't use false if the
              //equation then in itself is true then the user is verified
              {
                if (user.emailVerified) {
                  return  Column(children: [
                        TextButton(
                            onPressed: (() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/Login/', (route) => false);
                            }),
                            child:
                                const Text('Email alredy verified. Login Here'))
                      ]);
                } else {
                  return Column(children: [
                   TextButton(
                            onPressed: (() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/Register/', (route) => false);
                            }),
                            child:
                                const Text('Register with other email'),
                               ),
                                  TextButton(
                        onPressed: (() {
                          user.sendEmailVerification();

                          //Navigator.of(context).pushNamedAndRemoveUntil('/Login/', (route) => false);
                          
                        }), 
                      
                      child: const Text('Email not verified, Send Email Verification'))
                      ]);
                }
              }
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
                       // try {
                          final email = _email.text;
                          final password = _passaword.text;
                          //isntead create we will sign in final usercreadentials=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                          final usercredentials = FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);
                                 
                          print(usercredentials);// it is not printing
                    
                       /* } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('User Not Found');
                          }

                          if (e.code == 'wrong-password') {
                            print('Wrong Password');
                          }
                        } // catch*/
                      }, //on pressed async
                      child: const Text('Log in to your account')
                      ),
                      // after the button we want another rext button in case to the person didnt registered yet

                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).pushNamedAndRemoveUntil('/Register/', (route) => false);
                          
                        }), 
                      
                      child: const Text('Not registered yet? Register Here'))
                      
                ]
                
                
                );
              default:
                return const Text('Loading');
            }
          }),
          //isntead create we will sign in final usercreadentials=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
               
         
    );
  }
}
