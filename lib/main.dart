import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:project1/contact.dart';
import 'package:project1/TAAAAA.dart';
import 'package:project1/task.dart';
import 'package:project1/fifthpage.dart';
import 'package:project1/fourthpage.dart';
import 'package:project1/secondpage.dart';
import 'package:project1/thirdpage.dart';
import 'package:project1/imagetask.dart';
import 'package:project1/calci.dart';
import 'package:project1/list grid.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:http/http.dart' as apihelper;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home : splashpage());

  }
}

class splashpage extends StatefulWidget {
  const splashpage({super.key});

  @override
  State<splashpage> createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  Future<void> movetonxtpage()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool ? isLoggedin = prefs.getBool('isLoggedin');
    if (isLoggedin==true){
      Future.delayed(Duration(seconds: 2),(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return taskloginpage();
        }));
      });
    }
    else {

      Future.delayed(Duration(seconds: 2),(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return taskloginpage();
        }));
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movetonxtpage();
    ();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: (
            Column(
              children: [
                Container(
                    height: 500,
                    width: 500,
                    child: Image(image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1_JTxLxp1JutRB7aON5ByfOqPsWxW8shI9fz3Poul-RKCoq_0hPu7hux8tReot47LDA&usqp=CAU',)
                    )),

                Text('Initializing.....',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                  ),)
              ],
            )
        ),
      ),
    );
  }
}


class taskloginpage extends StatefulWidget {
  const taskloginpage({super.key});

  @override
  State<taskloginpage> createState() => _taskloginpageState();
}

class _taskloginpageState extends State<taskloginpage> {
  final textformkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  bool emailValid = true;
  bool passValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,

        title: Text('Login With Your Details',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),),
      ),
      body: Form(
        key: textformkey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: ListView(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: Image(image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1_JTxLxp1JutRB7aON5ByfOqPsWxW8shI9fz3Poul-RKCoq_0hPu7hux8tReot47LDA&usqp=CAU',)
                    )),
                SizedBox(height: 20,),
                TextFormField(
                  controller: emailcontroller,
                  validator: (valuea){
                    if(valuea!.isEmpty){
                      return "Please enter your email ";
                    }
                    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(valuea);
                    if (!emailValid){
                      return "Enter Valid Email";
                    }

                  },
                  decoration: InputDecoration(
                      suffix: Icon(Icons.email),

                      hintText: "Enter email ",
                      labelText: "Email",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passcontroller,
                  validator: (valueb){
                    if (valueb!.isEmpty) {
                      return 'Please enter password';
                    }
                    bool passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(valueb);
                    if (!passValid){
                      return "Enter Valid Password";
                    }


                  },
                  decoration: InputDecoration(
                      suffix: Icon(Icons.lock),
                      hintText: "Enter password ",
                      labelText: "Password",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: ElevatedButton(onPressed:(){
                    if (textformkey.currentState!.validate()){
                      return
                        setState(() {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  MainPage()),
                          );

                        });
                    }

                  }, child: Text('Log In',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,

                    ),)),
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pageController = PageController(initialPage: 1);
  int currentSelected = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MyHomePage()),
            );
          }, icon: Icon(Icons.more),
        ),
        title: Text('Upload Here'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('wallpapers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var wallpapersList = List<Wallpaper>.empty(growable: true);

            snapshot.data?.docs.forEach((documentSnapshot) {
              var wallpaper = Wallpaper.fromDocumentSnapshot(documentSnapshot);
              wallpapersList.add(wallpaper);
            });

            return PageView.builder(
              controller: pageController,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return _getPagesAtIndex(index, wallpapersList);
              },
              onPageChanged: (int index) {
                setState(() {
                  currentSelected = index;
                });
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting, // Shifting
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: const TextStyle(
          fontFamily: 'VujahdayScript-Regular'
      ),
      currentIndex: currentSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'All Images',
          backgroundColor: Colors.indigo,),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: 'Upload',
          backgroundColor: Colors.lightGreen,),
      ],
      onTap: (int index) {
        setState(() {
          currentSelected = index;
          pageController.animateToPage(
            currentSelected,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
          );
        });
      },
    );
  }

  Widget _getPagesAtIndex(int index, List<Wallpaper> wallpaperList) {
    switch (index) {
      case 0:
        return Home(
          wallpapersList: wallpaperList,
        );
      case 1:
        return MyHomePage();
      default:
        return const CircularProgressIndicator();
    }
  }
}



class Wallpaper {
  final String url;
  final String desc;
  final String title;
  final String id;

  Wallpaper({
    required this.url,
    required this.desc,
    required this.title,
    required this.id,
  });

  factory Wallpaper.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Wallpaper(
      url: snapshot.get('url'),
      desc: snapshot.get('desc'),
      title: snapshot.get('title'),
      id: snapshot.id,
    );
  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();
  final picker = ImagePicker();
  XFile? _image;
  String? _imageUrl;

  Future<void> _captureImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = pickedFile;
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    if (_image == null) {
      return;
    }

    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');

      final UploadTask uploadTask = storageReference.putFile(File(_image!.path));

