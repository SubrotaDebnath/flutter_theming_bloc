import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_theming_bloc/item_list.dart';
import 'package:flutter_theming_bloc/logic/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Brightness brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness;
  late String theme;

 _getUserDefineTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme = prefs.getString('theme') ?? '';
  }

  _setUserDefineTheme(theme)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('counter', theme);
  }

  _getBrightness(){
    _getUserDefineTheme().then((_)  {
      if(theme == ''){
        print('System Default Brightness : ${brightness.toString()} ');
      }else{

      }
    });
  }

  @override
  void initState() {
   _getBrightness();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: Builder(
          builder: (BuildContext context) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Flutter theming Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: MyHomePage(title: 'Flutter Theming Demo'),
                );
              },
            );
          }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi, This is\nSubrota Debnath',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            Text(
              'Select a theme',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            Container(
              height: 220,
              child: ListView.builder(
                itemCount: ItemList().themes.length,
                itemBuilder: (context, index) {
                  return BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {

                        },
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 8),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: true,
                                  onChanged: (v) {},
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ItemList().themes[index],
                                    style:
                                    Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),

                                // Visibility(
                                //   visible: index == state.status.index,
                                //   child: Icon(
                                //     Icons.check,
                                //     color: Colors.green,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
