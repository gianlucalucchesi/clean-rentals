import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class AddCarScreen extends StatefulWidget {
  static const routeName = '/add-car';

  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Car"),
      ),
      drawer: const AppDrawer(),
    );
  }
}
