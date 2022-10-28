




import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormView();}

}

  class _FormView extends State<FormView>{
  TextEditingController dateinput = TextEditingController(); 
  //text editing controller for text field
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Temple Guard Form')),

body: Container(
padding: const EdgeInsets.all(20.0),

child: ListView(
children: <Widget> [
   
TextFormField(
// ignore: prefer_const_constructors
decoration: InputDecoration (
 labelText: 'First Name',
 border: const OutlineInputBorder(),
)
),
const Padding(padding:  EdgeInsets.all(5.0),
),
TextFormField(
// ignore: prefer_const_constructors
decoration: InputDecoration (
 labelText: 'Last Name',
 border: const OutlineInputBorder(),
)
),


const Padding(padding:  EdgeInsets.all(5.0),
),
TextField(
   controller: dateinput,
                 //editing controller of this TextField
                decoration: const InputDecoration( 
                   icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Enter you birth Date" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement
               setState(() {
                         dateinput.text = formattedDate; //set output date to TextField value. 
                      });
                    
                  }else{
                      print("Date is not selected");
                  }
                },
),
    Padding(
      key: _formKey,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                  Navigator.of(context).pushNamedAndRemoveUntil(
              '/Risk/',
               (_) => false,);
                if (_formKey.currentState!.validate()) {
                 ;
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
],
),
),
    );    
  }
}