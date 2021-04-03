import 'package:approved_foods/foodDetails.dart';
import 'package:approved_foods/serviceManager.dart';
import 'package:flutter/material.dart';
import 'package:approved_foods/foodDetailsBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Approved Food'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FoodDetailsBloc foodDetailsBloc;
  @override
  void initState() {
    super.initState();
    foodDetailsBloc = FoodDetailsBloc();//initializing bloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: InkWell(
          onTap: () {
            foodDetailsBloc.fnGetFoodList();
            showModelBottomSheet();
          },
          child: Card(
            elevation: 50,
            shadowColor: Colors.black,
            // color: Colors.greenAccent[100],
            child: SizedBox(
              width: 200,
              height: 200,
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0)),
                  image: new DecorationImage(
                    image: new AssetImage("images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'View Approved food List',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_outlined) //Text
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showModelBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return StatefulBuilder(builder: (scaffoldKey, StateSetter setState) {
            return FoodDetails(foodDetailsBloc);
          });
        });
  }
}
