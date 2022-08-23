import 'package:clean_rentals_mobile/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddLocationScreen extends StatefulWidget {
  static const routeName = '/add-location';

  const AddLocationScreen({Key? key}) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Location"),
      ),
      drawer: const AppDrawer(),
    );
  }
}
