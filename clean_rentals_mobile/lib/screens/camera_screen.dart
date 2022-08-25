import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = '/camera-screen';

  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