      final TaskSnapshot storageTaskSnapshot = await uploadTask;
      final imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });

      print('Image uploaded successfully. URL: $_imageUrl');
      await FirebaseFirestore.instance.collection("wallpapers").add({
        'title': titleController.text,
        'desc': descpController.text,
        'url': _imageUrl
      });
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:

       SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path)),
            TextFormField(
              controller: titleController,
              validator: (value){
                if(value!.isEmpty){
                  return "It is Empty";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: "Title"
              ),
            ),
            TextFormField(
              controller: descpController,
              validator: (value){
                if(value!.isEmpty){
                  return "It is Empty";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: "Description"
              ),
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                  onPressed: 
                     _captureImage,
                  child: Text('Capture Image',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                ),
                IconButton(onPressed:_uploadImageToFirebaseStorage, icon: Icon(Icons.add))
              ],
            ),
           
            _imageUrl != null
                ? Image.network(
              _imageUrl!,
              height: 150.0,
              width: 150.0,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final List<Wallpaper> wallpapersList;

  const Home({Key? key, required this.wallpapersList}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final categories = List<String>.empty(growable: true);
  final categoryImages = List<String>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    widget.wallpapersList.forEach(
          (wallpaper) {
        var category = wallpaper.title;

        if (!categories.contains(category)) {
          categories.add(category);
          categoryImages.add(wallpaper.url);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [Text(categories.elementAt(index)),
             Container(
              width: 200,
              child: Image.network(categoryImages.elementAt(index))
            ),

          ],
        );
      },
    );
  }
}












//youtube
class bottomnavigation extends StatefulWidget {
  const bottomnavigation({super.key});

  @override
  State<bottomnavigation> createState() => _bottomnavigationState();
}

class _bottomnavigationState extends State<bottomnavigation> {
   var selectedindex = 0;
   var imageurl = ['https://duet-cdn.vox-cdn.com/thumbor/0x0:1920x1300/750x500/filters:focal(960x650:961x651):format(webp)/cdn.vox-cdn.com/uploads/chorus_asset/file/24840031/Wacom_One_display_tablet_hed__1_.jpg',
     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2vIfyHL2dojezxcBCRgpmzv6OHcCdJNLia8CfoMelXAOUuaGKmvyuTILnb9LjVuJUIuc&usqp=CAU',
     'https://i0.wp.com/maestramom.com/wp-content/uploads/2022/08/Miracles-with-Water-Jesus.png?fit=1100%2C750&ssl=1',
     'https://i.guim.co.uk/img/media/60c0672510dfdb517bd5a9605e1cb3e1b9843d99/368_732_4865_2919/master/4865.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=09b96bb8c6998dbcc3935c4f5bc3ca7c',
     'https://images.squarespace-cdn.com/content/v1/5e56378584419a233c05f64a/1620629570497-N6Z2QFF4W5HHHJURA8AL/120861780_2767658770147023_3059932414861556508_n.jpg',
     'https://images.news18.com/ibnlive/uploads/2021/03/1616683507_did.jpg?impolicy=website&width=0&height=0',
     'https://akamaividz2.zee5.com/image/upload/w_1170,h_658,c_scale,f_webp,q_auto:eco/resources/0-6-3420/list/1170x658withlogo23d5d25994594e5d9fc760d0158b8631.jpg',
     'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1660772614.jpg?crop=1xw:0.84375xh;center,top&resize=1200:*',
     'https://wpassets.adda247.com/wp-content/uploads/multisite/2023/06/08155830/Current-Affairs-2023.png',
     'https://images.thequint.com/thequint%2F2023-08%2Fbeefdd42-6daa-43bf-a7b8-907e58a574fc%2FPARLIAMENT_MONSOON_SESSION__10_.jpg?auto=format%2Ccompress&fmt=webp&width=720&w=1200'
   ];

   var title = ['Painting Tutorials for Beginners',
     'Online Dance Class For Children',
     'Come Let us Worship the Lord',
     'A Day with me - vlog ',
     'Bonsai Garden',
     'Dance India Dance',
     'Stand up Comedy Show',
     'Frienship Day Mashup | Frienship songs',
     '13 Aug 2023 |The Hindu Editorial',
     'Parliament Monsoon Session 2022'

   ];

   var channelname = ['Art with Sara  .',
     'RVP Dance Studio  .',
     'Stanley  .',
     'Richard vlogger  .',
     'Harry   .',
     'Vijay Television  .',
     'Zee Television  .',
     'Heart Hunter  .',
     'Adda247  .',
     'India Today  .',
   ];

   var views = [' 1M Views  .',
     ' 2M Views  .',
     ' 1M Views  .',
     ' 5M Views  .',
     ' 5K Views  .',
     ' 27K Views  .',
     ' 50K Views  .',
     ' 2K Views  .',
     ' 5.8K Views  .',
     ' 7K Views  .',

   ];

   var days = [' 10 days ago',
     ' 1 week ago',
     ' 5 days ago',
     ' 1 year ago',
     ' 1 month ago',
     ' 3 months ago',
     ' 8 months ago',
     ' 8 days ago',
     ' 1 day ago',
     ' 1 year ago',
   ];

   var avatar =['https://www.moglix.com/blog/wp-content/uploads/2020/10/blog-banner-paints-1.jpg',
     'https://static.vecteezy.com/system/resources/previews/007/853/142/original/elegant-dance-studio-logo-design-free-vector.jpg',
     'https://t4.ftcdn.net/jpg/04/31/04/17/360_F_431041777_zP5k6UXqaZ9uqvF09utRO2B8kMJZRmJG.jpg',
     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1fU98de6vC8kQZWkehA9-Qc08NgX1XZTLjg&usqp=CAU',
     'https://m.media-amazon.com/images/I/61-74Et7cCL._AC_UF1000,1000_QL80_.jpg',
     'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZ8-Z4xZH63h7T7-ivnjCxvBWVudIE-FbR-oq5LSA7auTyBb-D',
     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrWZ-enrMmbFgA6rHfMXhpEifUHkjnmL1tIw&usqp=CAU',
     'https://images.unsplash.com/photo-1522098605161-cc0c1434c31a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fGZyaWVuZHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVYDykPf79p-xKq3oAdgJasuosntSdW8_o6NfZzeoSmlTYfgFK4rhyIL7RDAgZv_HcDvY&usqp=CAU',
     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdu6zyICVR60wspbv3CU0ToUGbRyUAzdmujw&usqp=CAU',

   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white70,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Logo_of_YouTube_%282015-2017%29.svg/2560px-Logo_of_YouTube_%282015-2017%29.svg.png'),
        ),
        leadingWidth: 80,
        actions: [
          IconButton(onPressed:(){}, icon: Icon(Icons.cast,
          color: Colors.black,),
          ),
          SizedBox(width: 2,),
          IconButton(onPressed:(){}, icon: Icon(Icons.notifications_outlined,
              color: Colors.black)),
          SizedBox(width: 2,),
          IconButton(onPressed:(){}, icon: Icon(Icons.search,
              color: Colors.black)),
          SizedBox(width: 3,),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed:(){}, icon: Icon(Icons.account_circle,
                size: 40.0,
                color: Colors.black),
            ),
          )
        ],
      ),
      body:Center(
    child: ListView.builder(
    itemCount: imageurl.length ,
        itemBuilder: (BuildContext context,index) {
          return
            Container(
                child: Column(
                  children: [
                    Container(
                      height: 270,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(offset: Offset(1.0, 1.0))]
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: 200,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: Image.network(imageurl[index],
                                  fit: BoxFit.fill)),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              SizedBox(width: 1,),
                              Container(
                                height: 50,
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(avatar[index])

                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900
                                    ),),
                                  SizedBox(height: 7,),
                                  Row(
                                    children: [
                                      Text(channelname[index],
                                        style: TextStyle(
                                          color: Colors.black, fontSize: 12,),),
                                      Text(views[index], style: TextStyle(
                                        color: Colors.black, fontSize: 12,),),
                                      Text(days[index], style: TextStyle(
                                        color: Colors.black, fontSize: 12,),),

                                    ],
                                  )
                                ],
                              )
                            ],
                          )

                        ],
                      ),
                    )
                  ],


                ));

        } ),
    ),
      bottomNavigationBar:BottomNavigationBar(
         currentIndex: selectedindex ,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.black),

          items: [
            BottomNavigationBarItem(
                icon:InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const homepage()),
                      );

                  },
                  child: Icon(Icons.home_outlined,
                      color: Colors.black),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon:InkWell(
                  onTap: (){},
                  child: Icon(Icons.short_text_sharp,
                      color: Colors.black),
                ),
                label: "Shorts"),
            BottomNavigationBarItem(
                icon:InkWell(
                  onTap: (){},
                  child: Icon(Icons.add_circle_outline,
                      size: 40,
                      color: Colors.black),
                ),
              label: 'Add'  ),
            BottomNavigationBarItem(
                icon:InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const subscriptionspage()),
                    );
                  },
                  child: Icon(Icons.subscriptions_outlined,
                      color: Colors.black),
                ),
                label: "Subscriptions"),
            BottomNavigationBarItem(
                icon:InkWell(
                  onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const librarypage()),
                      );

                  },
                  child: Icon(Icons.video_library_outlined,
                      color: Colors.black),
                ),
                label: "Library"),

          ],
        ),

    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var selectedindex = 0;
  var imageurl = ['https://duet-cdn.vox-cdn.com/thumbor/0x0:1920x1300/750x500/filters:focal(960x650:961x651):format(webp)/cdn.vox-cdn.com/uploads/chorus_asset/file/24840031/Wacom_One_display_tablet_hed__1_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2vIfyHL2dojezxcBCRgpmzv6OHcCdJNLia8CfoMelXAOUuaGKmvyuTILnb9LjVuJUIuc&usqp=CAU',
    'https://i0.wp.com/maestramom.com/wp-content/uploads/2022/08/Miracles-with-Water-Jesus.png?fit=1100%2C750&ssl=1',
    'https://i.guim.co.uk/img/media/60c0672510dfdb517bd5a9605e1cb3e1b9843d99/368_732_4865_2919/master/4865.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=09b96bb8c6998dbcc3935c4f5bc3ca7c',
    'https://images.squarespace-cdn.com/content/v1/5e56378584419a233c05f64a/1620629570497-N6Z2QFF4W5HHHJURA8AL/120861780_2767658770147023_3059932414861556508_n.jpg',
    'https://images.news18.com/ibnlive/uploads/2021/03/1616683507_did.jpg?impolicy=website&width=0&height=0',
    'https://akamaividz2.zee5.com/image/upload/w_1170,h_658,c_scale,f_webp,q_auto:eco/resources/0-6-3420/list/1170x658withlogo23d5d25994594e5d9fc760d0158b8631.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1660772614.jpg?crop=1xw:0.84375xh;center,top&resize=1200:*',
    'https://wpassets.adda247.com/wp-content/uploads/multisite/2023/06/08155830/Current-Affairs-2023.png',
    'https://images.thequint.com/thequint%2F2023-08%2Fbeefdd42-6daa-43bf-a7b8-907e58a574fc%2FPARLIAMENT_MONSOON_SESSION__10_.jpg?auto=format%2Ccompress&fmt=webp&width=720&w=1200'
  ];

  var title = ['Painting Tutorials for Beginners',
  'Online Dance Class For Children',
  'Come Let us Worship the Lord',
      'A Day with me - vlog ',
    'Bonsai Garden',
    'Dance India Dance',
    'Stand up Comedy Show',
   'Frienship Day Mashup | Frienship songs',
    '13 Aug 2023 |The Hindu Editorial',
    'Parliament Monsoon Session 2022'

  ];

  var channelname = ['Art with Sara  .',
  'RVP Dance Studio  .',
  'Stanley  .',
  'Richard vlogger  .',
      'Harry   .',
'Vijay Television  .',
    'Zee Television  .',
    'Heart Hunter  .',
    'Adda247  .',
    'India Today  .',
      ];

  var views = [' 1M Views  .',
  ' 2M Views  .',
    ' 1M Views  .',
    ' 5M Views  .',
    ' 5K Views  .',
    ' 27K Views  .',
    ' 50K Views  .',
    ' 2K Views  .',
    ' 5.8K Views  .',
    ' 7K Views  .',

  ];

  var days = [' 10 days ago',
  ' 1 week ago',
  ' 5 days ago',
  ' 1 year ago',
    ' 1 month ago',
    ' 3 months ago',
    ' 8 months ago',
    ' 8 days ago',
    ' 1 day ago',
    ' 1 year ago',
  ];

  var avatar =['https://www.moglix.com/blog/wp-content/uploads/2020/10/blog-banner-paints-1.jpg',
      'https://static.vecteezy.com/system/resources/previews/007/853/142/original/elegant-dance-studio-logo-design-free-vector.jpg',
      'https://t4.ftcdn.net/jpg/04/31/04/17/360_F_431041777_zP5k6UXqaZ9uqvF09utRO2B8kMJZRmJG.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1fU98de6vC8kQZWkehA9-Qc08NgX1XZTLjg&usqp=CAU',
    'https://m.media-amazon.com/images/I/61-74Et7cCL._AC_UF1000,1000_QL80_.jpg',
    'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZ8-Z4xZH63h7T7-ivnjCxvBWVudIE-FbR-oq5LSA7auTyBb-D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrWZ-enrMmbFgA6rHfMXhpEifUHkjnmL1tIw&usqp=CAU',
    'https://images.unsplash.com/photo-1522098605161-cc0c1434c31a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fGZyaWVuZHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVYDykPf79p-xKq3oAdgJasuosntSdW8_o6NfZzeoSmlTYfgFK4rhyIL7RDAgZv_HcDvY&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdu6zyICVR60wspbv3CU0ToUGbRyUAzdmujw&usqp=CAU',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white70,
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Logo_of_YouTube_%282015-2017%29.svg/2560px-Logo_of_YouTube_%282015-2017%29.svg.png'),
          ),
          leadingWidth: 80,
          actions: [
            IconButton(onPressed:(){}, icon: Icon(Icons.cast,
              color: Colors.black,),
            ),
            SizedBox(width: 2,),
            IconButton(onPressed:(){}, icon: Icon(Icons.notifications_outlined,
                color: Colors.black)),
            SizedBox(width: 2,),
            IconButton(onPressed:(){}, icon: Icon(Icons.search,
                color: Colors.black)),
            SizedBox(width: 3,),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed:(){}, icon: Icon(Icons.account_circle,
                  size: 40.0,
                  color: Colors.black),
              ),
            )
          ],
        ),
      body: Center(
        child: ListView.builder(
          itemCount: imageurl.length ,
            itemBuilder: (BuildContext context,index) {
          return
          Container(
              child: Column(
                children: [
                  Container(
                    height: 270,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(offset: Offset(1.0, 1.0))]
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 200,
                            width: MediaQuery
                                .of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: Image.network(imageurl[index],
                                fit: BoxFit.fill)),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(width: 1,),
                            Container(
                              height: 50,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(avatar[index])

                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900
                                  ),),
                                SizedBox(height: 7,),
                                Row(
                                  children: [
                                    Text(channelname[index],
                                      style: TextStyle(
                                        color: Colors.black, fontSize: 12,),),
                                    Text(views[index], style: TextStyle(
                                      color: Colors.black, fontSize: 12,),),
                                    Text(days[index], style: TextStyle(
                                      color: Colors.black, fontSize: 12,),),

                                  ],
                                )
                              ],
                            )
                          ],
                        )

                      ],
                    ),
                  )
                ],


              ));

        } ),
      ) ,
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: selectedindex ,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),

        items: [
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const homepage()),
                  );

                },
                child: Icon(Icons.home_outlined,
                    color: Colors.black),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){},
                child: Icon(Icons.short_text_sharp,
                    color: Colors.black),
              ),
              label: "Shorts"),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){},
                child: Icon(Icons.add_circle_outline,
                    size: 40,
                    color: Colors.black),
              ),
              label: 'Add'  ),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const subscriptionspage()),
                  );
                },
                child: Icon(Icons.subscriptions_outlined,
                    color: Colors.black),
              ),
              label: "Subscriptions"),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const librarypage()),
                  );

                },
                child: Icon(Icons.video_library_outlined,
                    color: Colors.black),
              ),
              label: "Library"),

        ],
      ),
    );
  }
}

