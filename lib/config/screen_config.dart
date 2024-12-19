import 'package:flutter/material.dart';

Size getSize(context) {
  return MediaQuery.sizeOf(context);
}

pushReplaceScreen(context, widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

pushScreen(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
