import 'package:example/conts.dart';
import 'package:example/magic_item.dart';
import 'package:example/magic_wrap.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Animate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFD287F)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selAnimation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF17171E),
        body: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3947),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Positioned(
                    child: MagicWrap(
                      type: _selAnimation,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFD287F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.flutter_dash,
                            size: 50, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: magicList
                        .map((e) => MagicItem(
                            group: e,
                            onChange: (value) {
                              setState(() {
                                _selAnimation = value;
                              });
                            }))
                        .toList()),
              ),
            ))
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