class librarypage extends StatefulWidget {
  const librarypage({super.key});

  @override
  State<librarypage> createState() => _librarypageState();
}

class _librarypageState extends State<librarypage> {
  var selectedindex = 0;
  var imageurl = ['https://duet-cdn.vox-cdn.com/thumbor/0x0:1920x1300/750x500/filters:focal(960x650:961x651):format(webp)/cdn.vox-cdn.com/uploads/chorus_asset/file/24840031/Wacom_One_display_tablet_hed__1_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2vIfyHL2dojezxcBCRgpmzv6OHcCdJNLia8CfoMelXAOUuaGKmvyuTILnb9LjVuJUIuc&usqp=CAU',
    'https://i0.wp.com/maestramom.com/wp-content/uploads/2022/08/Miracles-with-Water-Jesus.png?fit=1100%2C750&ssl=1',
    'https://i.guim.co.uk/img/media/60c0672510dfdb517bd5a9605e1cb3e1b9843d99/368_732_4865_2919/master/4865.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=09b96bb8c6998dbcc3935c4f5bc3ca7c',
    'https://images.squarespace-cdn.com/content/v1/5e56378584419a233c05f64a/1620629570497-N6Z2QFF4W5HHHJURA8AL/120861780_2767658770147023_3059932414861556508_n.jpg',
    'https://images.news18.com/ibnlive/uploads/2021/03/1616683507_did.jpg?impolicy=website&width=0&height=0',
    'https://akamaividz2.zee5.com/image/upload/w_1170,h_658,c_scale,f_webp,q_auto:eco/resources/0-6-3420/list/1170x658withlogo23d5d25994594e5d9fc760d0158b8631.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1660772614.jpg?crop=1xw:0.84375xh;center,top&resize=1200:*',
    'https://wpassets.adda247.com/wp-content/uploads/multisite/2023/06/08155830/Current-Affairs-2023.png',
    'https://images.thequint.com/thequint%2F2023-08%2Fbeefdd42-6daa-43bf-a7b8-907e58a574fc%2FPARLIAMENT_MONSOON_SESSION__10_.jpg?auto=format%2Ccompress&fmt=webp&width=720&w=1200'
  ];

  var title = ['Painting Tutorials for Beginners',
    'Online Dance Class For Children',
    'Come Let us Worship the Lord',
    'A Day with me - vlog ',
    'Bonsai Garden',
    'Dance India Dance',
    'Stand up Comedy Show',
    'Frienship Day Mashup | Frienship songs',
    '13 Aug 2023 |The Hindu Editorial',
    'Parliament Monsoon Session 2022'

  ];

  var channelname = ['Art with Sara  .',
    'RVP Dance Studio  .',
    'Stanley  .',
    'Richard vlogger  .',
    'Harry   .',
    'Vijay Television  .',
    'Zee Television  .',
    'Heart Hunter  .',
    'Adda247  .',
    'India Today  .',
  ];

  var views = [' 1M Views  .',
    ' 2M Views  .',
    ' 1M Views  .',
    ' 5M Views  .',
    ' 5K Views  .',
    ' 27K Views  .',
    ' 50K Views  .',
    ' 2K Views  .',
    ' 5.8K Views  .',
    ' 7K Views  .',

  ];

  var days = [' 10 days ago',
    ' 1 week ago',
    ' 5 days ago',
    ' 1 year ago',
    ' 1 month ago',
    ' 3 months ago',
    ' 8 months ago',
    ' 8 days ago',
    ' 1 day ago',
    ' 1 year ago',
  ];

  var avatar =['https://www.moglix.com/blog/wp-content/uploads/2020/10/blog-banner-paints-1.jpg',
    'https://static.vecteezy.com/system/resources/previews/007/853/142/original/elegant-dance-studio-logo-design-free-vector.jpg',
    'https://t4.ftcdn.net/jpg/04/31/04/17/360_F_431041777_zP5k6UXqaZ9uqvF09utRO2B8kMJZRmJG.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1fU98de6vC8kQZWkehA9-Qc08NgX1XZTLjg&usqp=CAU',
    'https://m.media-amazon.com/images/I/61-74Et7cCL._AC_UF1000,1000_QL80_.jpg',
    'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZ8-Z4xZH63h7T7-ivnjCxvBWVudIE-FbR-oq5LSA7auTyBb-D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrWZ-enrMmbFgA6rHfMXhpEifUHkjnmL1tIw&usqp=CAU',
    'https://images.unsplash.com/photo-1522098605161-cc0c1434c31a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fGZyaWVuZHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVYDykPf79p-xKq3oAdgJasuosntSdW8_o6NfZzeoSmlTYfgFK4rhyIL7RDAgZv_HcDvY&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdu6zyICVR60wspbv3CU0ToUGbRyUAzdmujw&usqp=CAU',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white70,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Logo_of_YouTube_%282015-2017%29.svg/2560px-Logo_of_YouTube_%282015-2017%29.svg.png'),
        ),
        leadingWidth: 80,
        actions: [
          IconButton(onPressed:(){}, icon: Icon(Icons.cast,
            color: Colors.black,),
          ),
          SizedBox(width: 2,),
          IconButton(onPressed:(){}, icon: Icon(Icons.notifications_outlined,
              color: Colors.black)),
          SizedBox(width: 2,),
          IconButton(onPressed:(){}, icon: Icon(Icons.search,
              color: Colors.black)),
          SizedBox(width: 3,),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed:(){}, icon: Icon(Icons.account_circle,
                size: 40.0,
                color: Colors.black),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Recent',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://duet-cdn.vox-cdn.com/thumbor/0x0:1920x1300/750x500/filters:focal(960x650:961x651):format(webp)/cdn.vox-cdn.com/uploads/chorus_asset/file/24840031/Wacom_One_display_tablet_hed__1_.jpg', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Painting Tutorial for beginners',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 15,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2vIfyHL2dojezxcBCRgpmzv6OHcCdJNLia8CfoMelXAOUuaGKmvyuTILnb9LjVuJUIuc&usqp=CAU', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Online Dance Class for Children',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 8,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://i0.wp.com/maestramom.com/wp-content/uploads/2022/08/Miracles-with-Water-Jesus.png?fit=1100%2C750&ssl=1', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Come Let us Worship the Lord',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 13,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://i.guim.co.uk/img/media/60c0672510dfdb517bd5a9605e1cb3e1b9843d99/368_732_4865_2919/master/4865.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=09b96bb8c6998dbcc3935c4f5bc3ca7c', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('A Day with me - vlog',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 70,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://images.squarespace-cdn.com/content/v1/5e56378584419a233c05f64a/1620629570497-N6Z2QFF4W5HHHJURA8AL/120861780_2767658770147023_3059932414861556508_n.jpg', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Bonsai Garden',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 110,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://images.news18.com/ibnlive/uploads/2021/03/1616683507_did.jpg?impolicy=website&width=0&height=0', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Dance India Dance',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 80,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://akamaividz2.zee5.com/image/upload/w_1170,h_658,c_scale,f_webp,q_auto:eco/resources/0-6-3420/list/1170x658withlogo23d5d25994594e5d9fc760d0158b8631.jpg', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Stand up comedy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 85,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://hips.hearstapps.com/hmg-prod/images/gettyimages-1660772614.jpg?crop=1xw:0.84375xh;center,top&resize=1200:*', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Friendship day Mashup',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 60,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://wpassets.adda247.com/wp-content/uploads/multisite/2023/06/08155830/Current-Affairs-2023.png', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('13Aug-Hindu Editorial',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 65,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 150,
                        width: 230,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 230,
                              child: Image.network('https://images.thequint.com/thequint%2F2023-08%2Fbeefdd42-6daa-43bf-a7b8-907e58a574fc%2FPARLIAMENT_MONSOON_SESSION__10_.jpg?auto=format%2Ccompress&fmt=webp&width=720&w=1200', fit: BoxFit.cover,),
                            ),
                            Row(
                              children: [
                                Text('Parliament Monsoon Session',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),),
                                SizedBox(width: 5,),
                                Icon(Icons.more_vert)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          )  ,
        Divider(height: 1,),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(width: 0.1)
            ),
            child:SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('History',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                        ),
                    leading: Icon(Icons.history,size: 30,color: Colors.black54,),
                  ),
                  ListTile(
                    title: Text('My Videos',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    leading: Icon(Icons.video_collection_sharp,size: 30,color: Colors.black54,),
                  ),
                  ListTile(
                    title: Text('Watch Later',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    leading: Icon(Icons.access_time_outlined,size: 30,color: Colors.black54,),
                  ),
                  ListTile(
                    title: Text('Downloads',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    leading: Icon(Icons.arrow_downward,size: 30,color: Colors.black54,),
                  ),
                  ListTile(
                    title: Text('Your Movies',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    leading: Icon(Icons.local_movies_outlined,size: 30,color: Colors.black54,),
                  ),

                ],
              ),
            ),
          ),
          Divider(height: 1,),
        ] ),
      bottomNavigationBar:BottomNavigationBar(
      currentIndex: selectedindex ,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(color: Colors.black),
      unselectedLabelStyle: TextStyle(color: Colors.black),

      items: [
        BottomNavigationBarItem(
            icon:InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const homepage()),
                );

              },
              child: Icon(Icons.home_outlined,
                  color: Colors.black),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon:InkWell(
              onTap: (){},
              child: Icon(Icons.short_text_sharp,
                  color: Colors.black),
            ),
            label: "Shorts"),
        BottomNavigationBarItem(
            icon:InkWell(
              onTap: (){},
              child: Icon(Icons.add_circle_outline,
                  size: 40,
                  color: Colors.black),
            ),
            label: 'Add'  ),
        BottomNavigationBarItem(
            icon:InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const subscriptionspage()),
                );
              },
              child: Icon(Icons.subscriptions_outlined,
                  color: Colors.black),
            ),
            label: "Subscriptions"),
        BottomNavigationBarItem(
            icon:InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const librarypage()),
                );

              },
              child: Icon(Icons.video_library_outlined,
                  color: Colors.black),
            ),
            label: "Library"),

      ],
    ),
    );
  }
}

