import 'package:flutter/material.dart';
import 'package:project1/fourthpage.dart';


class secondpage extends StatefulWidget {
  const secondpage({super.key});

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(),
          TextButton(onPressed: (){}, child: Text('Click'))
        ],
      ),
    );
  }
}


class firsttask extends StatefulWidget {
  const firsttask({super.key});

  @override
  State<firsttask> createState() => _firsttaskState();
}

class _firsttaskState extends State<firsttask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 1'),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(),
          TextButton(onPressed: (){}, child: Text('Click'))
        ],
      ),
    );
  }
}

