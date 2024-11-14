import 'package:flutter/material.dart';

class MyDeliveries extends StatelessWidget {
  const MyDeliveries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries'),
      ),
      body: const Center(
        child: const Text('Welcome to the My Deliveries Screen'),
      ),
    );
  }
}
