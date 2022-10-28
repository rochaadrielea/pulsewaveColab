

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:temple_guard/Bluetooth/bluetest.dart';
import 'package:temple_guard/View/verify_email_view.dart';
import 'package:temple_guard/View/view_form.dart';

import 'package:temple_guard/View/view_login.dart';
import 'package:temple_guard/View/view_logout.dart';
import 'package:temple_guard/View/view_riskgroups.dart';



import 'View/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TempleGuardApp());
}

///********************HomePage Class ********************
class TempleGuardApp extends StatelessWidget {
  const TempleGuardApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temple Guard Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.indigo.shade900,
          secondary: Colors.blue.shade700,
          // or from RGB
          /* 
        primarySwatch: Colors.blue,*/
        ),
      ),
      //home: const Homepage(),// verify email view
      //home: const LoginView(),
      //home: FormView(),
     // home: const GroupRisks(),
      //home: const RegisterView  (),
       home: const FlutterBlueApp(),
    // home: const BluetoothTempleGuard(),
     // home:  const Bluetempleguard(),
      routes: {
        '/Login/': (context) => const LoginView(),
        '/Register/': (context) => const RegisterView(),
       '/Logout/': (context) => const LogoutView(),
       '/Form/': (context) =>  FormView(),
       '/Risk/': (context) =>  const GroupRisks(),
      },
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
               if (user !=  null) //verification could be read as true or false and if you can't use false if the
              //equation then in itself is true then the user is verified
              {
                if (user.emailVerified) {
                  return const Logout();
                } else {
                  return const VerifyEmailView();
                }
              }else{

                return const LoginView(); 
              }
           
            default:
              return const CircularProgressIndicator();
          }
        });
  } //widget
}


class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: const Text('quero logar out'),),


    );
  }
}