class subscriptionspage extends StatefulWidget {
  const subscriptionspage({super.key});

  @override
  State<subscriptionspage> createState() => _subscriptionspageState();
}

class _subscriptionspageState extends State<subscriptionspage> {
  var selectedindex = 0;
  var imageurl = ['https://duet-cdn.vox-cdn.com/thumbor/0x0:1920x1300/750x500/filters:focal(960x650:961x651):format(webp)/cdn.vox-cdn.com/uploads/chorus_asset/file/24840031/Wacom_One_display_tablet_hed__1_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2vIfyHL2dojezxcBCRgpmzv6OHcCdJNLia8CfoMelXAOUuaGKmvyuTILnb9LjVuJUIuc&usqp=CAU',
    'https://i0.wp.com/maestramom.com/wp-content/uploads/2022/08/Miracles-with-Water-Jesus.png?fit=1100%2C750&ssl=1',
    'https://i.guim.co.uk/img/media/60c0672510dfdb517bd5a9605e1cb3e1b9843d99/368_732_4865_2919/master/4865.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=09b96bb8c6998dbcc3935c4f5bc3ca7c',
    'https://images.squarespace-cdn.com/content/v1/5e56378584419a233c05f64a/1620629570497-N6Z2QFF4W5HHHJURA8AL/120861780_2767658770147023_3059932414861556508_n.jpg',
    'https://images.news18.com/ibnlive/uploads/2021/03/1616683507_did.jpg?impolicy=website&width=0&height=0',
    'https://akamaividz2.zee5.com/image/upload/w_1170,h_658,c_scale,f_webp,q_auto:eco/resources/0-6-3420/list/1170x658withlogo23d5d25994594e5d9fc760d0158b8631.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/gettyimages-1660772614.jpg?crop=1xw:0.84375xh;center,top&resize=1200:*',
    'https://wpassets.adda247.com/wp-content/uploads/multisite/2023/06/08155830/Current-Affairs-2023.png',
    'https://images.thequint.com/thequint%2F2023-08%2Fbeefdd42-6daa-43bf-a7b8-907e58a574fc%2FPARLIAMENT_MONSOON_SESSION__10_.jpg?auto=format%2Ccompress&fmt=webp&width=720&w=1200'
  ];

  var title = ['Painting Tutorials for Beginners',
    'Online Dance Class For Children',
    'Come Let us Worship the Lord',
    'A Day with me - vlog ',
    'Bonsai Garden',
    'Dance India Dance',
    'Stand up Comedy Show',
    'Frienship Day Mashup | Frienship songs',
    '13 Aug 2023 |The Hindu Editorial',
    'Parliament Monsoon Session 2022'

  ];

  var channelname = ['Art with Sara  .',
    'RVP Dance Studio  .',
    'Stanley  .',
    'Richard vlogger  .',
    'Harry   .',
    'Vijay Television  .',
    'Zee Television  .',
    'Heart Hunter  .',
    'Adda247  .',
    'India Today  .',
  ];

  var views = [' 1M Views  .',
    ' 2M Views  .',
    ' 1M Views  .',
    ' 5M Views  .',
    ' 5K Views  .',
    ' 27K Views  .',
    ' 50K Views  .',
    ' 2K Views  .',
    ' 5.8K Views  .',
    ' 7K Views  .',

  ];

  var days = [' 10 days ago',
    ' 1 week ago',
    ' 5 days ago',
    ' 1 year ago',
    ' 1 month ago',
    ' 3 months ago',
    ' 8 months ago',
    ' 8 days ago',
    ' 1 day ago',
    ' 1 year ago',
  ];

  var avatar =['https://www.moglix.com/blog/wp-content/uploads/2020/10/blog-banner-paints-1.jpg',
    'https://static.vecteezy.com/system/resources/previews/007/853/142/original/elegant-dance-studio-logo-design-free-vector.jpg',
    'https://t4.ftcdn.net/jpg/04/31/04/17/360_F_431041777_zP5k6UXqaZ9uqvF09utRO2B8kMJZRmJG.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1fU98de6vC8kQZWkehA9-Qc08NgX1XZTLjg&usqp=CAU',
    'https://m.media-amazon.com/images/I/61-74Et7cCL._AC_UF1000,1000_QL80_.jpg',
    'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZ8-Z4xZH63h7T7-ivnjCxvBWVudIE-FbR-oq5LSA7auTyBb-D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrWZ-enrMmbFgA6rHfMXhpEifUHkjnmL1tIw&usqp=CAU',
    'https://images.unsplash.com/photo-1522098605161-cc0c1434c31a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fGZyaWVuZHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVYDykPf79p-xKq3oAdgJasuosntSdW8_o6NfZzeoSmlTYfgFK4rhyIL7RDAgZv_HcDvY&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdu6zyICVR60wspbv3CU0ToUGbRyUAzdmujw&usqp=CAU',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white70,
        leading: Padding(
        padding: EdgeInsets.only(left: 10),
    child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Logo_of_YouTube_%282015-2017%29.svg/2560px-Logo_of_YouTube_%282015-2017%29.svg.png'),
    ),
    leadingWidth: 80,
    actions: [
    IconButton(onPressed:(){}, icon: Icon(Icons.cast,
    color: Colors.black,),
    ),
    SizedBox(width: 2,),
    IconButton(onPressed:(){}, icon: Icon(Icons.notifications_outlined,
    color: Colors.black)),
    SizedBox(width: 2,),
    IconButton(onPressed:(){}, icon: Icon(Icons.search,
    color: Colors.black)),
    SizedBox(width: 3,),
    Padding(
    padding: const EdgeInsets.only(right: 10),
    child: IconButton(onPressed:(){}, icon: Icon(Icons.account_circle,
    size: 40.0,
    color: Colors.black),
    ),
    )
    ],
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [Container(
            height: 40,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('All Subscriptions',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
            SizedBox(height: 20,),
            ListTile(
              title: Text('Art with Sara'),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('https://www.moglix.com/blog/wp-content/uploads/2020/10/blog-banner-paints-1.jpg')),
              ),
            Divider(height: 1,),
            ListTile(
              title: Text('RVP Dance Studio'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/007/853/142/original/elegant-dance-studio-logo-design-free-vector.jpg')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('Stanley'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/04/31/04/17/360_F_431041777_zP5k6UXqaZ9uqvF09utRO2B8kMJZRmJG.jpg')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('Richard vlogger'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1fU98de6vC8kQZWkehA9-Qc08NgX1XZTLjg&usqp=CAU')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('Harry'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://m.media-amazon.com/images/I/61-74Et7cCL._AC_UF1000,1000_QL80_.jpg')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('Vijay Television'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZ8-Z4xZH63h7T7-ivnjCxvBWVudIE-FbR-oq5LSA7auTyBb-D')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('Zee Television'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrWZ-enrMmbFgA6rHfMXhpEifUHkjnmL1tIw&usqp=CAU')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('Heart Hunter'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1522098605161-cc0c1434c31a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fGZyaWVuZHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('Adda247'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVYDykPf79p-xKq3oAdgJasuosntSdW8_o6NfZzeoSmlTYfgFK4rhyIL7RDAgZv_HcDvY&usqp=CAU')),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text('India Today'),
              leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdu6zyICVR60wspbv3CU0ToUGbRyUAzdmujw&usqp=CAU')),
            ),
            Divider(height: 1,),

          ],
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: selectedindex ,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),

        items: [
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const homepage()),
                  );

                },
                child: Icon(Icons.home_outlined,
                    color: Colors.black),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){},
                child: Icon(Icons.short_text_sharp,
                    color: Colors.black),
              ),
              label: "Shorts"),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){},
                child: Icon(Icons.add_circle_outline,
                    size: 40,
                    color: Colors.black),
              ),
              label: 'Add'  ),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const subscriptionspage()),
                  );
                },
                child: Icon(Icons.subscriptions_outlined,
                    color: Colors.black),
              ),
              label: "Subscriptions"),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const librarypage()),
                  );

                },
                child: Icon(Icons.video_library_outlined,
                    color: Colors.black),
              ),
              label: "Library"),

        ],
      ),
    );
  }
}

