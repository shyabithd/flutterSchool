import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:school_system/login_page.dart';
import 'package:school_system/contact_page.dart';
import 'package:school_system/news_page.dart';
import 'package:school_system/newslist_page.dart';
import 'package:school_system/about_page.dart';
import 'package:school_system/profile_page.dart';
import 'package:school_system/attendance_page.dart';
import 'package:school_system/utils.dart';
import 'package:school_system/assignment_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {

  final Todo todo;
  HomePage({Key key, @required this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State(todo: todo);
}

class _State extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;
  final Todo todo;

  _State({Key key, @required this.todo});

  @override
  void initState() {
    super.initState();
    print(todo.title);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget getDropdown() {
    return Center (
        child: DropdownButton<String>(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 30,
          elevation: 20,
          underline: Container(
            height: 2,
            color: Colors.greenAccent,
          ),
        onChanged: (String newValue) {
          if (newValue == "Logout") {
            FirebaseAuth auth = FirebaseAuth.instance;
            Future<void> ff = auth.signOut();
            ff.then((value) =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(),),
                ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileTab(),),
            );
          }
        },
        items: <String>['Profile', 'Logout']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })
            .toList(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("School Management"), backgroundColor: Colors.greenAccent, /*automaticallyImplyLeading: false,*/ actions: [
        getDropdown()
    ],),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(child: HomeLayout(),),
            Container(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('Assignments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ),
                  Expanded(
                    child: AssignmentTab(),
                  )
                ]
              )
            ),
            Container(child: AttendancePage(),),
            Container(child: NewsListPage(),),
            Container(child: ContactForm(),),
            // Container(child: AboutPage(),),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.greenAccent,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          getBottomBarItem('Home', Icons.home),
          getBottomBarItem('Assignment', Icons.assessment),
          getBottomBarItem('Attendance', Icons.attractions),
          getBottomBarItem('News', Icons.next_week_outlined),
          getBottomBarItem('Contact Us', Icons.contact_mail),
          // getBottomBarItem('About', Icons.account_balance_outlined),
        ],
      ),
    );
  }

  BottomNavyBarItem getBottomBarItem (String name, IconData iconData) {
    return BottomNavyBarItem(
        activeColor: Colors.white,
        title: Text(name),
        icon: Icon(iconData)
    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomeLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeLayoutState();
  }
}

class _HomeLayoutState extends State<HomeLayout> {
  int _current = 0;

  List<Widget> getImageSliders () {
    final List<Widget> imageSliders = imgList.map((item) =>
        Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                    children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Container(alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(10),
                    child: Text('Title', style: TextStyle(color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,))),
                Container(alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(10),
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsPage()),
                      );
                    },
                    child: new Text("More >>>", style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                ),
              ],
            )
        ),
    )
    ,)).toList();
    return imageSliders;
  }

  Widget getPaddedHomeWidget(String title) {
    return Padding(
        padding: EdgeInsets.all(7),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 0), child: Column(
          children: [
            getPaddedHomeWidget('News'),
            CarouselSlider(
              items: getImageSliders(),
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: imgList.map((url) {
            //     int index = imgList.indexOf(url);
            //     return Container(
            //       width: 8.0,
            //       height: 8.0,
            //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: _current == index
            //             ? Color.fromRGBO(0, 0, 0, 0.9)
            //             : Color.fromRGBO(0, 0, 0, 0.4),
            //       ),
            //     );
            //   }).toList(),
            // ),

            getPaddedHomeWidget('Assignments'),
            Expanded(
              child: AssignmentTab(),
            ),
          ]
      ),
      ),
    );
  }
}


class ImageSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: CarouselSlider(
            options: CarouselOptions(autoPlay: true),
            items: imgList.map((item) => Stack(
                children: <Widget> [
                  Container (
                    child: Center(
                        child: Image.network(
                            item, fit:
                        BoxFit.none, width: 1000)
                    ),
                  ),
                  Container(alignment: Alignment.topLeft, padding: EdgeInsets.all(10), child: Text('Title')),
                  Container(alignment: Alignment.bottomLeft, padding: EdgeInsets.all(10), child: Text('Click here to see more... >>>')),
                ]
            ),
            ).toList(),
          )
      ),
    );
  }
}