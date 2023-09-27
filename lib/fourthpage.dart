import 'package:flutter/material.dart';

class fourthpage extends StatefulWidget {
  const fourthpage({super.key});

  @override
  State<fourthpage> createState() => _fourthpageState();
}

class _fourthpageState extends State<fourthpage> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField( onChanged: (val){
            setState(() {
              name = val;
            });
          },),

          Text("$name")
        ],
      ),

    );
  }
} //task3


/*class detailspage extends StatelessWidget {
  const detailspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Text('HELLO'),
      ),
    );
  }
}*/


class thirdtask extends StatefulWidget {
  const thirdtask({super.key});

  @override
  State<thirdtask> createState() => _thirdtaskState();
}

class _thirdtaskState extends State<thirdtask> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 3'),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField( onChanged: (val){
            setState(() {
              name = val;
            });
          },),

          Text("$name")
        ],
      ),

    );
  }
}