//youtube




class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: AppBar(

          actions: [
            Icon(Icons.share),
            SizedBox(width: 20,),
            Icon(Icons.message),
            SizedBox(width: 20,),
            Icon(Icons.star),
            SizedBox(width: 20,),
          ],

          title: Text('Task'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Task 1",),
              Tab(text: "Task 2",),
              Tab(text: "Task 3",),
              Tab(text: "Task 4",),
              Tab(text: "Task 5",),
              Tab(text: "Task 6",),
              Tab(text: "Task 7",),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            secondpage(),
            thirdpage(),
            fourthpage(),
            fifthpage(),
            image(),
            calci(),
            listgrid()

         ],
        ),




    ),
    );
  }
}// tabbar task1234

/*class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer'),
      ),
      drawer: Drawer(
        elevation: 50,
        child: ListView(
          children: [UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.greenAccent
            ),
              accountName:Text('Jenisha Angel'),
              accountEmail: Text('angel@gmail.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('JA'),
          ),
          otherAccountsPictures: [
            CircleAvatar(backgroundColor: Colors.white,

            ),
            CircleAvatar(backgroundColor: Colors.white,),
            CircleAvatar(backgroundColor: Colors.white,)
          ],)
            ,
            ListTile(
              title: Text('Settings'),
              subtitle: Text('Go to settings'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_back),
            ),
            ListTile(
              title: Text('Notification'),
              subtitle: Text('Go to notification'),
              leading: Icon(Icons.notifications),
              trailing: Icon(Icons.arrow_back),
            ),
            ListTile(
              title: Text('Menu'),
              subtitle: Text('Go to menu'),
              leading: Icon(Icons.menu),
              trailing: Icon(Icons.arrow_back),
            ),
            ListTile(
              title: Text('Dataset'),
              subtitle: Text('Go to dataset'),
              leading: Icon(Icons.dataset),
              trailing: Icon(Icons.arrow_back),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical),
                ExpansionTile(title: Text('Expand')),
              ListTile(
                title: Text('Settings'),
                subtitle: Text('Go to settings'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_back),
              ),
              ListTile(
                title: Text('Notification'),
                subtitle: Text('Go to notification'),
                leading: Icon(Icons.notifications),
                trailing: Icon(Icons.arrow_back),
              ),
              ListTile(
                title: Text('Menu'),
                subtitle: Text('Go to menu'),
                leading: Icon(Icons.menu),
                trailing: Icon(Icons.arrow_back),
              ),
              ListTile(
                title: Text('Dataset'),
                subtitle: Text('Go to dataset'),
                leading: Icon(Icons.dataset),
                trailing: Icon(Icons.arrow_back),
              ),
            ListTile(
              title: Text('Settings'),
              subtitle: Text('Go to settings'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_back),
            ),
            ListTile(
              title: Text('Notification'),
              subtitle: Text('Go to notification'),
              leading: Icon(Icons.notifications),
              trailing: Icon(Icons.arrow_back),
            ),
            ListTile(
              title: Text('Menu'),
              subtitle: Text('Go to menu'),
              leading: Icon(Icons.menu),
              trailing: Icon(Icons.arrow_back),
            ),
            ListTile(
              title: Text('Dataset'),
              subtitle: Text('Go to dataset'),
              leading: Icon(Icons.dataset),
              trailing: Icon(Icons.arrow_back),
            ),
    ],
        ),



      ),
    );
  }
}*/ //drawer

/*class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  var contactName = ["ygfywe","uhugre","yghdyfyw","hewufhyue"];
  var contactNumber = ["366242","78486","79878","78654"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          setState(() {
            contactName.add("hdyegfyg");
            contactNumber.add("47475");
          });
        },
        icon: Icon(Icons.add),
        ),

      ),
      body: Center(
        child: ListView.builder(
          itemCount: contactNumber.length,
            itemBuilder:( BuildContext context,index) {

              return ListTile(
                leading: Icon(Icons.person),
                title: Text(contactName[index]),
                subtitle: Text(contactNumber[index]),
              );
            }, ),
          ), );
  }
}*/ //listview

/*class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {

List< Contact > contacts= List.empty(growable: true);

  TextEditingController nameController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();

 @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Contact list'),
     ),
      body: Center(
        child:Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Contact name'
              ),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Contact number'
              ),
              controller: contactController,
            ),

            TextButton(onPressed: (){
              setState(() {
                String name = nameController.text;
                String contact= contactController.text;
                if (name.isNotEmpty && contact.isNotEmpty){
                  setState(() {
                    contacts.add(Contact(name:name,contact:contact));
                  });
                }

              });
            },
                child: Text('Add contact')),
            TextButton(onPressed: (){
              setState(() {


              });


            }, child: Text('Remove contact')),
            TextButton(onPressed: (){
              setState(() {
                nameController.text = "";
                contactController.text = "";
              });
            }, child: Text('Clear')),
            Expanded(child:ListView.builder(

                itemCount: contacts.length,
                itemBuilder: (BuildContext context,index){
                  return ListTile(
                    title: Text(contacts[index].name),
                    subtitle: Text(contacts[index].contact),
                    leading: Icon(Icons.person),
                  );
                })),

    ]) )
            );

}
}*/ //listviewtask

/*class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  var  isVisible = true;
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
}*///image

/*class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {


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
    'https://m.media-amazon.com/images/I/81p6wodUiuL._AC_UF1000,1000_QL80_.jpg',
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

*/// listview gridview task

/*class bottomnavigation extends StatefulWidget {
  const bottomnavigation({super.key});

  @override
  State<bottomnavigation> createState() => _bottomnavigationState();
}

class _bottomnavigationState extends State<bottomnavigation> {
  var selectedindex = 0;
  var widgetlist = [
    Center(child: Text('Home')),
    Center(child: Text('Settings')),
    Center(child: Text('Notifications')),
    Center(child: Text('More'))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation'),
      ),
      body: widgetlist[selectedindex],

      bottomNavigationBar: BottomNavigationBar

        (items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
            icon:Icon(Icons.home),
        label: "Home"),
        BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon:Icon(Icons.settings),
            label: "Settings"),
        BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon:Icon(Icons.notifications),
            label: "Notifications"),
        BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon:Icon(Icons.more),
            label: "More"),
      ],
      currentIndex: selectedindex,
      showSelectedLabels: true,
        onTap: (index){
          setState(() {
            selectedindex = index;
          });
        },
      ),
    );
  }
}*/ //btmnavi

/*class calci extends StatefulWidget {
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
}*/ //calci

/*class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  TextEditingController firsttextfield = new TextEditingController();
  TextEditingController secondtextfield = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: firsttextfield ,
            ),
            TextField(
              controller: secondtextfield,
            ),
            TextButton(onPressed:(){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  initialpage(text:firsttextfield.text ,)),
                );
                }, child: Text('Move to initial page')),
            TextButton(onPressed :(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  initialpage(text:secondtextfield.text,)),
              );
              }, child: Text('Move to last page'))
          ],
        ),
      ),
    );
  }
}


class initialpage extends StatefulWidget {
  const initialpage({super.key,required this.text});
final  text;
  @override
  State<initialpage> createState() => _initialpageState();
}

class _initialpageState extends State<initialpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Text(widget.text),
      ),
    );
  }
}*/ //navigation

/*class textformpage extends StatefulWidget {
  const textformpage({super.key});

  @override
  State<textformpage> createState() => _textformpageState();
}

class _textformpageState extends State<textformpage> {
 final textformkey = GlobalKey<FormState>();
 TextEditingController fname = new TextEditingController();
 TextEditingController lname = new TextEditingController();
 TextEditingController mob = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Form'),
      ),
      body: Form(
        key: textformkey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: fname,
                validator: (fname){
                  if (fname!.isEmpty){
                    return "Please enter valid name";
                  }
                  },
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  labelText: 'First name',
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: lname,
                validator: (lname){
                  if (lname!.isEmpty){
                    return "Please enter valid name";
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter your last name',
                    labelText: 'Last name',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: mob,
                validator: (mob){
                  if (mob!.isEmpty){
                    return "Please enter valid mobile number";
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter your mobile number',
                    labelText: 'Mobile number',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              if (textformkey.currentState!.validate()) {
               return
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  textformscreen(firstname: fname.text,lastname: lname.text,mobilenumber: mob.text,)));
              });

              }
            }, child: Text('Submit'),
            )
          ],
        ),
      ),
    );

  }
}

class textformscreen extends StatefulWidget {
  const textformscreen({super.key,required this.firstname,required this.lastname,required this.mobilenumber});
final String firstname,lastname,mobilenumber;


  @override
  State<textformscreen> createState() => _textformscreenState();
}

class _textformscreenState extends State<textformscreen> {



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(widget.firstname,
           style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w300,
             color: Colors.black
           ),),
           SizedBox(height: 10,),
           Text(widget.lastname,
             style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w300,
                 color: Colors.black
             ), ),
           SizedBox(height: 10,),
           Text(widget.mobilenumber,
             style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w300,
                 color: Colors.black
             ),)


         ],
       ),
     ),
    );
  }
}*/ //textform navigation

