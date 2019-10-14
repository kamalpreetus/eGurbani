import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Model/Shabad/ICompleteShabad.dart';
import 'package:flutter2/Model/Shabad/ShabadFinder.dart';
import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';
import 'package:flutter2/Model/Shabad/TranslationSource.dart';

class ShabadPageView extends StatefulWidget {

  String shabadID;
  ShabadPageView(this.shabadID);

  @override
  State createState() => new ShabadList();
}
class ShabadList extends State<ShabadPageView> {
  @override
  Widget build (BuildContext ctxt) {

    ShabadFinder shabadFinder = new ShabadFinder();
    Future<ICompleteShabad> shabadLines = shabadFinder.generateShabadLine(this.widget.shabadID);

    return Scaffold (
      appBar: AppBar(
          title: Text("Shabad")
      ),

      body: FutureBuilder(
          future: shabadLines,
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            bool santSinghEnglishExists = false;
            if (snapshot.data.shabadLines[0].translationsMap.containsKey(TranslationSource.SANT_SINGH_ENGLISH)) {
              santSinghEnglishExists = true;
            }

            bool profSahibSinghExists = false;
            if (snapshot.data.shabadLines[0].translationsMap.containsKey(TranslationSource.PROF_SAHIB_SINGH_PUNJABI)) {
              profSahibSinghExists = true;
            }

            bool fareedkotExists = false;
            if (snapshot.data.shabadLines[0].translationsMap.containsKey(TranslationSource.FAREEDKOT_PUNJABI)) {
              fareedkotExists = true;
            }

            print("rebuilding SSSS ");
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.arrow_back_ios, size: 50),
                  trailing: InkWell(
                    child: Icon(Icons.arrow_forward_ios, size: 50),
                    onTap: () => {
                      // move to next shabad
                      // get the order id, get the shabad, update the listview
                      print("next clicked")
                    })
                ),
                
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.shabadLines.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => ShabadPageView(/* shabadId */ snapshot.data.shabadLines[index].orderID + 1)));
                        },
                        title: Text(snapshot.data.shabadLines[index].gurmukhiShabad,
                            style: TextStyle(fontFamily: 'OpenGurbaniAkharBlack', fontSize: 20.0, wordSpacing: -7)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            (santSinghEnglishExists) ? Text(snapshot.data.shabadLines[index].translationsMap[TranslationSource.SANT_SINGH_ENGLISH]) : Text("noo") ,
                            (profSahibSinghExists) ? Text(snapshot.data.shabadLines[index].translationsMap[TranslationSource.PROF_SAHIB_SINGH_PUNJABI]) : Text("noo") ,
                            (fareedkotExists) ? Text(snapshot.data.shabadLines[index].translationsMap[TranslationSource.FAREEDKOT_PUNJABI]) : Text("noo") ,
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}