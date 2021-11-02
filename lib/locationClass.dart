
import 'package:location/location.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anim {
  String name;
  double _value = 0, pos = 0, min, max, speed;
  bool endless = false;
  late ActorAnimation actor;

  Anim(this.name, this.min, this.max, this.speed, this.endless);

  double get value => _value * (max - min) + min;

  set value(double v) => _value = (v - min) / (max - min);
}

class AniControl extends FlareControls {
  List<Anim> items;

  AniControl(this.items);

  @override
  bool advance(FlutterActorArtboard board, double elapsed) {
    super.advance(board, elapsed);
    for (var a in items) {
      if (a.actor == null) continue;
      var d = (a.pos - a._value).abs();
      var m = a.pos > a._value ? -1 : 1;
      if (a.endless && d > 0.5) {
        m = -m;
        d = 1.0 - d;
      }
      var e = elapsed / a.actor.duration * (1 + d * a.speed);
      a.pos = e < d ? (a.pos + e * m) : a._value;
      if (a.endless) a.pos %= 1.0;
      a.actor.apply(a.actor.duration * a.pos, board, 1.0);
    }
    return true;
  }

  @override
  void initialize(FlutterActorArtboard board) {
    super.initialize(board);
    for (var a in items) {
      a.actor = board.getAnimation(a.name)!;
    }
    // items.forEach((a) => a.actor = board.getAnimation(a.name)!);
  }

  operator [](String name) {
    for (var a in items) if (a.name == name) return a;
  }
}

class connect{
  Location location = Location();
  late LocationData _currentPosition;

 /*Future<Map> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Map map;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
     map={'error':'con_not'};
        return map;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        map={'error':'pre_not'};
        return map;
      }
    }
    _currentPosition = await location.getLocation();
     map={'latitude':_currentPosition.latitude!,'longitude':_currentPosition.longitude};
    return map;
  }*/
  Future<Map> getLoction() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Map map;
    if(prefs.containsKey('lat')){
    final double counter = prefs.getDouble('lat')!;
    if(counter<=0)
    {
      print("ccc");
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          map={'error':'con_not'};
          return map;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          map={'error':'pre_not'};
          return map;
        }
      }
      _currentPosition = await location.getLocation();
      map={'latitude':_currentPosition.latitude!,'longitude':_currentPosition.longitude};
      prefs.setDouble("lat", _currentPosition.latitude!);
      prefs.setDouble("lon", _currentPosition.longitude!);


    }
    else{
      print("0000");
      map={'latitude':prefs.getDouble('lat')!,'longitude':prefs.getDouble('lon')!};
    }}
    else{
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          map={'error':'con_not'};
          return map;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          map={'error':'pre_not'};
          return map;
        }
      }
      _currentPosition = await location.getLocation();
      map={'latitude':_currentPosition.latitude!,'longitude':_currentPosition.longitude};
      prefs.setDouble("lat", _currentPosition.latitude!);
      prefs.setDouble("lon", _currentPosition.longitude!);
      print("c55");
    }
    return map;
  }

}