/*class formpage extends StatefulWidget {
  const formpage({super.key});

  @override
  State<formpage> createState() => _formpageState();
}

class _formpageState extends State<formpage> {
  final textformkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  bool emailValid = true;
  bool passValid = true;
  Future getUserCredentials() async{
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('action');
    if(action !=null){
      return Navigator.push(context, MaterialPageRoute(builder: (context){
        return textformscreen(email: emailcontroller.text, password: passcontroller.text);
      }));
    }
  }
  @override
  void initState() {
    getUserCredentials();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text('Form Page',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),),
      ),
      body: Form(
        key: textformkey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: ListView(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: emailcontroller,
                  validator: (valuea){
                    if(valuea!.isEmpty){
                      return "Please enter your email ";
                    }
                    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(valuea);
                    if (!emailValid){
                      return "Enter Valid Email";
                    }

          },
                  decoration: InputDecoration(
                    suffix: Icon(Icons.email),

                    hintText: "Enter email ",
                    labelText: "Email",
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passcontroller,
                  validator: (valueb){
                    if (valueb!.isEmpty) {
                      return 'Please enter password';
                    }
                bool passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(valueb);
                if (!passValid){
                  return "Enter Valid Password";
                }


    },
                  decoration: InputDecoration(
                    suffix: Icon(Icons.lock),
                      hintText: "Enter password ",
                      labelText: "Password",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: ElevatedButton(onPressed:(){
                    if (textformkey.currentState!.validate()){
                     return
                         setState(() {

                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  textformscreen(email: emailcontroller.text, password:passcontroller.text)),
                             );

                         });
                    }

                    }, child: Text('Log In',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,

                  ),)),
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}

class textformscreen extends StatefulWidget {
  const textformscreen({super.key,required this.email,required this.password});
final String email,password;
  @override
  State<textformscreen> createState() => _textformscreenState();
}

class _textformscreenState extends State<textformscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: TextButton(onPressed: () async{
      final prefs = await SharedPreferences.getInstance();
      final success= await prefs.remove('action');
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return formpage();
      }));
    },

      child: Text('Logout'),
      ),
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text(widget.email,
      style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),),
    SizedBox(height: 10,),
    Text(widget.password,
    style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: Colors.black
     ))])));
  }
} *///textform email pw task


/*class apipage extends StatefulWidget {
  const apipage({super.key});

  @override
  State<apipage> createState() => _apipageState();
}

class _apipageState extends State<apipage> {
  Future<Map> getapidata () async{

    var urlString = "https://kuwycredit.in/servlet/rest/ltv/forecast/ltvMakes";
    var url = Uri.parse(urlString);
    var body = {"year":"2020"};
    var jsonbody = jsonEncode(body);
    var header = { "Content-Type":"application/json"};
    var response = await apihelper.post(url,body:jsonbody,headers: header );

    Map data = jsonDecode(response.body);
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
       child: FutureBuilder(
         future: getapidata(),
         builder: (BuildContext context , AsyncSnapshot snapshot) {
           if (snapshot.hasData) {
             Map data = snapshot.data;
             List totaldata = data['makeList'];
             return ListView.builder(

                 itemCount: totaldata.length,
                 itemBuilder: (BuildContext context, index) {
                   return ListTile(
                     title: Text(totaldata[index]),
                   );
                 }

             );
           }
           else {
             return CircularProgressIndicator();
           }
         } ),
      ),
    );
  }
}*/ //api get method






class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return welcomepage();
            }));
          },child: Text('Login'),
        ),
      ),
    );
  }
}



class welcomepage extends StatefulWidget {

  const welcomepage({super.key});

  @override
  State<welcomepage> createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
  Future<void> setloginvalue()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedin', true);
  }
  @override
  void initState() {
    // TODO: implement initState
    setloginvalue();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcomepage'),
      ),
      body: Center(
        child: TextButton(onPressed: ()async{
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('isLoogedin');
        },
        child: Text('Logout'),),
      ),
    );
  }
} //shared preference

class geolocater extends StatefulWidget {
  const geolocater({super.key});

  @override
  State<geolocater> createState() => _geolocaterState();
}

class _geolocaterState extends State<geolocater> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled ==false) {
      Geolocator.openAppSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    print(position.longitude);

    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocater'),
      ),
      body: Center(
        child: TextButton(
          onPressed: (){
            _determinePosition();
          },child: Text('Tapme'),
        ),
      ),
    );
  }
} //geolocater









//TASK

class iconpage extends StatefulWidget {
  const iconpage({super.key});

  @override
  State<iconpage> createState() => _iconpageState();
}

class _iconpageState extends State<iconpage> {
  Future<void> movetonxtpage()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool ? isLoggedin = prefs.getBool('isLoggedin');
    if (isLoggedin==true){
      Future.delayed(Duration(seconds: 2),(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return apipage();
        }));
      });
    }
    else {
      Future.delayed(Duration(seconds: 2),(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return formpage();
        }));
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movetonxtpage();
    ();
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (
        Column(
          children: [
            Container(
              height: 500,
              width: 500,
              child: Image(image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1_JTxLxp1JutRB7aON5ByfOqPsWxW8shI9fz3Poul-RKCoq_0hPu7hux8tReot47LDA&usqp=CAU',)
            )),

            Text('Initializing.....',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500
            ),)
          ],
        )
        ),
      ),
    );
  }
}

class formpage extends StatefulWidget {
  const formpage({super.key});

  @override
  State<formpage> createState() => _formpageState();
}

class _formpageState extends State<formpage> {
  final textformkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  bool emailValid = true;
  bool passValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text('Login Page',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),),
      ),
      body: Form(
        key: textformkey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: ListView(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: emailcontroller,
                  validator: (valuea){
                    if(valuea!.isEmpty){
                      return "Please enter your email ";
                    }
                    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(valuea);
                    if (!emailValid){
                      return "Enter Valid Email";
                    }

                  },
                  decoration: InputDecoration(
                      suffix: Icon(Icons.email),

                      hintText: "Enter email ",
                      labelText: "Email",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passcontroller,
                  validator: (valueb){
                    if (valueb!.isEmpty) {
                      return 'Please enter password';
                    }
                    bool passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(valueb);
                    if (!passValid){
                      return "Enter Valid Password";
                    }


                  },
                  decoration: InputDecoration(
                      suffix: Icon(Icons.lock),
                      hintText: "Enter password ",
                      labelText: "Password",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(onPressed:(){
                        if (textformkey.currentState!.validate()){
                          return
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  apipage()),
                              );

                            });
                        }

                      }, child: Text('Log In',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,

                        ),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(onPressed:(){
                            setState(() {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  registerpage()),
                              );

                            });
                        }

                      , child: Text('Register',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,

                        ),)),
                    ),

                  ],
                )  ],
            ),
          ),
        ),
      ),
    );
  }
}

class registerpage extends StatefulWidget {
  const registerpage({super.key});

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final textformkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  TextEditingController fnamecontroller = new TextEditingController();
  TextEditingController lnamecontroller = new TextEditingController();
  TextEditingController usercontroller = new TextEditingController();
  bool emailValid = true;
  bool passValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Your Details'),
      ),
      body: Form(
        key: textformkey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
            decoration: InputDecoration(
            hintText: "Enter First Name ",
                labelText: "First Name",
                border: OutlineInputBorder()
            ),
                controller: fnamecontroller,
                validator: (value){
                  if (value!.isEmpty){
                    return "Enter First Name";
                  }
                  else if (fnamecontroller.text.length >8){
                    return "Length should be less than 8";
                  }
                },
              ),
        SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter Last Name ",
                      labelText: "Last Name",
                      border: OutlineInputBorder()
                  ),
                  controller: lnamecontroller,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Enter Last Name";
                    }
                    else if (lnamecontroller.text.length >8){
                      return "Length should be less than 8";
                    }
                  },
                ),
        SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter User Name ",
                    labelText: "User Name",
                    border: OutlineInputBorder()
                ),
                controller: usercontroller,
                validator: (value){
                  if (value!.isEmpty){
                    return "Enter User Name";
                  }
                  else if (fnamecontroller.text.length >15){
                    return "Length should be less than 15";
                  }
                },
              ),
        SizedBox(height: 20,),
            TextFormField(
              controller: emailcontroller,
              validator: (valuea){
                if(valuea!.isEmpty){
                  return "Please enter your email ";
                }
                bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(valuea);
                if (!emailValid){
                  return "Enter Valid Email";
                }

              },
              decoration: InputDecoration(
                  hintText: "Enter email ",
                  labelText: "Email",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passcontroller,
              validator: (valueb){
                if (valueb!.isEmpty) {
                  return 'Please enter password';
                }
                bool passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(valueb);
                if (!passValid){
                  return "Enter Valid Password";
                }
              },
              decoration: InputDecoration(
                  hintText: "Enter password ",
                  labelText: "Password",
                  border: OutlineInputBorder()
              ),
            ),
                SizedBox(height: 50,),
                   ElevatedButton(onPressed: (){
                     if (textformkey.currentState!.validate()){
                       return
                           setState(() {
                             showDialog(context: context, builder: (context)=> AlertDialog(
                                   actions: [
                                     Text('Successfully Registered'),
                                     SizedBox(height: 40,),
                                     TextButton(onPressed:(){
                                       Navigator.push(context, MaterialPageRoute(builder:(context)=> formpage()));
                                     }, child: Text('Ok'))
                                   ],
                             ) );
                           });
                     }
                   }

                       , child: Text('Register')),


      ]  ),
      )
    )));
  }
}


