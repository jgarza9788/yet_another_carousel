
import 'package:flutter/material.dart';
import 'Carousel.dart';

import 'friction_simulation.dart';


//void main() => runApp(SwipeDemoApp());
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  FrictionSimulation fs = FrictionSimulation(
    0.1,
    0.0,
    0.5,
  );


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

//    double t = 0.0;
//    while(t < 1.0)
//      {
//        print(fs.x(t));
//        t += 0.001;
//      }

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
    height: 100.0,
    width: 100.0,
    decoration: BD(color:Colors.red),
    child: Text('Red0', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
  ),
),
  GestureDetector(
    onTap: (){
      print('Orange');
    },
    child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BD(color:Colors.orange),
      child: Text('Orange1', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Yellow');
    },
    child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BD(color:Colors.yellow),
      child: Text('Yellow2', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('lightGreen');
    },
    child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BD(color:Colors.lightGreen),
      child: Text('LightGreen3', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Green');
    },
    child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BD(color:Colors.green),
      child: Text('Green4', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Teal');
    },
    child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BD(color:Colors.teal),
      child: Text('Teal5', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
    ),
  ),
  GestureDetector(
    onTap: (){
      print('Blue');
    },
    child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BD(color:Colors.blue),
      child: Text('Blue6', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
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
        color: Colors.black.withOpacity(0.25),
        offset: new Offset(2.5, 2.5),
        blurRadius: 20.0,
      )
    ],
  );
}

//class Carousel extends StatefulWidget {
//  Carousel({
//    this.widgetList
//});
//
//  List<Widget> widgetList;
//
//  @override
//  _CarouselState createState() => _CarouselState();
//}

//class _CarouselState extends State<Carousel> with SingleTickerProviderStateMixin {
//
//
//  double shift = 0.0;
////  double width = 0.0;
//  Size size = Size(1.0, 1.0);
//  double itemOffset = 4.0;
//  GlobalKey _key = GlobalKey();
//
//
//  List<Widget> rebuildWidgetList()
//  {
//    List<Widget> finalWidgetList = [];
//
//    for (int i = 0; i < widget.widgetList.length ;i++)
////    for (int i = widget.widgetList.length - 1; i >= 0; i-- )
//    {
//      double ratio = i/widget.widgetList.length;
//      ratio *= itemOffset;
//      double negRatio = 1 - ratio;
//
////      print(i);
//
////      ratio = ratio + shift;
//
////      int w = widget.widgetList.length - i -1 ;
////      print(w);
//
////      double RS = (ratio+shift)%1.0;
//      double RS = (ratio+shift).clamp(0.0, 1.0);
//      double p = Curves.decelerate.transform(RS);
//
////      double nRS = (shift)%1.0;
//      double s = 1- Curves.decelerate.flipped.transform(RS);
//      s = 1- Curves.decelerate.flipped.transform(RS);
////      s = s.clamp(0.0,double.infinity) ;
//
//
//      finalWidgetList.add(
//          Transform(
//            transform: Matrix4.rotationY(1-s)..
////              translate(p * size.width, p * size.height * 0.25)
//              translate(
//                  p * (size.width + 500) + (10.0 * ratio) - 500.0,
//                  p * size.height * 0.25)
//              ..scale(s),
//            child: Container(
//              height: size.height * 0.70 * s ,
//              width: size.width * 0.80 * s ,
////            child: FittedBox(
////              fit: BoxFit.fitHeight,
//                child: widget.widgetList[i],
////            ),
//            ),
//          ),
//      );
//
//
////      finalWidgetList.add(
////        Positioned(
//////          left: ratio * 250.0 + 50.0 ,
//////          left: (ratio * (0.5 - (ratio * 0.1))) * MediaQuery.of(context).size.width + 50.0,
//////        left:  p * (size.width + 50) + (100.0 * ratio) + 10.0,
////        left:  p * (size.width + 50 ) + (size.width * 0.10 - (0.50 * widget.widgetList.length)) + (size.width * 0.10 * (1/widget.widgetList.length) * ratio) ,
////          child: Container(
//////            height: size.height * 0.80 * s ,
//////            width: size.width * 0.80 * s ,
////////            child: FittedBox(
////////              fit: BoxFit.fitHeight,
//////              child: widget.widgetList[i],
////////            ),
////          ),
////        )
////      );
//    }
//
//    return finalWidgetList;
//  }
//
//
//  _getSize(){
//    RenderBox RB = _key.currentContext.findRenderObject();
//    size = RB.size;
//
////    print(size);
//  }
//
//  AnimationController _controller;
//  Animation<double> _contentAnimation;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
//    super.initState();
//
//    shift = (itemOffset/theseIcons.length) * -2;
//    rebuildWidgetList();
//
//    _controller = AnimationController(
//      duration: Duration(milliseconds: 500),
//      vsync: this,
//    );
//
//    _controller.addListener((){
//      setState(() {
////        print(_controller.value);
//
//        print(Curves.easeInOut.transform(1- _controller.value));
//        prevDelta = prevDelta * Curves.ease.transform(1- _controller.value);
//        shift += prevDelta;
//        print('prevDelta $prevDelta');
//
////        _onDragEnd();
////        print(animation.value);
//      });
//    });
//  }
//  _afterLayout(_) {
//    _getSize();
//  }
//
////  double _velocity = 0.0;
////  _onDragEnd(){
////    setState(() {
////      print(_velocity * 0.0005);
////      shift += Curves.ease.flipped.transform(controller.value) * 0.25 * _velocity.sign ;
////      shift = shift.clamp(-1.0 * itemOffset, 1.0);
//////      _velocity = _velocity * 0.90;
////      rebuildWidgetList();
////    });
////  }
//
//  double prevDelta = 0.0;
//
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    rebuildWidgetList();
//
//    return GestureDetector(
//      onHorizontalDragUpdate: (value){
//        setState(() {
//
//          prevDelta = value.primaryDelta/size.width;
//          shift += prevDelta;
//          shift = shift.clamp(-1.0 * itemOffset, 1.0);
//
//          print(shift);
//        });
//      },
//      onTap: (){prevDelta=0.0;},
//      onHorizontalDragStart: (value){prevDelta=0.0;},
//      onHorizontalDragEnd: (value){
//        print('prevDelta $prevDelta');
//        _controller.duration = Duration(milliseconds: (prevDelta*100000).abs().round());
//        _controller.forward(from: 0.0);
//      },
//      child: Container(
//        key: _key,
//        height: 250.0,
//        width: double.infinity,
//        color: Colors.grey[900],
//          child: Stack(
//            overflow: Overflow.clip,
//            alignment: AlignmentDirectional.center,
//            children: rebuildWidgetList(),
////        children: theseIcons,
//          ),
//      ),
//    );
//  }
//
//
//}

