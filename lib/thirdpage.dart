import 'package:flutter/material.dart';
import 'package:project1/fourthpage.dart';

class thirdpage extends StatefulWidget {
  const thirdpage({super.key});

  @override
  State<thirdpage> createState() => _thirdpageState();
}

class _thirdpageState extends State<thirdpage> {
  TextEditingController inputController = new TextEditingController();
  String _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: inputController,
            ),
            TextButton(onPressed: (){
              setState(() {
                _text = inputController.text;
              });
            }, child: Text('Click')),
            Text('$_text') ],

        ),


    );
  }
}

class secontask extends StatefulWidget {
  const secontask({super.key});

  @override
  State<secontask> createState() => _secontaskState();
}

class _secontaskState extends State<secontask> {
  TextEditingController inputController = new TextEditingController();
  String _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 2'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: inputController,
          ),
          TextButton(onPressed: (){
            setState(() {
              _text = inputController.text;
            });
          }, child: Text('Click')),
          Text('$_text') ],

      ),
    );
  }
}