class apipage extends StatefulWidget {
  const apipage({super.key});

  @override
  State<apipage> createState() => _apipageState();
}

class _apipageState extends State<apipage> {
  Future<List> getapidata() async{
    var urlstring = "https://api.github.com/users/hadley/orgs";
    var url = Uri.parse(urlstring);
    var response = await apihelper.get(url);
    List data = jsonDecode(response.body);
    return data ;

  }

  Future<void> setloginvalue ()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(''
        ''
        ''
        ''
        ''
        ''
        '', true);
  }

  @override
  void initState() {
    // TODO: implement initState
    setloginvalue();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 50,
        child: ListView(
          children: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:( context)=>firstpage()));
            }, child:Text('Tap me')),
            UserAccountsDrawerHeader(
              accountName:Text('JENI'),
                                      accountEmail:Text('jenishaangel@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://m.media-amazon.com/images/I/91gzwasWLyL.png')
            ),),
      ExpansionTile(
        title: Text('View Tasks'),
        children: [
          ListTile(
            onTap: (){
             Navigator.push(context,MaterialPageRoute(builder: (context)=>firstpage()));
            },
            title: Text('Tasks'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>firsttask()));
            },
            title: Text('Task 1'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>secontask()));
            },
            title: Text('Task 2'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>thirdtask()));
            },
            title: Text('Task 3'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>fourthtask()));
            },
            title: Text('Task 4'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>image()));
            },
            title: Text('Task 5'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>calci()));
            },
            title: Text('Task 6'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>listgrid()));
            },
            title: Text('Task 7'),
          ),
        ],
      )
      ]),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(

        child: FutureBuilder(
            future: getapidata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData){
                List data= snapshot.data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context,index){
                      var singledata = data[index];
                      var imageurl = singledata['avatar_url'];
                      return ListTile(
                        title:Text(singledata['members_url']),
                        leading: Image.network(imageurl),

                      );

                    });
              }
              else {
                return CircularProgressIndicator();
              }
            }
        ),

      ),
    );
  }
} // api get method



/*class newpage extends StatefulWidget {
  const newpage({Key? key}) : super(key: key);
  @override
  State<newpage> createState() => _newpageState();
}
class _newpageState extends State<newpage> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshJournals();
    // Loading the diary when the app starts
  }
  final TextEditingController _titleController =
  TextEditingController();
  final TextEditingController _descriptionController =
  TextEditingController();
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom
            + 120,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText:
            'Title'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(hintText:
            'Description'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              // Save new journal
              if (id == null) {
                await _addItem();
              }
              if (id != null) {
                await _updateItem(id);
              }
              // Clear the text fields
              _titleController.text = '';
              _descriptionController.text = '';
              // Close the bottom sheet
              Navigator.of(context).pop();
            },
            child: Text(id == null ? 'Create New' :
            'Update'),
          )
        ],
      ),
    ));
  }
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
  }
  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text,
        _descriptionController.text);
    _refreshJournals();
  }
  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const
    SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQL'),
      ),
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card(
          color: Colors.orange[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
            title: Text(_journals[index]['title']),
            subtitle: Text(_journals[index]['description']),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        _showForm(_journals[index]['id']),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        _deleteItem(_journals[index]
                        ['id']),
                  ),
                ],
              ),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    detailPage(id: _journals[index]['id'],)),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
/// var a = 10
/// if (a>0)
class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 title TEXT,
 description TEXT,
 createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
 )
 """);
  }
  static Future<void> createContactTables(sql.Database database) async {
    await database.execute("""CREATE TABLE contact(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 title TEXT,
 description TEXT,
 name TEXT,
 createdAt TIMESTAMP NOT NULL DEFAULT
CURRENT_TIMESTAMP
 )
 """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite
  static Future<sql.Database> contactdb() async {
    return sql.openDatabase(
      'dbech.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createContactTables(database);
      },
    );
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'regi.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
  // Create new item (journal)
  static Future<int> createItem(String title, String? descrption, String text) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'description': descrption};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async
  {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }
  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id)
  async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs:
    [id], limit: 1);
  }
  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };
    final result =
    await db.update('items', data, where: "id = ?",
        whereArgs: [id]);
    return result;
  }
  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs:
      [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
      }
      }
}

class detailPage extends StatefulWidget {
  const detailPage({Key? key, required this.id}) : super(key:
  key);
  final int id;
  @override
  State<detailPage> createState() => _detailPageState();
}
class _detailPageState extends State<detailPage> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  // This function is used to fetch all data from the database

  void _refreshJournals(int id) async {
    final data = await SQLHelper.getItem(id);
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshJournals(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: _isLoading == true ?
            Text("Loading...") : ListTile(
              title: Text(_journals[0]['title']),
              subtitle: Text(_journals[0]['description']),),
          ),
        ],
      ),
    );
  }
}*/

////////

class sqlitefirst extends StatefulWidget {
  const sqlitefirst({super.key});

  @override
  State<sqlitefirst> createState() => _sqlitefirstState();
}

class _sqlitefirstState extends State<sqlitefirst> {
  Future<void> movetonxtpage()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool ? isLoggedin = prefs.getBool('isLoggedin');
    if (isLoggedin==true){
      Future.delayed(Duration(seconds: 2),(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return sqlitefourth();
        }));
      });
    }
    else {
      Future.delayed(Duration(seconds: 2),(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return sqlitesecond();
        }));
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movetonxtpage();
    ();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (
            Column(
              children: [
                Container(
                    height: 500,
                    width: 500,
                    child: Image(image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ1_JTxLxp1JutRB7aON5ByfOqPsWxW8shI9fz3Poul-RKCoq_0hPu7hux8tReot47LDA&usqp=CAU',)
                    )),

                Text('Initializing.....',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                  ),)
              ],
            )
        ),
      ),
    );
  }
}

class sqlitesecond extends StatefulWidget {
  const sqlitesecond({super.key});

  @override
  State<sqlitesecond> createState() => _sqlitesecondState();
}

class _sqlitesecondState extends State<sqlitesecond> {
  final textformkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();

  bool emailValid = true;
  bool passValid = true;
  void saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text('Login Page',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),),
      ),
      body: Form(
        key: textformkey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: ListView(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: emailcontroller,
                  validator: (valuea){
                    if(valuea!.isEmpty){
                      return "Please enter your email ";
                    }
                    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(valuea);
                    if (!emailValid){
                      return "Enter Valid Email";
                    }

                  },
                  decoration: InputDecoration(
                      suffix: Icon(Icons.email),

                      hintText: "Enter email ",
                      labelText: "Email",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passcontroller,
                  validator: (valueb){
                    if (valueb!.isEmpty) {
                      return 'Please enter password';
                    }
                    bool passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(valueb);
                    if (!passValid){
                      return "Enter Valid Password";
                    }


                  },
                  decoration: InputDecoration(
                      suffix: Icon(Icons.lock),
                      hintText: "Enter password ",
                      labelText: "Password",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(onPressed:(){
                        if (textformkey.currentState!.validate()){
                          return
                            setState(() {
                              saveCredentials('email','password');

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  sqlitefourth()),
                              );

                            });
                        }

                      }, child: Text('Log In',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,

                        ),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(onPressed:(){
                        setState(() {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  sqlitethird()),
                          );

                        });
                      }

                          , child: Text('Register',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,

                            ),)),
                    ),

                  ],
                )  ],
            ),
          ),
        ),
      ),
    );
  }
}



class sqlitethird extends StatefulWidget {
  const sqlitethird({super.key});

  @override
  State<sqlitethird> createState() => _sqlitethirdState();
}

class _sqlitethirdState extends State<sqlitethird> {

  final textformkey = GlobalKey<FormState>();

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  TextEditingController fnamecontroller = new TextEditingController();
  TextEditingController lnamecontroller = new TextEditingController();
  TextEditingController usercontroller = new TextEditingController();
  bool emailValid = true;
  bool passValid = true;
  List<Map<String, dynamic>> _journals = [];
  Future<void> _addItem() async {
    await SQLFHelper.createItem(
        fnamecontroller.text, lnamecontroller.text, usercontroller.text,
        emailcontroller.text, passcontroller.text);
    _refreshJournals();
  }

