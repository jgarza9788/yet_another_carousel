import 'dart:math';

import 'package:flutter/material.dart';


class Carousel extends StatefulWidget {
  Carousel({this.widgetList});

  List<Widget> widgetList;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  GlobalKey _key = GlobalKey();

  double _shift = 0.0;
  double _prevDelta = 0.0;


  double lastWidgetPosition = 0.0;
  List<Widget> rebuildWidgetList()
  {
    List<Widget> finalWidgetList = [];

    double prevRawPos = 100.0;


    for (int i = 0; i < widget.widgetList.length ;i++)
//    for (int i = widget.widgetList.length - 1; i >= 0; i-- )
    {

      double ratio = (i/widget.widgetList.length) ;
      double negRatio = 1.0-ratio;
      double xRatio = ratio -0.5;

//      ratio -= 0.5;
//      print('ratio $ratio');

//      print('_size ${_sizeWithExtra.width}');

//      double hwRatio = Curves.easeOutCirc.transform(negRatio);
////      double hwRatio = sin((negRatio * (pi/2)) + (pi/4));
//      hwRatio = pow(hwRatio, 10);
//      hwRatio = hwRatio.clamp(0.0, double.infinity);


      double ox = (xRatio * _sizeWithExtra.width + _shift )%_sizeWithExtra.width;
      ox -= _sizeWithExtra.width/2.0;

      double posX = 0.0;
      double rawPos = ratio * _sizeWithExtra.width + _shift;
      posX = rawPos%_sizeWithExtra.width;
//      print(posX);
//      print(_size.width);
//      print(posX/_size.width);
//      posX = posX%_sizeWithExtra.width;
//      print(posX);

//      print(
//          'i $i\nratio $ratio\nnegRatio $negRatio\nxRatio $xRatio\nox $ox\n_shift $_shift\nposX $posX\n'
//      );

      int insertAt = lastWidgetPosition > posX  ? finalWidgetList.length : 0 ;

//      if (insertAt != 0)
//        {
          print(
              'i $i\nratio $ratio\nnegRatio $negRatio\nxRatio $xRatio\nox $ox\n_shift $_shift\nposX $posX\n'
          );
//        }

      if (i == widget.widgetList.length - 1)
        {
          lastWidgetPosition = posX;
        }

      finalWidgetList.insert(
        0,
        Transform.translate(
          offset: Offset(
              posX,
              0.0
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child:
            Container(
              child: Column(
                children: <Widget>[
                  Text('$i\n${(posX * 100).round()/100}',style: TextStyle(color: Colors.white),),
                  widget.widgetList[i],
                ],
              ),
            ),
          ),
        ),
      );

//      finalWidgetList.add(
//        Transform.translate(
//          offset: Offset(
////              ox,
////              ratio * _size.width + _shift,
////              ratio * _size.width,
//              posX,
//              0.0
//          ),
//          child: FittedBox(
//            fit: BoxFit.fitWidth,
//            child: widget.widgetList[i],
//          ),
////          child: Container(
//////            height: _size.width * 0.5 * ox.abs() ,
//////            width: _size.width * 0.5 * ox.abs() ,
//////            height: _size.width * negRatio  *  0.5,
//////            width: _size.width * negRatio * 0.5,
////            height: 100.0,
////            width: 100.0,
////            child: widget.widgetList[i],
////          ),
//        ),
//      );


    }

//    print(finalWidgetList);
    return finalWidgetList;
  }

  Size _size = Size.zero;
  Size _sizeWithExtra = Size.zero;
  _getSize(){
    RenderBox RB = _key.currentContext.findRenderObject();
    _size = RB.size;

//    double w = _size.width * widget.widgetList.length * 0.5 * (( ( 0.5/2 ) + 0.5) * 2);
//    double w = _size.width * widget.widgetList.length * (( 0.0/2 ) + 0.5) ;
//    double w = 100.0 * widget.widgetList.length + (0.5 * 100.0 * widget.widgetList.length);//* (( 0.0/2 ) + 0.75) ;

    double unitSize = _size.width * 0.5;
    double gap = 0.0;
//    double w = _size.height * widget.widgetList.length + (0.5 * _size.height * widget.widgetList.length);//* (( 0.0/2 ) + 0.75) ;
    double w = unitSize * widget.widgetList.length + (gap * widget.widgetList.length);

    _sizeWithExtra = Size(w, _size.height);
    _sizeWithExtra = _size;
  }


    @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();

//    shift = (itemOffset/theseIcons.length) * -2;
    rebuildWidgetList();

//    _controller = AnimationController(
//      duration: Duration(milliseconds: 500),
//      vsync: this,
//    );

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
  }
  _afterLayout(_) {
    _getSize();
//    rebuildWidgetList();
  }


  @override
  Widget build(BuildContext context) {

    rebuildWidgetList();

    return GestureDetector(
      onHorizontalDragUpdate: (value){
        setState(() {

          _prevDelta = value.primaryDelta;
          _shift += _prevDelta;
//          _shift = _shift.clamp(-1.0, 1.0);

          print(_shift);
        });
      },
//      onTap: (){prevDelta=0.0;},
//      onHorizontalDragStart: (value){prevDelta=0.0;},
//      onHorizontalDragEnd: (value){
//        print('prevDelta $prevDelta');
//        _controller.duration = Duration(milliseconds: (prevDelta*100000).abs().round());
//        _controller.forward(from: 0.0);
//      },
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


