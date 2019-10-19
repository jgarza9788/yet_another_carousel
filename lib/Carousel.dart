import 'dart:math';

import 'package:flutter/material.dart';


class Carousel extends StatefulWidget {
  Carousel({
    @required this.children,
    this.positionCurve = Curves.linear,
    this.scaleCurve = Curves.linear,
    this.outCurve = Curves.linear,
    this.backgroundColor = Colors.grey,
    this.fadeOut = false,
    this.scaleOut = false,
    this.rollToNearest =  true,
    this.width = double.infinity,
    this.height = 250.0,
    this.widgetWidth = 150.0,
    this.widgetHeight = 150.0,
    this.widthFactor = 1.0,
    this.xPosition = 0.0,
    this.tailOfLineOffset = const Offset(0.0, 0.0),
    this.headOfLineOffset = const Offset(-1.0, -1.0),
    this.scrollTo = 0,
  });

  List<Widget> children;
  Curve positionCurve;
  Curve scaleCurve;
  Curve outCurve;
  Color backgroundColor;
  Size widgetSize;
  bool fadeOut;
  bool scaleOut;
  bool rollToNearest;
  double width;
  double height;
  double widgetWidth;
  double widgetHeight;
  double widthFactor;
  double xPosition;
  Offset tailOfLineOffset;
  Offset headOfLineOffset;
  int scrollTo;


  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with SingleTickerProviderStateMixin{

  GlobalKey _key = GlobalKey();

  double _shift = 0.0;
  int _scrollTo = 0;

  double _velocity = 0.0;
  int _dragEndTime = 0;

  AnimationController _controller;

  List<Widget> wList = [];

  states state = states.idle;


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
      _scrollValue = ratio;
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
//    print(params[0]);

    if (state != states.rollToNearest)
      {
        _activeWidgetIndex = params[params.length-1]['index'] ;

//        print(params[params.length-1]);
//        print(params[params.length-2]);
//
//        if (params[params.length-1]['ratio'] > 0.009)
//          {
//            _activeWidgetIndex = params[params.length-2]['index'] ;
//          }
      }

//    print(state);
//    print(_activeWidgetIndex);

    for (int i = 0; i < params.length;i++)
    {
//      print(params[i]);


      double r =  params[i]["ratio"];

      double rightEnd = widget.outCurve.transform(r) * 25.0;
      rightEnd = rightEnd.clamp(0.0, 1.0);

      double leftEnd = 1.0 - (widget.outCurve.transform(r) * 25);
      leftEnd = leftEnd.clamp(0.0, 1.0);

//      print(leftEnd);

      double pos = widget.positionCurve.transform(r);
      pos = ((pos * widget.widthFactor) - widget.xPosition) - (1-rightEnd) ;
      pos += widget.tailOfLineOffset.dx  - ( (1-r) * widget.tailOfLineOffset.dx);

      pos += ( (widget.headOfLineOffset.dx + 1.0) * leftEnd);
      double scale  = 1 - widget.scaleCurve.transform(r);
      scale = widget.scaleOut ? scale * (leftEnd + 1.0) : scale;

      double maxWidth = widget.widgetWidth <= 1.0 ? (_size.width * widget.widgetWidth) : widget.widgetWidth;
      double maxHeight = widget.widgetHeight <= 1.0 ? (_size.height * widget.widgetHeight) : widget.widgetHeight;


      double posY = widget.tailOfLineOffset.dy  - ( (1-r) * widget.tailOfLineOffset.dy);
      posY += ( (widget.headOfLineOffset.dy + 1.0) * (leftEnd + 1.0));
      double opacity = widget.fadeOut ? rightEnd: 1.0;


      finalWidgetList.add(
        Align(
          alignment: Alignment(
            pos,
            posY
          ),
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  height: maxHeight,
                  width: maxWidth,
                  child: widget.children[params[i]["index"]],
                ),
//                child: widget.children[params[i]["index"]],
              ),
            ),
          ),
        ),
      );

    }

