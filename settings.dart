import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'locale/AppLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangValue{
  final String _key;
  final String _value;
  String _name;
  final String _subValue;
  LangValue(this._key,this._value,this._name, this._subValue,);
}
void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override 
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
   AppLocalizationDelegate _localeOverrideDelegate = AppLocalizationDelegate(Locale(_LanguagePageState()._currentLangValue.toString(), _LanguagePageState()._currentLangID.toString()));
  //pathing will access _LanguagePageState() which can call _currentLangValue and ID and convert to string
  @override 
  Widget build(BuildContext context){
     return new MaterialApp(localizationsDelegates:[ 
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      _localeOverrideDelegate
    ], supportedLocales: [
      //supported language options, must be according to the official language code
      const Locale('en', 'US'),
      const Locale('zh', 'CN'),
      const Locale('tl', 'TL'),
      const Locale('id', 'ID'),
      const Locale('ms', 'MS'),
    ],
    theme: ThemeData(primaryColor:  Colors.orange),
    home: _Settings()
    );
  }
}

class _Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<_Settings> {
  bool _light = false;
  bool _enable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Account Settings"),),
          ListTile(
            title: Text("Manage My Account"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40,),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("General Settings"),),
          ListTileSwitch(
            value: _light, 
            switchActiveColor: Colors.orange,
            onChanged: (bool value){
              setState(() {
                _light=value;
              });
            }, 
            title: Text("Dark Mode"),),
          ListTileSwitch(
            value: _enable, 
            onChanged: (bool value){
              setState(() {
                _enable = value;
              });
            }, 
            title: Text("Notifications"),
          ),
          ListTile(
            title: Text("Language"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40,),
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => LanguagePage()),);
            }
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("About"),),
          ListTile(
            title: Text("User Agreement"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40,),
          ),
          ListTile(
            title: Text("Privacy Policy"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40,),
            ),
          ListTile(
            title: Text("Content Policy"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40,),
          ),
          ListTile(
            title: Text("Acknowledgements"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40,),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Support"),
          ),
          ListTile(
            title: Text("Help FAQ"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40,),
          ),
          ListTile(
            title: Text("Report a Bug"),
            trailing: Icon(Icons.navigate_next_rounded, size: 40),
          ),
        ],
        ), 
      );
  }
}
class LanguagePage extends StatefulWidget{
  @override 
  State<StatefulWidget> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage>{
  String _currentLangValue; //the current language
  String _currentLangID;
  @override 
  void initState(){
    super.initState();
    _loadLang();
  }
  _loadLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLangValue = (prefs.getString('langvalue') ?? 'en');
      _currentLangID = (prefs.getString('langID') ?? 'US');
    });
  }
//receive values
  _saveLang(String val, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //save value , ?? is if null
      
      prefs.setString('langvalue', val);
     _currentLangValue = (prefs.getString('langvalue') ?? 'en');
      prefs.setString('langId', value);
      _currentLangID = (prefs.getString('langID') ?? 'US');
    });
  }

  @override 
  Widget build(BuildContext context){
    final _buttonOptions = [
      //'first variable matches locale variable', third variable should change according to language
    LangValue('zh', "CN", AppLocalization.of(context).langZH,'这是中文'),
    LangValue('en', "US", AppLocalization.of(context).langEN,'This is in English'),
    LangValue('id', "ID",AppLocalization.of(context).langID,'Ini dalam bahasa Indonesia'),
    LangValue('tl', 'TL',AppLocalization.of(context).langFP,'Nasa Tagalog ito'),
    LangValue('ms', "MS",AppLocalization.of(context).langMS,'Ini dalam bahasa Melayu'),
  ];// 
    return Scaffold(
      appBar: AppBar(
        //change page title according to language
        title: Text(AppLocalization.of(context).langSetting),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: _buttonOptions.map((langValue) => RadioListTile(
          groupValue: _currentLangValue,
          title: Text(langValue._name),
          subtitle: Text(langValue._subValue),
          value: langValue._key,
          //when u click on a tile the value will change according to what u tapped
          onChanged: (val){
            setState(() {
              _currentLangValue = val;
              AppLocalization.load(Locale(_currentLangValue, langValue._value));
              _saveLang(_currentLangValue, langValue._value);
              //pass the two changed values to _saveLang 
            },
          );
        },
      )).toList(),
      ),
    );
  }
}
