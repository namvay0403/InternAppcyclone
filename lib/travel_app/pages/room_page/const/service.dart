import 'package:flutter/material.dart';

class ServiceData{
  String name;
  IconData icon;
  ServiceData({required this.name, required this.icon});
}

class Services {
  static ServiceData serviceData(String serviceName) {

      if (serviceName == 'FREE_WIFI') return ServiceData(name: 'Free \nWifi', icon: Icons.wifi);
      if (serviceName == 'NON_REFUNDABLE') return ServiceData(name: 'Non \nRefundable', icon: Icons.local_parking);
      if (serviceName == 'FREE_BREAKFAST') return ServiceData(name: 'Free \nBreakfast', icon: Icons.free_breakfast);
      if (serviceName == 'NON_SMOKING') return ServiceData(name: 'Non \nSmoking', icon: Icons.smoke_free);
      if (serviceName == 'ROOM_SERVICE') return ServiceData(name: 'Room \nService', icon: Icons.room_service);
      return ServiceData(name: '', icon: Icons.error);
  }
}
