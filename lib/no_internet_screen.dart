import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'connectivity_provider.dart';

class ConnectivityCheckScreen extends StatefulWidget {
  const ConnectivityCheckScreen({Key? key}) : super(key: key);

  @override
  State<ConnectivityCheckScreen> createState() =>
      _ConnectivityCheckScreenState();
}

class _ConnectivityCheckScreenState extends State<ConnectivityCheckScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConnectivityProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('No Internet'),
            ElevatedButton(
                onPressed: () {
                  if (provider.isOnline) {
                    Navigator.pop(context);
                  }
                },
                child: Text('Retry'))
          ],
        ),
      ),
    );
  }
}
