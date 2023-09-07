import 'package:flutter/material.dart';

class ContainerExample extends StatelessWidget {
  const ContainerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(24),
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(0.1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          width: 8,
          color: Colors.purple,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            spreadRadius: 16,
            color: Colors.black54,
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffe16b5c),
            Color(0xfff39060),
            Color(0xffffb56b),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Text(
        'Hello, I am Container!',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.white),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(
          padding: EdgeInsets.only(
            top: 48,
            bottom: 24,
          ),
        ),
        child: Scaffold(
          body: ContainerExample(),
        ),
      ),
    );
  }
}
