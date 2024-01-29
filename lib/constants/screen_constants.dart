import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return (displaySize(context).height)/10;
}

double displayWidth(BuildContext context) {
  return (displaySize(context).width)/10;
}

