import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String between(DateTime from, DateTime to) {
  String diff = "";
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  if (to.difference(from).inDays > 0 && to.difference(from).inDays <= 3) {
    diff = to.difference(from).inDays.toString() + "d ago";
  } else if (to.difference(from).inHours > 0 &&
      to.difference(from).inHours <= 60) {
    diff = to.difference(from).inHours.toString() + "h ago";
  } else if (to.difference(from).inMinutes > 0 &&
      to.difference(from).inMinutes <= 60) {
    diff = to.difference(from).inMinutes.toString() + "m ago";
  } else if (to.difference(from).inSeconds > 0 &&
      to.difference(from).inSeconds <= 60) {
    diff = to.difference(from).inSeconds.toString() + "s ago";
  } else {
    diff = DateFormat('MMMM d, yyyy').format(from);
  }
  return diff;
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
