import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'ConnectInternet.dart';
import 'locationClass.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final connect Connect = new connect();
  final ConnectInternet connectInternet = new ConnectInternet();
  int mode = 0,
      map = 0;
  late AniControl earth;
  late double lat = 0,
      lon = 0;

  String city = '',
      weather = '',
      icon = '01d';
  double temp = 0,
      humidity = 0;
  bool _load=true;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(viewportFraction: 0.8),
      scrollDirection: Axis.vertical,
      children: [
        _load?
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 5.0,backgroundColor: Colors.white,),
          Text('يتم التحميل',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        ],
      ))
            :Earth()],
    );
  }

  @override
  void initState() {
    connectInternet.initConnectivity().then((value) {});
    connectInternet.connectivity.onConnectivityChanged.listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${connectInternet.updateConnectionStatus(event)}",style: TextStyle(color: Colors.white),),
            backgroundColor:Colors.blue,)
      );
    });

    earth = AniControl([
      Anim('dir', 0, 360, 20, true),
      Anim('lat', -90, 90, 1, false),
      Anim('lon', -180, 180, 1, true),
    ]);

    _getlango();
  }


  void getWeather(double lat, double lon) async {
    //'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key';

    var key = '7c5c03c8acacd8dea3abd517ae22af34';
    Uri url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key');

    var res = await http.Client().get(url);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      city = data['name'];
      var m = data['weather'][0];
      weather = m['main'];
      icon = m['icon'];
      m = data['main'];
      temp = m['temp'] - 273.15;
      humidity = m['humidity'] + 0.0;
      setState(() {_load=false;});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar( content: Text("خطأ في الخادم",style: TextStyle(color: Colors.white),),
        backgroundColor:Colors.blue,));
    }
  }

  Future<void> _getlango() async {
    setState(() {
      Connect.getLoction().then((value) {
        if(value.containsKey("error")){
          print('لا يوجد انترنت');
        }
        else{
          lat=value['latitude'];
          lon=value['longitude'];
          setLocation(value['latitude'], value['longitude']);
        }

      });
    });
  }


  void setLocation(double? lati, double? long, [bool weather = true]) {
    earth['lat'].value = lat = lati!;
    earth['lon'].value = lon = long!;
    if (weather) getWeather(lat, lon);
    setState(() {});
  }

  Widget Earth() {
    final wh=MediaQuery.of(context);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(city, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 20,),
      //Text('lat:${lat.toStringAsFixed(2)}  lon:${lon.toStringAsFixed(2)}'),
      /*Expanded(
        child: GestureDetector(
          onTap: () => setState(() => earth.play('mode${++map % 2}')),
          onDoubleTap: _getlango,
          onPanUpdate: (pan) =>
              setLocation(
                  (lat - pan.delta.dy).clamp(-90.0, 90.0),
                  (lon - pan.delta.dx + 180) % 360 - 180,
                  false),
          onPanEnd: (_) => getWeather(lat, lon),
          child: FlareActor("assets/earth.flr",
              animation: 'pulse', controller: earth),
        ),
      ),*/
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: wh.size.width*0.2,
            height: wh.size.width*0.2,
            child: FlareActor('assets/weather.flr', animation: icon)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${temp.toInt()}°', style: TextStyle(fontSize: 60)),
          Text(weather),
          Text('Humidity ${humidity.toInt()}%'),
        ]),
      ]),
    ]);
  }
}
