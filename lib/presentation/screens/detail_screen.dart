import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết thời tiết')),
      body: const Center(child: Text('Chi tiết thời tiết sẽ hiển thị ở đây')),
    );
  }
}