
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'My_Provider.dart';

class AzanPlay extends StatefulWidget {
  const AzanPlay({Key? key}) : super(key: key);

  @override
  _AzanPlayState createState() => _AzanPlayState();
}

class _AzanPlayState extends State<AzanPlay> {

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playRemoteFile();
  }
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }
  @override
  Widget build(BuildContext context) {
    final wh=MediaQuery.of(context);
    return  Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("imag/aksa.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child:Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(wh.size.width*0.07, 0, wh.size.width*0.07, 0),
          child: FlatButton(
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(
                color: Colors.green,
                width: 1,
              ),
            ),
            color: Colors.blue,
            splashColor: Colors.black,
            minWidth: double.infinity,
            onPressed: () {
              Provider.of<MyProvider>(context, listen: false).azazplay(false);
              audioPlayer.stop();
          },
            child: Text('ايقاف',style: TextStyle(fontSize: 20),),),
        ),
      ) /* add child content here */,
    );
  }
  void playRemoteFile() {
    audioPlayer.open(
      Audio('imag/azan.mp3'),
      autoStart: true,
      // showNotification: true
    );}
}
