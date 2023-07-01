import 'package:flutter/material.dart';
import 'package:nowfood/manager/fonts_manager.dart';
import 'package:nowfood/manager/values_manager.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return     Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: SizeManager.imageSize,
                  width: SizeManager.imageSize,
                  fit: BoxFit.scaleDown,
                ),
              );
  }
}