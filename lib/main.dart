// @dart=2.9
 import 'package:flutter/material.dart';
import 'package:untitled/My_Provider.dart';
import 'Setting.dart';
import 'Prayer.dart';
import 'Weather.dart';
import 'azan.dart';
import 'firstScreen.dart';
import 'koblah.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(
      ChangeNotifierProvider<MyProvider>(
        create:(_)=>MyProvider() ,
        child: loading(),
        //MyApp(),

  )
      );
}
class MyApp extends StatefulWidget {

  MyAppHome createState() => MyAppHome();
}
class MyAppHome extends State<MyApp> {

  int _selectTap = 0;
  bool azan=false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Widget> _page = [
    Koblah(),
    Prayer(),
    WeatherPage(),
    SettingApp(),
  ];
  @override
  void initState() {
    super.initState();
    _setlango();

    Provider.of<MyProvider>(context, listen: false).getlango();
  }

  void dispose() {
    super.dispose();
    //audioPlayer.stop();
  }

  Future<void> _setlango() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
     prefs.setDouble("lat", -1.0);
      prefs.setDouble("lon", -1.0);
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _selectTap = Provider.of<MyProvider>(context, listen: true).selectTap;
    azan=Provider.of<MyProvider>(context, listen: true).azan;
    print('$azan');
    print("${ Provider
        .of<MyProvider>(context, listen: true)
        .textDirection}");

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: DefaultTabController(
            length: 4,
            child:azan?
            AzanPlay():Directionality(
                textDirection: Provider
                    .of<MyProvider>(context, listen: true).textDirection,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('${Provider
                        .of<MyProvider>(context, listen: true)
                        .tabbar[_selectTap]}'),
                  ),
                  body: new Dismissible(
                    resizeDuration: null,
                    onDismissed: (DismissDirection direction) =>
                        Provider.of<MyProvider>(context, listen: false).des(
                            direction, _selectTap),
                    key: new ValueKey(Provider
                        .of<MyProvider>(context, listen: true)
                        .selectTap),
                    child: _page[Provider
                        .of<MyProvider>(context, listen: true)
                        .selectTap],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Colors.blue,
                    selectedItemColor: Colors.cyanAccent,
                    unselectedItemColor: Colors.blueGrey,
                    currentIndex: Provider
                        .of<MyProvider>(context, listen: true)
                        .selectTap,
                    selectedFontSize: 20,
                    unselectedFontSize: 15,
                    type: BottomNavigationBarType.shifting,
                    onTap: (int index) =>
                        Provider.of<MyProvider>(context, listen: false).x(
                            index),
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.location_on_outlined),
                          label: Provider
                              .of<MyProvider>(context, listen: true)
                              .tabbar[4]),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home_filled), label: Provider
                          .of<MyProvider>(context, listen: true)
                          .tabbar[5]),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.wb_sunny_rounded),
                          label: Provider
                              .of<MyProvider>(context, listen: true)
                              .tabbar[6]),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings), label: Provider
                          .of<MyProvider>(context, listen: true)
                          .tabbar[7]),
                    ],
                  ),
                )
            )
        )
    );
  }



}
