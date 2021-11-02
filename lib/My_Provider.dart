import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider with ChangeNotifier
{
  List <String> namePayAr=['الفجر','شروق الشمس','الظهر','العصر','المغرب','العشاء','باقي لأذان','باقي لشروق الشمس'];
  List <String> namePayEN=['Fajer','Sunrise','Dhuhr','Asr','Maghrib','Isha','The rest of azan','The rest of the sunrise'];
  List <String> namePayTR=['Fajer','Gün Doğumu','Öğlen','Asr','Maghrib','Isha','ezanının geri kalanı','Güneşin geri kalanı'];
  List<String> _tapbarAr = [
    'القبلة',
    'الأذان',
    'الطقس',
    'الإعدادات',
    'الموقع',
    'أوقات الصلاة',
    'الطقس',
    'أعدادات'
  ];
  List<String> _tabbarEng = [
    'Qiblah',
    'Azan',
    'Weather',
    'Settings',
    'Location',
    'Prayer Time',
    'Weather',
    'Settings'
  ];
  List<String> _tabbarTur = [
    'Öpücük',
    'Ezan',
    'Hava',
    'Ayarlar',
    'Sitesi',
    'Namaz Vakitleri',
    'Hava',
    'Ayarlar'
  ];
  late TextDirection _textDirectionRTl= TextDirection.rtl;
  late TextDirection _textDirectionLTR=TextDirection.ltr ;
  late TextDirection textDirection=TextDirection.ltr  ;
  late List<String> tabbar=_tapbarAr;
  late List<String> payname=namePayAr;
  int selectTap = 0;
  int selectscreen = 0;
  bool azan=false;


  Future<void> getlango() async {
    print("get");
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if(prefs.containsKey('lang1')){
      final int counter = prefs.getInt('lang1')!;
      if(counter==1){
        payname=namePayEN;
        tabbar=_tabbarEng;
        textDirection=_textDirectionLTR;
      }
      else if(counter==2){
        tabbar=_tabbarTur;
        payname=namePayTR;
        textDirection=_textDirectionLTR;
      }
      else{
        tabbar = _tapbarAr;
        payname=namePayAr;
        textDirection=_textDirectionRTl;
      }
    }
    else{
      tabbar = _tapbarAr;
      payname=namePayAr;
      textDirection=_textDirectionRTl;
    }
      notifyListeners();
  }

  void x(int index) {
    print('$index');
    selectTap = index;

    notifyListeners();
  }
  void des(DismissDirection direction,int s){
    selectscreen = s;
    selectscreen +=
    direction == DismissDirection.endToStart ? 1 : -1;
    if (selectscreen < 0) {
      selectscreen = 3;
      selectTap = 3;
    } else if (selectscreen > 3) {
      selectscreen = 0;
      selectTap = 0;
    } else {
      selectTap = selectscreen;
    }
    print('$selectscreen: $s');
    notifyListeners();
  }
  void lan_dec(){

  }

  void azazplay(bool az){
    azan=az;
    notifyListeners();
  }
}