  void _refreshJournals() async {
    final data = await SQLFHelper.getItems();
    setState(() {
      _journals = data;
      print(_journals);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _refreshJournals();
    super.initState();
  }
  /*List<Map<String, dynamic>> _journals = [];

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLFHelper.getItems();
    setState(() {
      _journals = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshJournals();
  }

  void showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      fnamecontroller.text = existingJournal['firstname'];
      lnamecontroller.text = existingJournal['lastname'];
      usercontroller.text = existingJournal['username'];
      emailcontroller.text = existingJournal['email'];
      passcontroller.text = existingJournal['password'];
    }
    Future<void> _addItem() async {
      await SQLFHelper.createItem(
          fnamecontroller.text, lnamecontroller.text, usercontroller.text,
          emailcontroller.text, passcontroller.text);
      _refreshJournals();
    }
    // Update an existing journal
    Future<void> _updateItem(int id) async {
      await SQLFHelper.updateItem(
          id, fnamecontroller.text, lnamecontroller.text, usercontroller.text,
          emailcontroller.text, passcontroller.text);
      _refreshJournals();
    }*/

    @override
    Widget build (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Register Your Details'),
          ),
          body: Form(
              key: textformkey,
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter First Name ",
                                labelText: "First Name",
                                border: OutlineInputBorder()
                            ),
                            controller: fnamecontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter First Name";
                              }
                              else if (fnamecontroller.text.length > 8) {
                                return "Length should be less than 8";
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter Last Name ",
                                labelText: "Last Name",
                                border: OutlineInputBorder()
                            ),
                            controller: lnamecontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Last Name";
                              }
                              else if (lnamecontroller.text.length > 8) {
                                return "Length should be less than 8";
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter User Name ",
                                labelText: "User Name",
                                border: OutlineInputBorder()
                            ),
                            controller: usercontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter User Name";
                              }
                              else if (usercontroller.text.length > 15) {
                                return "Length should be less than 15";
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: emailcontroller,
                            validator: (valuea) {
                              if (valuea!.isEmpty) {
                                return "Please enter your email ";
                              }
                              bool emailValid = RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                  .hasMatch(valuea);
                              if (!emailValid) {
                                return "Enter Valid Email";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter email ",
                                labelText: "Email",
                                border: OutlineInputBorder()
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: passcontroller,
                            validator: (valueb) {
                              if (valueb!.isEmpty) {
                                return 'Please enter password';
                              }
                              bool passValid = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(valueb);
                              if (!passValid) {
                                return "Enter Valid Password";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter password ",
                                labelText: "Password",
                                border: OutlineInputBorder()
                            ),
                          ),
                          SizedBox(height: 50,),
                          ElevatedButton(onPressed: () {
                            if (textformkey.currentState!.validate()) {
                              return
                                setState(() {
                                  showDialog(
                                      context: context, builder: (context) =>
                                      AlertDialog(
                                        actions: [
                                          Text('Successfully Registered'),
                                          SizedBox(height: 40,),
                                          ElevatedButton(
                                            onPressed: ()async{
                                              await _addItem();
                                            },
                                            child: Text('OK'),
                                          )
                                        ],
                                      ));
                                });
                            }
                          }
                              , child: Text('Register')),



                        ]),
                  )
              )));
    }
  }


class SQLFHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 firstname TEXT,
 lastname TEXT,
 username TEXT,
 email TEXT,
 password TEXT,
 createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
 )
 """);
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'reg.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
  // Create new item (journal)
  static Future<int> createItem(String firstname, String lastname , String username , String email , String password) async {
    final db = await SQLFHelper.db();
    final data = {'firstname':firstname , 'lastname':lastname , 'username':username , 'email':email , 'password':password };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async
  {
    final db = await SQLFHelper.db();
    return db.query('items', orderBy: "id");
  }
  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id)
  async {
    final db = await SQLFHelper.db();
    return db.query('items', where: "id = ?", whereArgs:
    [id], limit: 1);
  }
  // Update an item by id
  static Future<int> updateItem(
      int id,String firstname, String lastname , String username , String email , String password ) async {
    final db = await SQLFHelper.db();
    final data = {'firstname':firstname ,
      'lastname':lastname ,
      'username':username ,
      'email':email ,
      'password':password,
      'createdAt': DateTime.now().toString()
    };
    final result =
    await db.update('items', data, where: "id = ?",
        whereArgs: [id]);
    return result;
  }
  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLFHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs:
      [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}

class sqlitefourth extends StatefulWidget {
  const sqlitefourth({super.key});

  @override
  State<sqlitefourth> createState() => _sqlitefourthState();
}

class _sqlitefourthState extends State<sqlitefourth> {


var selectedindex = 0;




  Future<void> setloginvalue ()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(''
        ''
        ''
        ''
        ''
        ''
        '', true);
  }

  @override
  void initState() {
    // TODO: implement initState
    setloginvalue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome '
        ),
        elevation: 15,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100))
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SizedBox(),
        ),
      ),

      bottomNavigationBar:BottomNavigationBar(
      currentIndex: selectedindex ,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(color: Colors.black),
      unselectedLabelStyle: TextStyle(color: Colors.black),


      items: [
        BottomNavigationBarItem(

            icon:InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const sqhome()),
                );
                },
              child: Icon(Icons.home_outlined,
                  color: Colors.black),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon:InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const sqproducts()),
                );
              },
              child: Icon(Icons.shopping_cart,
                  color: Colors.black),
            ),
            label: "Products"),



      ],
    ),
    );
  }
}


class sqhome extends StatefulWidget {
  const sqhome({super.key});

  @override
  State<sqhome> createState() => _sqhomeState();
}

class _sqhomeState extends State<sqhome> {
  var selectedindex = 0;
  Future<List> getapidata() async{
    var urlstring = "https://api.github.com/users/hadley/orgs";
    var url = Uri.parse(urlstring);
    var response = await apihelper.get(url);
    List data = jsonDecode(response.body);
    return data ;

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Text('Dashboard '
        ),
        elevation: 15,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SizedBox(),
        ),
      ),
      body: Center(
        child: FutureBuilder(
            future: getapidata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData){
                List data= snapshot.data;
                return Container(
                  color: Colors.green[100],
                  child: ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context,index){
                        var singledata = data[index];
                        var imageurl = singledata['avatar_url'];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 55.0,
                                          height: 55.0,
                                          color: Colors.green,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(imageurl),
                                          ),
                                        ),
                                        SizedBox(width: 20.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 5.0,),
                                            Text(singledata['login'],style: TextStyle( fontWeight: FontWeight.w500,fontSize:15,color: Colors.black),),
                                            SizedBox(height: 3.0,),
                                            Text(singledata['id'].toString(),style: TextStyle( fontWeight: FontWeight.w300,color: Colors.brown),)
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 30,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0)
                                          ),
                                        ),
                                        onPressed: (){},child: Text('Click',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                        );

                      }),
                );
              }
              else {
                return CircularProgressIndicator();
              }
            }
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: selectedindex ,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),

        items: [
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const sqhome()),
                  );
                },
                child: Icon(Icons.home_outlined,
                    color: Colors.black),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const sqproducts()),
                  );
                },
                child: Icon(Icons.shopping_cart,
                    color: Colors.black),
              ),
              label: "Products"),



        ],
      ),
    ) ;
  }
}





class sqproducts extends StatefulWidget {
  const sqproducts({super.key});

  @override
  State<sqproducts> createState() => _sqproductsState();
}

class _sqproductsState extends State<sqproducts> {
  var selectedindex = 0;
  Future<List> getapidata() async{
    var urlstring = "https://api.github.com/users/hadley/orgs";
    var url = Uri.parse(urlstring);
    var response = await apihelper.get(url);
    List data = jsonDecode(response.body);
    return data ;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check out Products Here '
        ),
        elevation: 15,
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SizedBox(),
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: selectedindex ,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),

        items: [
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const sqhome()),
                  );
                },
                child: Icon(Icons.home_outlined,
                    color: Colors.black),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const sqproducts()),
                  );
                },
                child: Icon(Icons.shopping_cart,
                    color: Colors.black),
              ),
              label: "Products"),



        ],
      ),
      body:Center(

        child: FutureBuilder(
            future: getapidata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData){
                List data= snapshot.data;
                return Container(
                  color: Colors.teal[100],
                  child: GridView.builder(
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount:data.length ,
                    itemBuilder: (BuildContext context,index){
                      var singledata = data[index];
                      var imageurl = singledata['avatar_url'];
                        return   Card(
                            shadowColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            ),

                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(imageurl),
                                  ),
                                  SizedBox(height: 20,),

                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0)
                                      ),
                                    ),
                                    onPressed: (){},child: Text('Click',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                  ),
                                ]
                              ),
                            ),
                        );
                    },
                  ),
                );
              }
              else {
                return CircularProgressIndicator();
              }
            }
        ),

      ),
    );
  }
}


class sqprofile extends StatefulWidget {
  const sqprofile( {super.key,required this.id});
final  id;
  @override
  State<sqprofile> createState() => _sqprofileState();
}

class _sqprofileState extends State<sqprofile> {
  Future<Map<String, String>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? "";
    final password = prefs.getString('password') ?? "";
    return {'email': email, 'password': password};
  }

  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals(id) async {
    var email ="";
    var password="" ;
    final data = await SQLFHelper.getItem(id);
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _refreshJournals(widget.id);
    super.initState();
  }
   var selectedindex = 0;
  static Future<List<Map<String, dynamic>>> getItem(int id)
  async {
    final db = await SQLFHelper.db();
    return db.query('items', where: "id = email? AND password ?", whereArgs:
    [id,"email","password"], limit: 2);
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(70)
              )
            ),
            child: Stack(
              children: [
                Positioned(top: 80,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50)
                        )
                      ),
                    )),
                Positioned(
                    top:115,
                    left: 20,
                    child: Text('It`s About You :)',style: TextStyle(fontSize:20,fontWeight:FontWeight.w500,color: Colors.black),))
              ],
            ),
          ),
          SizedBox(height: 50,),
         TextButton(onPressed: (){
           getCredentials();
         }, child: Text('Get')),
         Text(_journals[0] ['email']),
          Text(_journals[0]['password'])
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedindex ,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),

        items: [
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const sqhome()),
                  );
                },
                child: Icon(Icons.home_outlined,
                    color: Colors.black),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const sqproducts()),
                  );
                },
                child: Icon(Icons.shopping_cart,
                    color: Colors.black),
              ),
              label: "Products"),



        ],
      ),
    );
  }
}

