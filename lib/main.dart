import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blueGrey,
                height: 100.0,
              ),
            ),
            Carousel(
              widgetList: theseIcons,
            ),
            Expanded(
              child: Container(
                color: Colors.red[900],
                height: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> theseIcons = [
Container(
  height: 50.0,
  width: 50.0,
  decoration: BD(color:Colors.red),
),
  Container(
    height: 50.0,
    width: 50.0,
    decoration: BD(color:Colors.orange),
  ),
  Container(
    height: 50.0,
    width: 50.0,
    decoration: BD(color:Colors.yellow),
  ),
  Container(
    height: 50.0,
    width: 50.0,
    decoration: BD(color:Colors.lightGreen),
  ),
  Container(
    height: 50.0,
    width: 50.0,
    decoration: BD(color:Colors.green),
  ),
  Container(
    height: 50.0,
    width: 50.0,
    decoration: BD(color:Colors.teal),
  ),
  Container(
    height: 50.0,
    width: 50.0,
    decoration: BD(color:Colors.blue),
  ),
];


BoxDecoration BD({color}){
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      new BoxShadow(
        color: Colors.black,
        offset: new Offset(5.0, 5.0),
        blurRadius: 10.0,
      )
    ],
  );
}

class Carousel extends StatefulWidget {
  Carousel({
    this.widgetList
});

  List<Widget> widgetList;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  double shift = 0.0;

  List<Widget> rebuildWidgetList()
  {
    List<Widget> finalWidgetList = [];

//    for (int i = 0; i < widget.widgetList.length ;i++)
    for (int i = widget.widgetList.length - 1; i >= 0; i-- )
    {
      double ratio = i/widget.widgetList.length;
      double negRatio = 1 - ratio;

      print(i);

      ratio = ratio + shift;

//      int w = widget.widgetList.length - i -1 ;
//      print(w);

      finalWidgetList.add(
        Positioned(
          left: ratio * 250.0 + 50.0 ,
//          left: (ratio * (0.5 - (ratio * 0.1))) * MediaQuery.of(context).size.width + 50.0,
          child: Container(
            height: 100.0 * negRatio,
            width: 100.0 * negRatio,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: widget.widgetList[i],
            ),
          ),
        )
      );
    }

    return finalWidgetList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rebuildWidgetList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (value){
        setState(() {
          shift += value.delta.dx/MediaQuery.of(context).size.width;
        });
        print('hello');
      },
      child: Container(
        height: 250.0,
        width: double.infinity,
        color: Colors.grey[900],
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: rebuildWidgetList(),
//        children: theseIcons,
          ),
      ),
    );
  }
}

