import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../models/language.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'package:speech_recognition/speech_recognition.dart';



class HomePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  double _minimumMargin = 5.0;
  Language _firstLang = Language('en', 'English');
  Language _secondLang = Language('gu', 'Gujarati');
  String _translatedText = '';
  GoogleTranslator _translator = new GoogleTranslator();
  var _langName = ['Automatic','Afrikaans','Albanian','Amharic','Arabic','Armenian','Azerbaijani','Basque','Belarusian','Bengali','Bosnian', 'Bulgarian', 'Catalan', 'Cebuano', 'Chichewa', 'Chinese Simplified', 'Chinese Traditional', 'Corsican', 'Croatian', 'Czech', 'Danish', 'Dutch', 'English', 'Esperanto', 'Estonian', 'Filipino', 'Finnish', 'French', 'Frisian', 'Galician', 'Georgian', 'German', 'Greek', 'Gujarati', 'Haitian Creole', 'Hausa', 'Hawaiian', 'Hebrew', 'Hindi', 'Hmong', 'Hungarian', 'Icelandic', 'Igbo', 'Indonesian', 'Irish', 'Italian', 'Japanese', 'Javanese', 'Kannada', 'Kazakh',	'Khmer', 'Korean', 'Kurdish (Kurmanji)', 'Kyrgyz', 'Lao', 'Latin', 'Latvian', 'Lithuanian', 'Luxembourgish', 'Macedonian', 'Malagasy', 'Malay', 'Malayalam', 'Maltese', 'Maori', 'Marathi', 'Mongolian','Myanmar (Burmese)', 'Nepali', 'Norwegian', 'Pashto', 'Persian', 'Polish', 'Portuguese', 'Punjabi', 'Romanian', 'Russian', 'Samoan', 'Scots Gaelic', 'Serbian', 'Sesotho', 'Shona', 'Sindhi', 'Sinhala', 'Slovak', 'Slovenian', 'Somali', 'Spanish', 'Sundanese', 'Swahili', 'Swedish', 'Tajik', 'Tamil', 'Telugu', 'Thai', 'Turkish', 'Ukrainian', 'Urdu', 'Uzbek','Vietnamese', 'Welsh', 'Xhosa', 'Yiddish', 'Yoruba', 'Zulu'];
  bool isCameraPressed = false;

  //image
  File pickedImage;
  bool isImageLoaded = false;
  String final1 = "";
  String final2 = "";

  //speech
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";
  bool isMicPressed = false;


  final List<Language> _languageList = [
    Language('auto', 'Automatic'),
    Language('af', 'Afrikaans'),
    Language('sq', 'Albanian'),
    Language('am', 'Amharic'),
    Language('ar', 'Arabic'),
    Language('hy', 'Armenian'),
    Language('az', 'Azerbaijani'),
    Language('eu', 'Basque'),
    Language('be', 'Belarusian'),
    Language('bn', 'Bengali'),
    Language('bs', 'Bosnian'),
    Language('bg', 'Bulgarian'),
    Language('ca', 'Catalan'),
    Language('ceb', 'Cebuano'),
    Language('ny', 'Chichewa'),
    Language('zh-cn', 'Chinese Simplified'),
    Language('zh-tw', 'Chinese Traditional'),
    Language('co', 'Corsican'),
    Language('hr', 'Croatian'),
    Language('cs', 'Czech'),
    Language('da', 'Danish'),
    Language('nl', 'Dutch'),
    Language('en', 'English'),
    Language('eo', 'Esperanto'),
    Language('et', 'Estonian'),
    Language('tl', 'Filipino'),
    Language('fi', 'Finnish'),
    Language('fr', 'French'),
    Language('fy', 'Frisian'),
    Language('gl', 'Galician'),
    Language('ka', 'Georgian'),
    Language('de', 'German'),
    Language('el', 'Greek'),
    Language('gu', 'Gujarati'),
    Language('ht', 'Haitian Creole'),
    Language('ha', 'Hausa'),
    Language('haw', 'Hawaiian'),
    Language('iw', 'Hebrew'),
    Language('hi', 'Hindi'),
    Language('hmn', 'Hmong'),
    Language('hu', 'Hungarian'),
    Language('is', 'Icelandic'),
    Language('ig', 'Igbo'),
    Language('id', 'Indonesian'),
    Language('ga', 'Irish'),
    Language('it', 'Italian'),
    Language('ja', 'Japanese'),
    Language('jw', 'Javanese'),
    Language('kn', 'Kannada'),
    Language('kk', 'Kazakh'),
    Language('km', 'Khmer'),
    Language('ko', 'Korean'),
    Language('ku', 'Kurdish (Kurmanji)'),
    Language('ky', 'Kyrgyz'),
    Language('lo', 'Lao'),
    Language('la', 'Latin'),
    Language('lv', 'Latvian'),
    Language('lt', 'Lithuanian'),
    Language('lb', 'Luxembourgish'),
    Language('mk', 'Macedonian'),
    Language('mg', 'Malagasy'),
    Language('ms', 'Malay'),
    Language('ml', 'Malayalam'),
    Language('mt', 'Maltese'),
    Language('mi', 'Maori'),
    Language('mr', 'Marathi'),
    Language('mn', 'Mongolian'),
    Language('my', 'Myanmar (Burmese)'),
    Language('ne', 'Nepali'),
    Language('no', 'Norwegian'),
    Language('ps', 'Pashto'),
    Language('fa', 'Persian'),
    Language('pl', 'Polish'),
    Language('pt', 'Portuguese'),
    Language('ma', 'Punjabi'),
    Language('ro', 'Romanian'),
    Language('ru', 'Russian'),
    Language('sm', 'Samoan'),
    Language('gd', 'Scots Gaelic'),
    Language('sr', 'Serbian'),
    Language('st', 'Sesotho'),
    Language('sn', 'Shona'),
    Language('sd', 'Sindhi'),
    Language('si', 'Sinhala'),
    Language('sk', 'Slovak'),
    Language('sl', 'Slovenian'),
    Language('so', 'Somali'),
    Language('es', 'Spanish'),
    Language('su', 'Sundanese'),
    Language('sw', 'Swahili'),
    Language('sv', 'Swedish'),
    Language('tg', 'Tajik'),
    Language('ta', 'Tamil'),
    Language('te', 'Telugu'),
    Language('th', 'Thai'),
    Language('tr', 'Turkish'),
    Language('uk', 'Ukrainian'),
    Language('ur', 'Urdu'),
    Language('uz', 'Uzbek'),
    Language('vi', 'Vietnamese'),
    Language('cy', 'Welsh'),
    Language('xh', 'Xhosa'),
    Language('yi', 'Yiddish'),
    Language('yo', 'Yoruba'),
    Language('zu', 'Zulu'),
  ];

  @override
  void initState(){
    super.initState();
    initSpeechRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Translator"), //text
        ), //appbar
        body: Container(
            margin: EdgeInsets.all(_minimumMargin),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(child: Center(child: getList1()), width: 150,),
                    Expanded(
                      child: FlatButton(
                        child: Icon(Icons.swap_horiz),
                        onPressed: (){
                          setState(() {
                            Language temp = _firstLang;
                            _firstLang = _secondLang;
                            _secondLang = temp;
                          });
                        },
                      ), //container

                    ), //expanded
                    Container(child: Center(child: getList2()), width: 150,)
                  ], //<widget for row 1>
                ), //row 1
                Padding(
                  padding: EdgeInsets.all(_minimumMargin),
                  child: TextField(
                    decoration:
                    InputDecoration(labelText: "EnterText"), //inDeco
                    style: TextStyle(
                      height: 2.5,
                    ), //style
                    onChanged: (String input) {
                      if(input !=''){
                      setState(() {
                        _translator
                            .translate(input,
                            from: _firstLang.code, to: _secondLang.code)
                            .then((translatedText) {
                          this.setState(() {
                            this._translatedText = translatedText;
                          });
                        });
                      });}
                      else{
                        _translatedText = "";
                      }
                    },
                  ), //textfield
                ), //padding
                Padding(
                      padding: EdgeInsets.all(_minimumMargin*2),
                      child: Container(
                          child: Center(
                              child: Text(resultText),
                            ),
                          ),
                      ),
                Row(
                  children: <Widget>[
                    Expanded(child:RaisedButton(
                      color: Colors.indigoAccent,
                      child: Icon(Icons.camera),
                        onPressed: () {
                          pickImage();
                          setState(() {
                           isCameraPressed = true;
                          });
                        }

                    ),),//expanded
                    Container(width: _minimumMargin),
                    Expanded(child:RaisedButton(
                        color: Colors.indigoAccent,
                      child: Icon(Icons.mic),
                      onPressed: (){
                        if(_isAvailable && !_isListening)
                          _speechRecognition
                              .listen(locale: "en_US")
                              .then((result) => print('$result'));
                        isMicPressed = true;

                       }
                    ),),

                  ],
                ),
                isCameraPressed ? Container(
                  width: 25.0,
                  child:     cameraApply(),
                ) : Container(),
                isMicPressed ? Container(
                  width: 25.0,
                  child:     micApply(),
                ) : Container(),
                Center(
                      child: Text(
                        _translatedText,
                        style: TextStyle(fontSize: 25),
                      ),
                    )
              ], //Widget for List
            ) //ListView
        ) //container
    ); //scaffold
  }

  //list
  Widget getList1() {
    var dd = DropdownButton<String>(
      isExpanded: true,
      items: _langName.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val),
        );
      }).toList(), //map
      value: _firstLang.name,
      onChanged: (String newVal) {
        setState(() {
          int x=_langName.indexOf(newVal);
          _firstLang = _languageList.elementAt(x);
        });
      },
    ); //dropdown
    return dd;
  }

  Widget getList2() {
    var dd = DropdownButton<String>(
      isExpanded: true,
      items: _langName.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val),
        );
      },).toList(), //map
      value: _secondLang.name,
      onChanged: (String newVal) {
        setState(() {
          int x=_langName.indexOf(newVal);
          _secondLang = _languageList.elementAt(x);
        });
      },
    ); //dropdown
    return dd;
  }

  //image
  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future<VisionText> readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    return readText;
  }

  Widget cameraApply(){
    return RaisedButton(
      child: Text("Translate"),
      onPressed: (){
        readText().then((data) {
          for (TextBlock block in data.blocks) {
            for (TextLine line in block.lines) {
              for (TextElement word in line.elements) {
                print(word.text);
                setState(() {
                  final1 += word.text+' ';
                });
              }
            }
          }
          if(final1 !=''){
          _translator.translate(final1,
            from: 'auto',
            to: _secondLang.code,
          ).then((t){
            this.setState((){
              this._translatedText = t;
            });
          }
          );
          resultText=final1;
          }else
            resultText='No text Found';
          isCameraPressed = false;
        });
      }
    );
  }

  //speech
  void initSpeechRecognizer(){
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

  Widget micApply()
  {
    return RaisedButton(
      child: Text("Translate"),
      onPressed: (){
    if(resultText!=""){
    _translator
        .translate(resultText,
    from: 'auto',
    to: _secondLang.code)
        .then((translatedText) {
    this.setState(() {
    this._translatedText = translatedText;
    });
    });
    }
    setState(() {
      isMicPressed = false;

    });
      },
    );
  }
}