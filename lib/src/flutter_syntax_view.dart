import 'package:flutter/material.dart';
import 'dart:math' as math; // math.max & max

import 'syntax/index.dart';

class SyntaxView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SyntaxView({
    required this.code,
    required this.syntax,
    this.syntaxTheme,
    this.minWidth = 100,
    this.minHeight = 100,
    this.withZoom = true,
    this.withLinesCount = true,
    this.adjutableHeight = false,
    this.fontSize = 12.0,
  });

  /// Code text
  final String code;

  /// Syntax/Langauge (Dart, C, C++...)
  final Syntax syntax;

  /// Enable/Disable zooming controlls (default: true)
  final bool withZoom;

  /// Enable/Disable line number in left (default: true)
  final bool withLinesCount;

  /// Theme of syntax view example SyntaxTheme.dracula() (default: SyntaxTheme.dracula())
  final SyntaxTheme? syntaxTheme;

  /// Font Size with a default value of 12.0
  final double fontSize;

  /// Min width of the syntax view
  final double? minWidth;

  /// Min height of the syntax view
  final double? minHeight;

  /// Adjust the height to the font-size and rows

  final bool adjutableHeight;

  @override
  State<StatefulWidget> createState() => SyntaxViewState();
}

class SyntaxViewState extends State<SyntaxView> {
  /// For Zooming Controls
  // ignore: constant_identifier_names
  static const double MAX_FONT_SCALE_FACTOR = 3.0;
  // ignore: constant_identifier_names
  static const double MIN_FONT_SCALE_FACTOR = 0.5;
  double _fontScaleFactor = 1.0;

  double getCustomHeight(int numLines, BuildContext context, String text) {
    double height = 1.0;

    final double textScale = MediaQuery.of(context).textScaleFactor;

    final TextPainter textPainter = TextPainter(
        textScaleFactor: textScale,
        text: TextSpan(text: text),
        textDirection: TextDirection.ltr);

    height = textPainter.size.height * numLines;

    return height;
  }

  @override
  Widget build(BuildContext context) {
    final int numLines = '\n'.allMatches(widget.code).length + 1;
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: <Widget>[
      Container(
        constraints: widget.minWidth != 100
            ? BoxConstraints(
                minWidth: widget.minWidth as double,
                minHeight: widget.minHeight as double)
            : widget.adjutableHeight
                ? BoxConstraints(
                    minHeight: getCustomHeight(numLines, context, widget.code))
                : null,
        padding: widget.withLinesCount
            ? const EdgeInsets.only(left: 5, top: 10, right: 10, bottom: 10)
            : const EdgeInsets.all(10),
        color: widget.syntaxTheme!.backgroundColor,
        child: Scrollbar(
            child: SingleChildScrollView(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: widget.withLinesCount
                        ? buildCodeWithLinesCount() // Syntax view with line number to the left
                        : buildCode() // Syntax view
                    ))),
      ),
      if (widget.withZoom) zoomControls() // Zoom controll icons
    ]);
  }

  Widget buildCodeWithLinesCount() {
    final int numLines = '\n'.allMatches(widget.code).length + 1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 1; i <= numLines; i++)
                RichText(
                    textScaleFactor: _fontScaleFactor,
                    text: TextSpan(
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: widget.fontSize,
                          color: widget.syntaxTheme!.linesCountColor),
                      text: "$i",
                    )),
            ]),
        const VerticalDivider(width: 5),
        buildCode(),
      ],
    );
  }

  // Code text
  Widget buildCode() {
    return RichText(
        textScaleFactor: _fontScaleFactor,
        text: /* formatted text */ TextSpan(
          style: TextStyle(fontFamily: 'monospace', fontSize: widget.fontSize),
          children: <TextSpan>[
            getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
          ],
        ));
  }

  Widget zoomControls() {
    return Row(
      children: <Widget>[
        IconButton(
            icon:
                Icon(Icons.zoom_out, color: widget.syntaxTheme!.zoomIconColor),
            onPressed: () => setState(() {
                  _fontScaleFactor =
                      math.max(MIN_FONT_SCALE_FACTOR, _fontScaleFactor - 0.1);
                })),
        IconButton(
            icon: Icon(Icons.zoom_in, color: widget.syntaxTheme!.zoomIconColor),
            onPressed: () => setState(() {
                  _fontScaleFactor =
                      math.min(MAX_FONT_SCALE_FACTOR, _fontScaleFactor + 0.1);
                })),
      ],
    );
  }
}
