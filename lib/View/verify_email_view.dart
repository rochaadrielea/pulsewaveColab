

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Column(children: [
          const Text(          
            'ACTION NEED: Please verify your email'),
           TextButton(
            onPressed:  () async{//when the button child is pressed what I need to do             
            final user=FirebaseAuth.instance.currentUser;           
            await user?.sendEmailVerification();
                    
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/Login/',
               (_) => false,);   
      /*          
    a future void so as you know calling a function that returns a future void does not invoke the future
     it only tells the function to return the future,  so if you actually want the future to be executed
    you need to wait on it so if you then say await */
            },// ?????After this I would like to bring a login view 
            child: const Text('Send me an email verification'),
          ),
          
          
           TextButton(
            onPressed:  () async{//when the button child is pressed what I need to do 
            
            
          
              print('I WANT TO LOG OUT');
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/Login/',
               (_) => false,);
    
      /*          
    a future void so as you know calling a function that returns a future void does not invoke the future
     it only tells the function to return the future,  so if you actually want the future to be executed
    you need to wait on it so if you then say await */
            },// ?????After this I would like to bring a login view 
            child: const Text('Login here'),
          )  //text button has two very important and required parameters child and on press according to darts
        ]);
   
  }
}
