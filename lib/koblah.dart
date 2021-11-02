
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:location/location.dart';
import 'package:sensors/sensors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'locationClass.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Koblah extends StatefulWidget {

  @override
  _KoblahState createState() => _KoblahState();
}

class _KoblahState extends State<Koblah> {
  int mode = 0;
  late AniControl compass;
  late double lat=0 , lon=0 ;

  Location location = Location();
  double B = 0;
  bool _load=true;
   final connect Connect=new connect();



  @override
  void initState() {
    super.initState();
    _getlango();
    compass = AniControl([
      Anim('dir', 0, 360, 45, true),
      Anim('hor', -9.6, 9.6, 20, false),
      Anim('ver', -9.6, 9.6, 20, false),
    ]);

    FlutterCompass.events!.listen((angle) {
      compass['dir'].value = angle.heading!;
     // earth['dir'].value = angle.heading!;
   //   print("lat $lat");
    });

    accelerometerEvents.listen((event) {
      compass['hor'].value = -event.x;
      compass['ver'].value = -event.y;
    });


  }
  @override
  void dispose() {
   // _connectivitySubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: PageController(viewportFraction: 0.8),
      scrollDirection: Axis.vertical,
      children: [_load? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 5.0,backgroundColor: Colors.white,),
          Text('يتم التحميل',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        ],
      )) :_compassall()],
    );
  }

  Widget _compassall() {
    return Column(children: [
      Expanded(child: Padding(padding: EdgeInsets.all(5), child: Compass())),
      Expanded( child: Padding(padding: EdgeInsets.all(5), child: _buildCompass())),
    ]);
  }

  Widget _buildCompass() {

    return Material(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: ExactAssetImage('imag/comm.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Transform.rotate(
          angle: ((360 - B) * (pi / 180) * -1),
          child: Image.asset(
            'imag/com.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void _incrementCounter(double? latitude, double? longitude) {
    double x = 0;
    double Y = 0;
    print("latitude: $latitude");
    double latitude1 = latitude!;
    double KALa = 21.42265;
    double KALo = 39.82621;
    //double subLO=KA_lo-longitude!.toDouble();
    double subLO = KALo - longitude!;
    setState(() {
      // _counter++;
      x = cos((pi / 180) * KALa) * sin((pi / 180) * subLO);
      Y = (cos((pi / 180) * latitude1) * sin((pi / 180) * KALa)) -
          (sin((pi / 180) * latitude1) *
              cos((pi / 180) * KALa) *
              cos((pi / 180) * subLO));
      B = atan2(x, Y);
      B = (180 / pi) * B;
      _load=false;
    });
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
        }
        _incrementCounter(lat, lon);
        setLocation(lat,lon);
      });
    });
  }
 /* connected() {

   Connect.getLoc().then((value){
     if(value.containsKey("error")){
      print('لا يوجد انترنت');
     }
     else{
       lat=value['latitude'];
       lon=value['longitude'];
       setLocation(value['latitude'],value['longitude']);
       _incrementCounter(lat, lon);
     }
    }) ;

  }*/
  void setLocation(double? lati, double? long, [bool weather = true]) {
    lon = long!;
    lat = lati!;
    setState(() {});
  }
  Widget Compass() {
    return GestureDetector(
      onTap: () => setState(() => mode++),
      child: FlareActor("assets/compass.flr",
          animation: 'mode${mode % 2}', controller: compass),
    );
  }


}
