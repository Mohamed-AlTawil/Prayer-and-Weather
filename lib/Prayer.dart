// ignore: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'My_Provider.dart';
import 'locationClass.dart';
import 'package:provider/provider.dart';
class Prayer extends StatefulWidget {
  const Prayer({Key? key}) : super(key: key);

  @override
  _PrayerState createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  List<String> pay = [];
  late DateTime fajer = DateTime.now();
  late DateTime sunrise = DateTime.now();
  late DateTime dhuhr = DateTime.now();
  late DateTime asr = DateTime.now();
  late DateTime maghrib = DateTime.now();
  late DateTime isha = DateTime.now();
  late DateTime s1 =DateTime.now();
  late bool staypay = false;
  late bool staysur = false;
  late String name="";
  final connect Connect = new connect();



  double lat = 0, lon = 0;
  bool _load = true;

  void initState() {
    super.initState();
    //adan();

    _getlango();
  }
  @override
  void dispose() {
    super.dispose();
    //audioPlayer.stop();
  }
  @override
  Widget build(BuildContext context) {
    final wh=MediaQuery.of(context);
    pay = Provider.of<MyProvider>(context, listen: true).payname;
    return _load
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 5.0,
                backgroundColor: Colors.white,
              ),
              Text(
                'يتم التحميل',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ))
        : ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "imag/payth.png",
                      height: wh.size.height*0.25,
                    ),
                    padding: EdgeInsets.fromLTRB(wh.size.width*0.15, 0, wh.size.width*0.15, 0),
                  ),
                  adanText(),
                  Container(
                    child: Image.asset(
                      "imag/z2.png",
                      width: wh.size.width*0.60,
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  Widget adanText() {
    final wh=MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: wh.size.height*0.05,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(wh.size.width*0.05, 0, wh.size.width*0.05, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blueGrey,
              border: Border.all(color: Colors.white)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(staysur?
                "${pay[7]}:":"${pay[6]} $name:",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),
              ),
              Text(
                "${DateFormat.Hms().format(s1)}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
          width: double.infinity,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(wh.size.width*0.15, wh.size.height*0.025, wh.size.width*0.15, wh.size.height*0.05),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blueGrey,
              border: Border.all(color: Colors.white)),
          child: Column(
            children: [
              SizedBox( height: 20),
              Row(
                children: [
                  SizedBox(width: wh.size.width*0.037),
                  Expanded(
                    child: Text(
                      '${pay[0]}:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                    ),
                    flex:5,
                  ),
                  Expanded(
                    child: Text(
                     "${DateFormat.Hm().format(fajer)}",
                    //  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                    ),
                    flex:4,
                  ),
                  SizedBox( width: wh.size.width*0.037),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: wh.size.width*0.037),
                  Expanded(
                    child: Text(
                      '${pay[1]}:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    child: Text(
                      "${DateFormat.Hm().format(sunrise)}",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                    ),
                    flex: 4,
                  ),
                  SizedBox(width: wh.size.width*0.037),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: wh.size.width*0.037),
                  Expanded(
                      child: Text(
                        '${pay[2]}:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent),
                      ),
                      flex: 5),
                  Expanded(
                      child: Text(
                        "${DateFormat.Hm().format(dhuhr)}",
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent),
                      ),
                      flex: 4),
                  SizedBox(width: wh.size.width*0.037),
                ],
              ),
              Row(
                children: [
                  SizedBox(width:wh.size.width*0.037),
                  Expanded(
                      child: Text(
                        '${pay[3]}:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent),
                      ),
                      flex: 5),
                  Expanded(
                      child: Text(
                        "${DateFormat.Hm().format(asr)}",
                      //  textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent),
                      ),
                      flex: 4),
                  SizedBox(width: wh.size.width*0.037),
                ],
              ),
              Row(
                children: [
                  SizedBox( width: wh.size.width*0.037 ),
                  Expanded(
                      child: Text(
                        '${pay[4]}:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent),
                      ),
                      flex: 5),
                  Expanded(
                      child: Text(
                        "${DateFormat.Hm().format(maghrib)}",
                  //      textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent),
                      ),
                      flex: 4),
                  SizedBox( width: wh.size.width*0.037),
                ],
              ),
              Row(
                children: [
                  SizedBox( width: wh.size.width*0.037),
                  Expanded(
                      child: Text(
                        '${pay[5]}:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent),
                      ),
                      flex:5),
                  Expanded(
                      child: Text(
                        "${DateFormat.Hm().format(isha)}",
                      //  textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent),
                      ),
                      flex: 4),
                  SizedBox(width: wh.size.width*0.037),
                ],
              ),
              SizedBox( height: 20),
            ],
          ),
        ),
      ],
    );
  }

  adan() {
    print("$lat::$lon");
    final myCoordinates =Coordinates(lat, lon); // Replace with your own location lat, lng.
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    setState(() {
      fajer = prayerTimes.fajr;
      sunrise = prayerTimes.sunrise;
      dhuhr = prayerTimes.dhuhr;
      asr = prayerTimes.asr;
      maghrib = prayerTimes.maghrib;
      isha = prayerTimes.isha;
      if (fajer.isAfter(DateTime.now())) {
         s1 = DateTime.fromMillisecondsSinceEpoch(fajer.difference(DateTime.now()).inMilliseconds, isUtc: true);
        //speed = "${DateFormat.Hms().format(s1)}";
        staysur=false;
        name=pay[0];
      } else if (sunrise.isAfter(DateTime.now())) {
         s1 = DateTime.fromMillisecondsSinceEpoch(sunrise.difference(DateTime.now()).inMilliseconds,isUtc: true);
       // speed = "${DateFormat.Hms().format(s1)}";
        staysur=true;
        name=pay[1];
      } else if (dhuhr.isAfter(DateTime.now())) {
        s1 = DateTime.fromMillisecondsSinceEpoch( dhuhr.difference(DateTime.now()).inMilliseconds,isUtc: true);
       // speed = "${DateFormat.Hms().format(s1)}";
        staysur=false;
        name=pay[2];
      } else if (asr.isAfter(DateTime.now())) {
         s1 = DateTime.fromMillisecondsSinceEpoch(asr.difference(DateTime.now()).inMilliseconds, isUtc: true);
       // speed = "${DateFormat.Hms().format(s1)}";
       // print("$speed , ${DateTime.now()}, $asr ,$s1");
        staysur=false;
        name=pay[3];
      } else if (maghrib.isAfter(DateTime.now())) {
         s1 = DateTime.fromMillisecondsSinceEpoch( maghrib.difference(DateTime.now()).inMilliseconds,isUtc: true);
       // speed = "${DateFormat.Hms().format(s1)}";
        staysur=false;
        name=pay[4];
      } else if (isha.isAfter(DateTime.now())) {
         s1 = DateTime.fromMillisecondsSinceEpoch(isha.difference(DateTime.now()).inMilliseconds, isUtc: true);
       // speed = "${DateFormat.Hms().format(s1)}";
        staysur=false;
        name=pay[5];
      } else {
        DateTime s = fajer.add(new Duration(days:1));
         s1 = DateTime.fromMillisecondsSinceEpoch(s.difference(DateTime.now()).inMilliseconds,isUtc: true);
      //  speed = "${DateFormat.Hms().format(s1)}";
        staysur=false;
        name=pay[0];
      }
    });
  }

  Future<void> _getlango() async {
      Connect.getLoction().then((value) {
        if(value.containsKey("error")){
          print('لا يوجد انترنت');
        }
        else{
        setState(() {
          lat=value['latitude'];
          lon=value['longitude'];
          _load = false;
          adan();
          time();
        });}
      });
  }

  
void time(){
  int seconds = s1.second;
  int minutes = s1.minute;
  int hours = s1.hour;
  print('$s1');
  Timer _timer=new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (seconds == 0 && minutes==0 && hours== 0) {
        Provider.of<MyProvider>(context, listen: false).azazplay(true);
        adan();
      }
      else {
        seconds = seconds - 1;
        if (seconds < 0) {
          minutes -= 1;
          seconds = 59;
          if (minutes <0) {
            hours -= 1;
            minutes = 59;
          }
        }
      }
      setState(() {
      s1=DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day,hours,minutes,seconds);
    });
  });


}



   //AudioPlayer player = new AudioPlayer();
    //player.play("imag/azan.mp3");
    // await player.setAsset('imag/azan.mp3');
    // player.play();
  }

