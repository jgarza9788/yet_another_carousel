# yet_another_carousel
 
![gif](misc/20191020204855.gif)


## Parameter
```dart
  //this is the list of widgets that will be rendered
  List<Widget> children;

  //this is the curve that will be used for positioning
  Curve positionCurve;

  //this is the curve that will be used for scaling the widgets
  Curve scaleCurve;

  //this is the curve that will be used while transitioning out of screen (left side)
  Curve outCurve;

  //this is the color of the background
  Color backgroundColor;

  //if the widgets will fade out
  bool fadeOut;
  
  //if the widgets will scale out
  bool scaleOut;
  
  //if the carousel will roll to the nearest widget after drag
  bool rollToNearest;
  
  //the width of the carousel
  double width;
  
  //the height of the carousel
  double height;
  
  //the width of the widgets (anything under 1 will be treated as a ratio)
  double widgetWidth;

  //the height of the widgets (anything under 1 will be treated as a ratio)
  double widgetHeight;
  
  //this will scale the widget horizontally
  double widthFactor;
  
  //this can shift the widget on the x axis
  double xPosition;
  
  //this is the offset of the carousel on the right hand side
  Offset tailOfLineOffset;
  
  //this is the offset of the carousel on the left hand side
  Offset headOfLineOffset;
  
  //the widget will scroll to this index after change.
  int scrollTo;
```


## Example

```dart
Carousel(
    children: theseIcons,
    positionCurve: Curves.easeOut,
    scaleCurve: Curves.easeOut,
    fadeOut: true,
    scaleOut: true,
    widthFactor: 2.0,
    scrollTo: wIndex,
),
```