//    finalWidgetList.add(
//      Align(
//        alignment: Alignment(
//          0.0,0.90
//        ),
//        child: Container(
//            height: 10.0,
//            width: _size.width * 0.80,
//            decoration: BoxDecoration(
//              color: Colors.blueGrey[900],
//              borderRadius: BorderRadius.circular(5.0),
//              boxShadow: [
//                new BoxShadow(
//                  color: Colors.black.withOpacity(0.50),
//                  offset: new Offset(2.5, 2.5),
//                  blurRadius: 10.0,
//                )
//              ],
//            ),
//            child: Stack(
//              overflow: Overflow.visible,
//              children: <Widget>[
//                Align(
//                  alignment: Alignment
//                    (
//                      (_scrollValue * 2.0) - 1.0
//                      ,0.0
//                  ),
//                  child: Container(
//                    height: 10.0,
//                    width: 50.0,
//                    decoration: BoxDecoration(
//                      color: Colors.green[900],
//                      borderRadius: BorderRadius.circular(5.0),
//                      boxShadow: [
//                        new BoxShadow(
//                          color: Colors.black.withOpacity(0.50),
//                          offset: new Offset(2.5, 2.5),
//                          blurRadius: 10.0,
//                        )
//                      ],
//                    ),
////                    child:
//                  ),
//                ),
//                Align(
//                  alignment: Alignment(
//                      (_scrollValue * 2.0) - 1.0
//                      ,0
//                  ),
//                  child: Text(
//                    '${(_scrollValue).toStringAsFixed(5)}',
//                    style: TextStyle(color: Colors.lightGreenAccent,fontSize: 10.0),
//                    softWrap: true,
//                  ),
//                ),
//              ],
//            ),
//          ),
//      )
//    );


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


    refresh();

    _controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );

    _controller.addStatusListener((status){
      print(status);
      //moves between forwards and back

      if(status == AnimationStatus.completed)
      {
        print(state);
        if (state == states.drag)
          {
            state = states.dragEnd;
            _startRollToNearest();
          }
        else if (state == states.dragEnd)
          {
            _startRollToNearest();
          }
        else if (state != states.idle)
          {
            state = states.idle;
          }
      }

    });

    _controller.addListener((){
      print(state);
      setState(() {
//        print(_controller.value);

        if (state == states.idle)
          {
            //do nothing
          }
        else if (state == states.dragEnd)
          {
            _afterDrag();
          }
        else if (state == states.rollToNearest)
          {
            _rollToNearest();
          }
        else if (state == states.scrollTo)
          {
            _autoScroll();
          }


      });
    });
  }
  _afterLayout(_) {
    _getSize();
    refresh();
  }

  _afterDrag(){
//    print(_controller.value);
    int t = DateTime.now().millisecondsSinceEpoch - _dragEndTime;
    double addVel = _velocity * pow(0.99,t);
    _shift += addVel;

    print(addVel);
    if (addVel.abs() < 0.00001)
      {
        _startRollToNearest();
      }
  }

//  bool _isAutoScrolling = false;
  _autoScroll(){
//    print('_isAutoScrolling $_isAutoScrolling');
//    if (_isAutoScrolling)
//     {
       double nShift  = (_scrollTo/-widget.children.length) + 0.04;
       _shift = _shift + (nShift - _shift) * _controller.value;
//     }
//    print('_autoScrollTo $_scrollTo');
  }

  _startRollToNearest(){
    if (widget.rollToNearest)
    {
      state = states.rollToNearest;

      _shift = (((_shift + 1.0) % 2.0) -1.0);
//      _shift = 5.0;
//      _shift = _shift % 1.0;
//      print('_shift $_shift');

      _controller.stop(canceled: true);
      _controller.duration = Duration(milliseconds: 1000);
      _controller.forward(from: 0.0);

    }
  }


  _rollToNearest() {

    double nShift  = (_activeWidgetIndex/-widget.children.length) + 0.04;
    double dShift = (nShift-_shift);

    if (dShift.abs() > 0.95)
    {
      dShift += dShift.sign * -1.0;
    }

//    _shift = _shift + (nShift-_shift) *  _controller.value  ;
    double t = Curves.easeInOut.transform(_controller.value);
    _shift = _shift + dShift *  t  ;

  }


  @override
  Widget build(BuildContext context) {

    refresh();

    if (widget.scrollTo != _scrollTo  )
    {
      state = states.scrollTo;

      _scrollTo = widget.scrollTo;
      _controller.duration = Duration(milliseconds: 1000);
      _controller.forward(from: 0.0);

    }

    return GestureDetector(
      onHorizontalDragUpdate: (value){

        state = states.drag;

        setState(() {
          _shift += value.primaryDelta/_size.width;
        });

      },
      onHorizontalDragEnd: (value) {

        state = states.dragEnd;

        _dragEndTime = DateTime.now().millisecondsSinceEpoch;
        _velocity = value.primaryVelocity/1000;

        _controller.duration = Duration(milliseconds: (value.primaryVelocity).abs().round());
        _controller.forward(from: 0.0);

      },
      child: Container(
        key: _key,
        height: widget.height,
        width: widget.width,
        color: widget.backgroundColor,
        child: Stack(
          overflow: Overflow.clip,
          alignment: AlignmentDirectional.centerStart,
          children: refresh(),
        ),
      ),
    );
  }
}

double _scrollValue = 0.0;
double getScrollValue(){
  return _scrollValue;
}

int _activeWidgetIndex = 0;
int getActiveWidgetIndex(){
  return _activeWidgetIndex;
}

enum states{
  idle,
  drag,
  dragEnd,
  scrollTo,
  rollToNearest,
}
