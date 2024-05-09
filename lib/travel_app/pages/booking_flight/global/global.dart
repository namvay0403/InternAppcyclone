import 'package:flutter/material.dart';

enum FlightType { One_Way, Round_Trip, Multi_City }

class HelperPage extends ValueNotifier {

  HelperPage(super.value);

  void changeFlightType(FlightType e) {
    value = e;
  }
}
