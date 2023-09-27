import 'package:flutter/material.dart';

class image extends StatefulWidget {
  const image({super.key});

  @override
  State<image> createState() => _imageState();
}

class _imageState extends State<image> {
  var isVisible = true;
  var firstimage = false;
  var secondimage = false;
  var thirdimage = false;
  var fourthimage = false;
  var tapcount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMAGE'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    child: Visibility(
                      visible: firstimage,


                      child: Image.asset("images/aa.jpeg"),
                    ),
                    width: 150,
                    height: 150,

                  ),
                  SizedBox(width: 10,),
                  Container(child: Visibility(
                    visible: secondimage,
                    child: Image.asset("images/aa.jpeg"),
                  ),
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 10,),


                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Visibility(
                    visible: thirdimage,
                    child: Image.asset("images/aa.jpeg"),
                  ),
                  width: 150,
                  height: 150,


                ),
                SizedBox(width: 10,),
                Container(child: Visibility(
                  visible:fourthimage,
                  child: Image.asset("images/aa.jpeg"),
                ),
                  width: 150,
                  height: 150,
                ),
              ],

            ),
            TextButton(onPressed: (){
              setState(() {

                if (tapcount == 1)
                {
                  firstimage = true;
                  secondimage = false;
                  thirdimage = false;
                  fourthimage = false;
                  tapcount = 2;
                }
                else if (tapcount == 2)
                {
                  tapcount = 3;
                  secondimage = true;
                  firstimage = false;
                  thirdimage = false;
                  fourthimage = false;
                }
                else if(tapcount == 3)
                {
                  tapcount = 4;
                  thirdimage = true;
                  secondimage = false;
                  firstimage = false;
                  fourthimage = false;
                }
                else
                {
                  tapcount = 1;
                  fourthimage = true;
                  secondimage = false;
                  thirdimage = false;
                  firstimage = false;
                }
              }
              );
            }, child: Text('Tapme'))
          ],
        ),
      ) ,
    );
  }
}


