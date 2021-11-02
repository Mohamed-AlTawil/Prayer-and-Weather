import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'My_Provider.dart';
import 'main.dart';
import 'package:provider/provider.dart';

class SettingApp extends StatefulWidget {
  const SettingApp({Key? key}) : super(key: key);

  @override
  _SettingAppState createState() => _SettingAppState();
}

class _SettingAppState extends State<SettingApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List _lang = ['عربي', 'English', 'Turkish'];
  List _namelang = ['لغة التطبيق', 'Application Language', 'Uygulama Dili'];
  String _selectnamelang='لغة التطبيق';
  String _selectlang="عربي";
  int payname=0;
  Future<void> _setlango(String lango) async {
   final SharedPreferences prefs = await _prefs;
    final int lang=_lang.indexOf(lango);

    setState(() {
       prefs.setInt("lang1", lang);
       _selectnamelang=_namelang[lang];
    });
  }
  Future<void> _getlango() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = prefs.getInt('lang1')!;
    //final int lang=_lang.indexOf(lango);
    setState(() {
      _selectlang=_lang[counter];
      _selectnamelang=_namelang[counter];
    });
  }

  @override
  void initState() {
    super.initState();
    _getlango();
  }

  @override
  Widget build(BuildContext context) {
    final wh=MediaQuery.of(context);
    return Container(
      child: Column(
        children: [
          Container(height: 200),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: wh.size.width*0.075,),
                Expanded(child : Text('$_selectnamelang:',textAlign:TextAlign.center,style: TextStyle(fontSize:15),)),
                Expanded(child :DropdownButton(
                  hint: Text('select'),isExpanded: true,value: _selectlang,items: _lang.map((e) {
                  return DropdownMenuItem(child: Text(e),value: e,);
                }).toList(),
                  onChanged: (newvalue){
                    setState(() {
                      _selectlang=newvalue.toString();
                      _setlango(newvalue.toString());
                      Provider.of<MyProvider>(context,listen: false).getlango();
                    });
                  },)),
                SizedBox(width: wh.size.width*0.075,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
