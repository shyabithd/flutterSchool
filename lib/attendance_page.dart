import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_system/login_page.dart';
import 'package:school_system/recordbook_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'settings.dart';
import 'widgets.dart';

class AttendancePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new AttendancePage_State();
}
// ignore: camel_case_types
class AttendancePage_State extends State<AttendancePage> {
  int _current = 0;
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);
  static const iosIcon = Icon(CupertinoIcons.profile_circled);
  var switch2 = false;

  final List<String> classList = ['10A', '10B', '11A', '11B'];

  List<Widget> getImageSliders (BuildContext context) {
    final List<Widget> imageSliders = classList.map((item) =>
        Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: RaisedButton (
                  child: Text (item)
                )
            ),
          )
          ,)).toList();
    return imageSliders;
  }

  Widget _buildBody(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15),
              child: Text('Attendance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
          ),
          CarouselSlider(
            items: getImageSliders(context),
            options: CarouselOptions(
                viewportFraction: 0.9,
                height: 50,
                scrollDirection: Axis.vertical,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                    print(_current);
                  });
                }
            ),
          ),
          ListTile(
            title: Text('Hide Previous Dates'),
            trailing: Switch.adaptive(
              value: switch2,
              onChanged: (value) => setState(() => switch2 = value),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Non-shared code below because on iOS, the settings tab is nested inside of
  // the profile tab as a button in the nav bar.
  // ===========================================================================

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: SettingsTab.iosIcon,
          onPressed: () {
            // This pushes the settings page as a full page modal dialog on top
            // of the tab bar and everything.
            Navigator.of(context, rootNavigator: true).push<void>(
              CupertinoPageRoute(
                title: SettingsTab.title,
                fullscreenDialog: true,
                builder: (context) => SettingsTab(),
              ),
            );
          },
        ),
      ),
      child: _buildBody(context),
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

class PreferenceCard extends StatelessWidget {
  const PreferenceCard({this.header, this.content, this.preferenceChoices});

  final String header;
  final String content;
  final List<String> preferenceChoices;

  @override
  Widget build(context) {
    return PressableCard(
      color: Colors.greenAccent,
      flattenAnimation: AlwaysStoppedAnimation(0),
      child: Stack(
        children: [
          Container(
            height: 300,
            width: 400,
            child: Padding(
              padding: EdgeInsets.only(top: 55, left: 10),
              child: Container(
                child: Text(
                  content,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black12,
              height: 40,
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                header,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return RecordBookPage();
            }
        );
      },
    );
  }
}

class LogOutButton extends StatelessWidget {
  static const _logoutMessage = Text(
      "You can't actually log out! This is just a demo of how alerts work.");

  // ===========================================================================
  // Non-shared code below because this tab shows different interfaces. On
  // Android, it's showing an alert dialog with 2 buttons and on iOS,
  // it's showing an action sheet with 3 choices.
  //
  // This is a design choice and you may want to do something different in your
  // app.
  // ===========================================================================

  Widget _buildAndroid(BuildContext context) {
    return RaisedButton(
      child: Text('Logout', style: TextStyle(color: Colors.white)),
      color: Colors.greenAccent,
      onPressed: () {
        FirebaseAuth auth = FirebaseAuth.instance;
        Future<void> ff = auth.signOut();
        ff.then((value) =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(),),
            ),
        );
      },
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoButton(
      color: CupertinoColors.destructiveRed,
      child: Text('Log out'),
      onPressed: () {
        // You should do something with the result of the action sheet prompt
        // in a real app but this is just a demo.
        showCupertinoModalPopup<void>(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              title: Text('Log out?'),
              message: _logoutMessage,
              actions: [
                CupertinoActionSheetAction(
                  child: const Text('Reprogram the night man'),
                  isDestructiveAction: true,
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoActionSheetAction(
                  child: const Text('Got it'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text('Cancel'),
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}