import 'package:flutter/material.dart';

class listgrid extends StatefulWidget {
  const listgrid({super.key});

  @override
  State<listgrid> createState() => _listgridState();
}

class _listgridState extends State<listgrid> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2, child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('List view & Grid view',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),),

        bottom:TabBar(indicator: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(25.0)
        ),
          tabs: [
            Text('List view',
              style: TextStyle(

                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.black
              ),),
            Text('Grid view',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.black

              ),
            ),

          ],

        ), ),

      body: TabBarView(children: [
        listviewpage(),
        gridviewpage()
      ]),


    )
    );
  }
}






class listviewpage extends StatefulWidget {
  const listviewpage({super.key});

  @override
  State<listviewpage> createState() => _listviewpageState();
}

class _listviewpageState extends State<listviewpage> {
  var flowers = ["Rose","Lotus","Daisy", "Hibiscus","Dahlia", "Jasmine","Marigold", "Bougainvillea","Sunflower", "Tulip"];
  var images =['https://t3.ftcdn.net/jpg/01/05/57/38/360_F_105573812_cvD4P5jo6tMPhZULX324qUYFbNpXlisD.jpg',
    'https://static.vecteezy.com/system/resources/previews/009/887/145/non_2x/pink-lotus-flower-free-png.png',
    'https://hips.hearstapps.com/hmg-prod/images/daisy-flower-1532449822.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/c/cb/Hibiscus_flower_TZ.jpg',
    'https://t4.ftcdn.net/jpg/03/14/94/61/360_F_314946196_cXcQOHbKyMqXCiB77tBd4KlOJXaqaMH2.jpg',
    'https://static.vecteezy.com/system/resources/previews/002/965/261/original/close-up-jasmine-flower-in-a-garden-beautiful-jasmine-white-flowers-free-photo.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/91/Yellow_French_Marigold_Flower.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/BougainvilleaGlabra.jpg/330px-BougainvilleaGlabra.jpg',
    'https://m.media-amazon.com/images/I/81p6wodUiuL._AC_UF1000,1000_QL80_.jpg',
    'https://images.pexels.com/photos/36729/tulip-flower-bloom-pink.jpg?cs=srgb&dl=pexels-pixabay-36729.jpg&fm=jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(

          child: ListView.builder(

              itemCount:10,
              itemBuilder: (BuildContext context,index){
                return Card(
                  child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            showDialog(context:context,
                                builder: (context) => AlertDialog(
                                  alignment: Alignment.center,
                                  actions: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('info',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.black
                                          ),),
                                        SizedBox(height: 10,),
                                        TextButton(onPressed:(){

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  passingpage(image: images[index],des:flowers[index])),
                                          );


                                        }, child: Text('Open info',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                              color: Colors.brown
                                          ),))
                                      ],

                                    ),
                                  ],
                                ) ); },
                          title: Text(flowers[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                            ),),
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(images[index]),

                          ),

                        ),
                      )),
                );


              }),
        ),
      ),
    );
  }
}

class gridviewpage extends StatefulWidget {
  const gridviewpage({super.key});

  @override
  State<gridviewpage> createState() => _gridviewpageState();
}

class _gridviewpageState extends State<gridviewpage> {
  var flowers = ["Rose","Lotus","Daisy", "Hibiscus","Dahlia", "Jasmine","Marigold", "Bougainvillea","Sunflower", "Tulip"];
  var images =['https://t3.ftcdn.net/jpg/01/05/57/38/360_F_105573812_cvD4P5jo6tMPhZULX324qUYFbNpXlisD.jpg',
    'https://static.vecteezy.com/system/resources/previews/009/887/145/non_2x/pink-lotus-flower-free-png.png',
    'https://hips.hearstapps.com/hmg-prod/images/daisy-flower-1532449822.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/c/cb/Hibiscus_flower_TZ.jpg',
    'https://t4.ftcdn.net/jpg/03/14/94/61/360_F_314946196_cXcQOHbKyMqXCiB77tBd4KlOJXaqaMH2.jpg',
    'https://static.vecteezy.com/system/resources/previews/002/965/261/original/close-up-jasmine-flower-in-a-garden-beautiful-jasmine-white-flowers-free-photo.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/91/Yellow_French_Marigold_Flower.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/BougainvilleaGlabra.jpg/330px-BougainvilleaGlabra.jpg',
    'https://m.media-amazon.com/images/I/81p6wodUiuL.AC_UF1000,1000_QL80.jpg',
    'https://images.pexels.com/photos/36729/tulip-flower-bloom-pink.jpg?cs=srgb&dl=pexels-pixabay-36729.jpg&fm=jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: flowers.length,
            itemBuilder: (BuildContext context,index){
              return InkWell(
                onTap: () {
                  showDialog(context:context,
                      builder: (context) => AlertDialog(
                        alignment: Alignment.center,
                        actions: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('info',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),),
                              SizedBox(height: 10,),
                              TextButton(onPressed:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  passingpage(image: images[index],des:flowers[index])),
                                );


                              }, child: Text('Open info',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.brown
                                ),))
                            ],

                          ),
                        ],
                      )
                  );

                },
                child: Card(
                  shadowColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),

                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(images[index]),
                        ),
                        SizedBox(height: 10,),
                        Text(flowers[index])
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class passingpage extends StatefulWidget {
  const passingpage({super.key, required this.image, required this.des});
  final String image,des;
  @override
  State<passingpage> createState() => _passingpageState();
}

class _passingpageState extends State<passingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.des,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Container(
            height: 500,
            width: 500,
            child: Image.network(widget.image),

          ),

            SizedBox(height: 20,),
            Text(widget.des,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Colors.black
              ),)
          ],
        ),
      ),
    );
  }
}

