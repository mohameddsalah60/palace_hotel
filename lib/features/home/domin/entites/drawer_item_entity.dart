import 'package:flutter/material.dart';

class DrawerItemEntity {
  final String title;
  final IconData icon;
  Widget? page;
  DrawerItemEntity({required this.title, required this.icon, this.page});
}
