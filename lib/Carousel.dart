import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yet_another_carousel/main.dart';
import 'friction_simulation.dart';

class Carousel extends StatefulWidget {
  Carousel({
    @required this.children,
    this.positionCurve = Curves.linear,
    this.scaleCurve = Curves.linear,
    this.outCurve = Curves.linear,
    this.fadeOut = false,
    this.scaleOut = false,
  });

  List<Widget> children;
  Curve positionCurve;
  Curve scaleCurve;
  Curve outCurve;
  bool fadeOut;
  bool scaleOut;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with SingleTickerProviderStateMixin{

  GlobalKey _key = GlobalKey();

  double _shift = 0.0;
  double _velocity = 0.0;
  int _dragEndTime = 0;

  AnimationController _controller;

  List<Widget> wList = [];

  double lastWidgetPosition = 0.0;
  List<Widget> refresh()
  {
    List<Widget> finalWidgetList = [];

    if (_size == Size.zero)
    {
      return finalWidgetList;
    }

    var params = [];

    for(int i = 0; i < widget.children.length;i++)
    {
      double r = i/widget.children.length ;
//      double rawPos = ratio * _sizeWithExtra.width + _shift;
      double ratio = (r + _shift)%1.0;
//      double pos = ratio * _sizeWithExtra.width;

      params.add(
          {
            "index":i,
            "ratio":ratio,
          }
          );
    }

    params.sort( (a,b) =>  a["ratio"] < b["ratio"] ? 1:0  );
//    print(params);
//    print('\n');

    for (int i = 0; i < params.length;i++)
    {
//      print(params[i]);

      double lastAnim = widget.outCurve.transform(params[i]["ratio"]) * 25.0;
      lastAnim = lastAnim.clamp(0.0, 1.0);

      double pos = widget.positionCurve.transform(params[i]["ratio"]);
      pos = ((pos * 1.0) - 0.0) - (1-lastAnim);

      double scale  = 1 - widget.scaleCurve.transform(params[i]["ratio"]);
      scale = 1 - params[i]["ratio"];
      scale = widget.scaleOut ? scale * lastAnim : scale;

      double posY = 2.0 - (scale * 2.0);
      double opacity = widget.fadeOut ? lastAnim: 1.0;

      finalWidgetList.add(
        Align(
          alignment: Alignment(
            pos,
            0.0
          ),
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: widget.children[params[i]["index"]],
//                Container(
//                  child: Column(
//                    children: <Widget>[
//                      Text(
//                        '${params[i]["index"]}:::${params[i]["ratio"].toStringAsFixed(2)}',
//                        textAlign: TextAlign.left,
//                        style: TextStyle(color: Colors.white),),
//                      widget.children[params[i]["index"]],
//                    ],
//                  ),
//                ),
              ),
            ),
          ),
        ),
      );

    }

    return finalWidgetList;
  }

  Size _size = Size.zero;
  _getSize(){
    RenderBox RB = _key.currentContext.findRenderObject();
    _size = RB.size;

  }


    @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();


    _shift = (5/-theseIcons.length) + 0.025;
//    shift = (itemOffset/theseIcons.length) * -2;
    refresh();

    _controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );


//    int lastTime = 0;

    _controller.addListener((){
      setState(() {

//        print('last update time == ${DateTime.now().millisecond - lastTime}');
//        lastTime = DateTime.now().millisecond;

        print(_controller.value);
////        print(Curves.easeIn.transform(1- _controller.value));

//        double d = Curves.decelerate.flipped.transform(1-  _controller.value);
//        d = pow(d,4);
//        print(d);
//        _shift += _velocity * d ;

          int t = DateTime.now().millisecondsSinceEpoch - _dragEndTime;
          _shift += _velocity * pow(0.99,t);


      });
    });
  }
  _afterLayout(_) {
    _getSize();
    refresh();
  }


  @override
  Widget build(BuildContext context) {

    refresh();
//    wList = rebuildWidgetList();

    return GestureDetector(
      onHorizontalDragUpdate: (value){
        setState(() {

//          _prevDelta = value.primaryDelta/_size.width;
          _shift += value.primaryDelta/_size.width;
//          _shift = _shift.clamp(-1.0, 1.0);
//          _shift = _shift.clamp(-1.0, 1.0);

//          print(_shift);
        });
      },
//      onTap: (){prevDelta=0.0;},
//      onHorizontalDragStart: (value){prevDelta=0.0;},
      onHorizontalDragEnd: (value){

        _dragEndTime = DateTime.now().millisecondsSinceEpoch;
        _velocity = value.primaryVelocity/1000;
        print('_velocity ${_velocity}');

        _controller.duration = Duration(milliseconds: (value.primaryVelocity).abs().round());
        _controller.forward(from: 0.0);


      },
      child: Container(
        key: _key,
        height: 250.0,
        width: double.infinity,
        color: Colors.grey[900],
          child: Stack(
            overflow: Overflow.clip,
            alignment: AlignmentDirectional.centerStart,
            children: refresh(),
//        children: theseIcons,
          ),
      ),
    );
  }
}


