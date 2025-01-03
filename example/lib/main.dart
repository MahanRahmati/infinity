import 'package:flutter/material.dart';
import 'package:infinity/infinity.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      theme: InfinityTheme.light(),
      darkTheme: InfinityTheme.dark(),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: IBoundedBox(
        child: Column(
          children: <Widget>[
            ICard(
              child: Text('Test Card Widget'),
            ),
          ],
        ),
      ),
    );
  }
}
