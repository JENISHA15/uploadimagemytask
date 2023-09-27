import 'package:flutter/material.dart';

class calci extends StatefulWidget {
  const calci({super.key});

  @override
  State<calci> createState() => _calciState();
}

class _calciState extends State<calci> {
  var result = "";
  var operator = "";
  var firstnumber = "";
  var secondnumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('CALCULATOR',
          style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w300
          ),),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.bottomRight,
                child: Text(result,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w500
                  ),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: (){
                      setState(() {
                        result = result +'1';
                      });
                    }, child: Text('1',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  ),
                )

                , Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'2';
                    });
                  }, child: Text('2',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'3';
                    });
                  }, child: Text('3',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      firstnumber = result;
                      result = '';
                      operator = '+';
                    });
                  }, child: Text('+',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'4';
                    });
                  }, child: Text('4',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'5';
                    });
                  }, child: Text('5',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'6';
                    });
                  }, child: Text('6',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      firstnumber = result;
                      result = '';
                      operator = '-';
                    });
                  }, child: Text('-',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,

                    ),)),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'7';
                    });
                  }, child: Text('7',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'8';
                    });
                  }, child: Text('8',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'9';
                    });
                  }, child: Text('9',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      firstnumber = result;
                      result = '';
                      operator = '*';
                    });
                  }, child: Text('*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,

                    ),)),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = "";
                    });
                  }, child: Text('C',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,

                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      result = result +'0';
                    });
                  }, child: Text('0',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,

                    ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){

                    setState(() {
                      secondnumber = result;

                      if (operator== '+'){
                        var answer = int.parse(firstnumber) + int.parse(secondnumber);
                        result = answer.toString();
                      }
                      else if (operator== '-'){
                        var answer = int.parse(firstnumber) - int.parse(secondnumber);
                        result = answer.toString();
                      }
                      else if (operator== '*'){
                        var answer = int.parse(firstnumber) * int.parse(secondnumber);
                        result = answer.toString();
                      }
                      else {
                        var answer = int.parse(firstnumber) / int.parse(secondnumber);
                        result = answer.toString();
                      }});},
                      child: Text('=',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,

                        ),)),
                ),
                Expanded(
                  child: OutlinedButton(onPressed: (){
                    setState(() {
                      firstnumber = result;
                      result = '';
                      operator = '/';
                    });
                  },
                      child: Text('/',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),)),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}