import 'package:flutter/material.dart';

class fifthpage extends StatefulWidget {
  const fifthpage({super.key});

  @override
  State<fifthpage> createState() => _fifthpageState();
}

class _fifthpageState extends State<fifthpage> {
  TextEditingController inputControllera = new TextEditingController();
  TextEditingController inputControllerb = new TextEditingController();

  var value = "";
  var valueA = "";
  var valueB = "";
  var valueC = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: (){


                  setState(() {
                    inputControllera.text = "";
                    inputControllerb.text = "";
                  });

                },
                    child: Text('Clear'),
                ),


                TextField(
                  controller: inputControllera,
                ),

                TextField(
                  controller: inputControllerb,
                ),TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner + secondnumber;
                  value = result.toString();
                  setState(() {
                    value = result.toString();
                  });
                },
                    child: Text('ADD')),
                Text("$value "),

                TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner - secondnumber;
                  valueA = result.toString();
                  setState(() {
                    valueA = result.toString();
                  });
                }, child: Text('SUBTRACT')),
                Text('$valueA'),

                TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner * secondnumber;
                  valueB = result.toString();
                  setState(() {
                    valueB = result.toString();
                  });
                }, child: Text('MULTIPLY')),
                Text('$valueB'),

                TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner / secondnumber;
                  valueC = result.toString();
                  setState(() {
                    valueC = result.toString();
                  });
                }, child: Text('DIVIDE'),


                ),
                Text ('$valueC'),
              ]  ),
        ) );
  }
}


class fourthtask extends StatefulWidget {
  const fourthtask({super.key});

  @override
  State<fourthtask> createState() => _fourthtaskState();
}

class _fourthtaskState extends State<fourthtask> {
  TextEditingController inputControllera = new TextEditingController();
  TextEditingController inputControllerb = new TextEditingController();

  var value = "";
  var valueA = "";
  var valueB = "";
  var valueC = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 4'),
      ),
        body:SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: (){


                  setState(() {
                    inputControllera.text = "";
                    inputControllerb.text = "";
                  });

                },
                  child: Text('Clear'),
                ),


                TextField(
                  controller: inputControllera,
                ),

                TextField(
                  controller: inputControllerb,
                ),TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner + secondnumber;
                  value = result.toString();
                  setState(() {
                    value = result.toString();
                  });
                },
                    child: Text('ADD')),
                Text("$value "),

                TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner - secondnumber;
                  valueA = result.toString();
                  setState(() {
                    valueA = result.toString();
                  });
                }, child: Text('SUBTRACT')),
                Text('$valueA'),

                TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner * secondnumber;
                  valueB = result.toString();
                  setState(() {
                    valueB = result.toString();
                  });
                }, child: Text('MULTIPLY')),
                Text('$valueB'),

                TextButton(onPressed: (){
                  var firstnumner = int.parse(inputControllera.text);
                  var secondnumber = int.parse(inputControllerb.text);
                  var result = firstnumner / secondnumber;
                  valueC = result.toString();
                  setState(() {
                    valueC = result.toString();
                  });
                }, child: Text('DIVIDE'),


                ),
                Text ('$valueC'),
              ]  ),
        )
    );
  }
}
