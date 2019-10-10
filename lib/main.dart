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
GestureDetector(
  onTap: (){
    print('Red');
  },
  child:   Container(
    height: 50.0,
    width: 50.0,
    decoration: BD(color:Colors.red),
  ),
),
  GestureDetector(
    onTap: (){
      print('Orange');
    },
    child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BD(color:Colors.orange),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Yellow');
    },
    child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BD(color:Colors.yellow),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('lightGreen');
    },
    child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BD(color:Colors.lightGreen),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Green');
    },
    child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BD(color:Colors.green),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Teal');
    },
    child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BD(color:Colors.teal),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Blue');
    },
    child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BD(color:Colors.blue),
    ),
  ),
//  Container(),
//  Container(height: 50.0,width: 50.0,),
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
//  double width = 0.0;
  Size size = Size(1.0, 1.0);
  double itemOffset = 5.0;
  GlobalKey _key = GlobalKey();

  List<Widget> rebuildWidgetList()
  {
    List<Widget> finalWidgetList = [];

    for (int i = 0; i < widget.widgetList.length ;i++)
//    for (int i = widget.widgetList.length - 1; i >= 0; i-- )
    {
      double ratio = i/widget.widgetList.length;
      ratio *= itemOffset;
      double negRatio = 1 - ratio;

//      print(i);

//      ratio = ratio + shift;

//      int w = widget.widgetList.length - i -1 ;
//      print(w);

//      double RS = (ratio+shift)%1.0;
      double RS = (ratio+shift).clamp(0.0, 1.0);
      double p = Curves.decelerate.transform(RS);

//      double nRS = (shift)%1.0;
      double s = 1- Curves.decelerate.flipped.transform(RS);
      s = 1- Curves.decelerate.flipped.transform(RS);
//      s = s.clamp(0.0,double.infinity) ;


      finalWidgetList.add(
        Positioned(
//          left: ratio * 250.0 + 50.0 ,
//          left: (ratio * (0.5 - (ratio * 0.1))) * MediaQuery.of(context).size.width + 50.0,
//        left:  p * (size.width + 50) + (100.0 * ratio) + 10.0,
        left:  p * (size.width + 50 ) + (size.width * 0.10 - (0.50 * widget.widgetList.length)) + (size.width * 0.10 * (1/widget.widgetList.length) * ratio) ,
          child: Container(
            height: size.height * 0.80 * s ,
            width: size.width * 0.80 * s ,
//            child: FittedBox(
//              fit: BoxFit.fitHeight,
              child: widget.widgetList[i],
//            ),
          ),
        )
      );
    }

    return finalWidgetList;
  }


  _getSize(){
    RenderBox RB = _key.currentContext.findRenderObject();
    size = RB.size;

//    print(size);
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();

    rebuildWidgetList();

  }
  _afterLayout(_) {
    _getSize();
  }

  @override
  Widget build(BuildContext context) {

    rebuildWidgetList();

    return GestureDetector(
      onHorizontalDragUpdate: (value){
        setState(() {

          shift += value.delta.dx/size.width;
          shift = shift.clamp(-1.0 * itemOffset,1.0 * itemOffset);

          print(shift);
        });
      },
      child: Container(
        key: _key,
        height: 250.0,
        width: double.infinity,
        color: Colors.grey[900],
          child: Stack(
            overflow: Overflow.clip,
            alignment: AlignmentDirectional.centerStart,
            children: rebuildWidgetList(),
//        children: theseIcons,
          ),
      ),
    );
  }
}

