import 'package:flutter/material.dart';
import 'package:flutter_syntax_view_fcc/src/flutter_syntax_view.dart';
import 'package:flutter_syntax_view_fcc/src/syntax/index.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      title: "Flutter Syntax View Example",
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static const String code = r"""
import 'dart:math' as math;

// Coffee class is the best!
class Coffee {
  late int _temperature;

  void heat() => _temperature = 100;
  void chill() => _temperature = -5;

  void sip() {
    final bool isTooHot = math.max(37, _temperature) > 37;
    if (isTooHot)
      print("myyy liiips!");
    else
      print("mmmmm refreshing!");
  }

  int? get temperature => temperature;
}
""";

  static final syntaxViews = {
    "Standard": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.standard(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
    ),
    "Dracula": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.dracula(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: false,
    ),
    "AyuLight": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.ayuLight(),
      fontSize: 12.0,
      withZoom: false,
      withLinesCount: true,
    ),
    "AyuDark": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.ayuDark(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: false,
    ),
    "GravityLight": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.gravityLight(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
    ),
    "GravityDark": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.gravityDark(),
      fontSize: 12.0,
      withZoom: false,
      withLinesCount: false,
    ),
    "MonokaiSublime": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.monokaiSublime(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
    ),
    "Obsidian": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.obsidian(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
    ),
    "OceanSunset": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.oceanSunset(),
      fontSize: 12.0,
      withZoom: false,
      withLinesCount: true,
    ),
    "vscodeDark": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.vscodeDark(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
    ),
    "vscodeLight": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.vscodeLight(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Syntax View Example"),
        backgroundColor: Colors.blueGrey[800],
        elevation: 6,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: syntaxViews.length,
          itemBuilder: (BuildContext context, int index) {
            String themeName = syntaxViews.keys.elementAt(index);
            SyntaxView syntaxView = syntaxViews.values.elementAt(index);
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 6.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.brush_sharp),
                        Text(
                          themeName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.brush_sharp),
                      ],
                    ),
                  ),
                  const Divider(),
                  syntaxView
                ],
              ),
            );
          }),
    );
  }
}
