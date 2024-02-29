import 'package:flutter/material.dart';
import 'package:login/pages/home.dart';
import 'next.dart';

class pro extends StatefulWidget {
  const pro({super.key});

  @override
  State<pro> createState() => _proState();
}

class _proState extends State<pro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Homepage()
      ],),
    );
  }
}