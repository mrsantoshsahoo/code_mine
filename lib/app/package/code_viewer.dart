import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:highlight/languages/dart.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
class CodeViewer extends StatefulWidget {
  const CodeViewer({super.key});

  @override
  State<CodeViewer> createState() => _CodeViewerState();
}

class _CodeViewerState extends State<CodeViewer> {
  @override
  void initState() {
    _controller = TextEditingController(text: quote);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _lineScrollController.dispose();
    super.dispose();
  }

  late TextEditingController _controller;
  final ScrollController _lineScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lineCount = _controller.text.split('\n').length;

    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            // controller: _scrollController,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Line Numbers
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 2),
                  child: SizedBox(
                    width: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _lineScrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lineCount,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // TextField
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorHeight: 18,
                    style: const TextStyle(fontSize: 18),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (text) {
                      // Update UI on text change
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            child: IconButton(
              onPressed: () {
                const snackBar = SnackBar(
                  content: Text('Copied to Clipboard'),
                );
                Clipboard.setData(ClipboardData(text: quote));
                // .then((v)=>  ScaffoldMessenger.of(context).showSnackBar(snackBar));
              },
              icon: const Icon(Icons.copy_all),
            ),
          ),
          // Vertical Divider (Dynamic Height)
          const Padding(
            padding: EdgeInsets.only(left: 40),
            child: VerticalDivider(),
          ),
        ],
      ),
    );
  }

  String quote = '''import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/java.dart';

void main() {
  runApp(const CodeEditor());
}

final controller = CodeController(
  text: '...', // Initial code
  language: java,
);

class CodeEditor extends StatelessWidget {
  const CodeEditor();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CodeTheme(
          data: CodeThemeData(styles: monokaiSublimeTheme),
          child: SingleChildScrollView(
            child: CodeField(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}''';
}

/// new 1
// import 'package:flutter/material.dart';
//
// class CodeViewer extends StatefulWidget {
//   const CodeViewer({super.key});
//
//   @override
//   State<CodeViewer> createState() => _CodeViewerState();
// }
//
// class _CodeViewerState extends State<CodeViewer> {
//   final TextEditingController _controller = TextEditingController(text: '''
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_editor/flutter_code_editor.dart';
// import 'package:flutter_highlight/themes/monokai-sublime.dart';
// import 'package:highlight/languages/java.dart';
// ''');
//
//   final ScrollController _scrollController = ScrollController();
//   final ScrollController _lineScrollController = ScrollController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     _lineScrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final lineCount = _controller.text.split('\n').length;
//
//     return
//       Scaffold(
//       backgroundColor: const Color(0xFF2D2A55), // VS Code-like background
//       body: SingleChildScrollView(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Line Numbers
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 2),
//               child: SizedBox(
//                 width: 40,
//                 child: ListView.builder(
//                   controller: _lineScrollController,
//                   itemCount: lineCount,
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 1),
//                       child: Text(
//                         "${index + 1}",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.white60,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//
//             // Code Editor with Overlaid Widgets
//             Expanded(
//               child: Stack(
//                 children: [
//                   // Highlighted RichText
//                   _buildHighlightedTextField(_controller.text),
//
//                   // TextField for editing
//                   TextField(
//                     controller: _controller,
//                     keyboardType: TextInputType.multiline,
//                     maxLines: null,
//                     cursorHeight: 18,
//                     style: const TextStyle(
//                       fontSize: 18, // Match font size
//                       color: Colors.white, // Invisible text
//                     ),
//                     cursorColor: Colors.white,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                       ),
//                       isDense: true,
//                       contentPadding: EdgeInsets.zero,
//                     ),
//                     onChanged: (text) {
//                       setState(() {}); // Refresh syntax highlighting
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHighlightedTextField(String text) {
//     final List<Widget> lineWidgets = [];
//     final RegExp syntaxRegex = RegExp(
//       r'''('.*?'|\".*?\"|\b(import|void|class|final|return|if|else|package)\b|\d+|\/\/.*)''',
//     );
//
//     final linesText = text.split('\n');
//     final lineCount = linesText.length;
//
//     for (int lineIndex = 0; lineIndex < lineCount; lineIndex++) {
//       final String lineText = linesText[lineIndex];
//       String highlightedLine = lineText;
//
//       // Process line text for basic syntax highlighting
//       for (final match in syntaxRegex.allMatches(lineText)) {
//         final String matchedText = match.group(0)!;
//         String colorTag;
//
//         if (matchedText.startsWith('//')) {
//           colorTag = '[GREEN]';
//         } else if (matchedText.startsWith("'") || matchedText.startsWith('"')) {
//           colorTag = '[ORANGE]';
//         } else if (RegExp(r'\b(import|void|class|final|return|if|else|package)\b').hasMatch(matchedText)) {
//           colorTag = '[BLUE]';
//         } else if (RegExp(r'\d+').hasMatch(matchedText)) {
//           colorTag = '[PURPLE]';
//         } else {
//           colorTag = '[WHITE]';
//         }
//
//         // Replace the matched text with tagged version
//         highlightedLine = highlightedLine.replaceFirst(
//           matchedText,
//           '$colorTag$matchedText[/]',
//         );
//       }
//
//       // Replace tags with plain-text equivalents (no colors in TextField)
//       highlightedLine = highlightedLine.replaceAll(RegExp(r'\[(.*?)\]'), '');
//
//       // Add each line as a separate widget with dynamic padding
//       lineWidgets.add(
//         TextField(
//           controller: TextEditingController(text: highlightedLine),
//           readOnly: true, // Makes it non-editable
//           style: const TextStyle(
//             fontSize: 18,
//             color: Colors.white,
//           ),
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: EdgeInsets.zero,
//             isDense: true,
//           ),
//         ),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: lineWidgets,
//     );
//   }
//
// }

List<String> keyWards = [
  "abstract",
  "as",
  "assert",
  "async",
  "await",
  "break",
  "case",
  "catch",
  "class",
  "const",
  "continue",
  "covariant",
  "default",
  "deferred",
  "do",
  "else",
  "enum",
  "export",
  "extends",
  "extension",
  "external",
  "factory",
  "false",
  "final",
  "finally",
  "for",
  "function",
  "get",
  "if",
  "implements",
  "import",
  "in",
  "inject",
  "interface",
  "is",
  "library",
  "mixin",
  "new",
  "null",
  "on",
  "operator",
  "out",
  "part",
  "rethrow",
  "return",
  "set",
  "show",
  "static",
  "super",
  "switch",
  "sync",
  "this",
  "throw",
  "true",
  "try",
  "typedef",
  "var",
  "void",
  "while",
  "with",
  "yield"
];

/// new

// class RichTextControllerDemo extends StatefulWidget {
//   const RichTextControllerDemo({super.key});
//
//   @override
//   State<RichTextControllerDemo> createState() => _RichTextControllerDemoState();
// }
//
// class _RichTextControllerDemoState extends State<RichTextControllerDemo> {
// // Add a controller
//   late RichTextController _controller;
//
//
//   @override
//   void initState() {
//     _controller = RichTextController(
//         targetMatches: [
//           ...keyWards.map(
//                 (e) => MatchTargetItem(
//               text: e,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.orange.shade700,
//               ),
//               allowInlineMatching: true,
//             ),
//           ),
//           MatchTargetItem(
//             regex: RegExp(r'''["\'](.*?)["\']'''), // Match text inside quotes
//             style: TextStyle(color: Colors.green, fontSize: 18),
//             allowInlineMatching: true,
//           ),
//           MatchTargetItem(
//             regex: RegExp(r'\b[A-Z][a-zA-Z]*\b'), // Match capitalized words
//             style: TextStyle(color: Colors.blue, fontSize: 18),
//             allowInlineMatching: true,
//           ),
//           MatchTargetItem(
//             regex: RegExp(r'^//.*$'), // Match comments starting with `//`
//             style: TextStyle(color: Colors.grey, fontSize: 18),
//             allowInlineMatching: true,
//           ),
//           MatchTargetItem(
//             regex: RegExp(r'^///.*$'), // Match comments starting with `///`
//             style: TextStyle(color: Colors.yellow, fontSize: 18),
//             allowInlineMatching: true,
//           ),
//         ],
//         onMatch: (List<String> matches) {},
//         text: '''
// import 'package:flutter/material.dart';
// import 'package:rich_text_controller/rich_text_controller.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'RichText Controller Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RichTextControllerDemo(),
//     );
//   }
// }
//
// class RichTextControllerDemo extends StatefulWidget {
//   @override
//   _RichTextControllerDemoState createState() => _RichTextControllerDemoState();
// }
//
// class _RichTextControllerDemoState extends State<RichTextControllerDemo> {
//
// // Add a controller
// RichTextController _controller;
//
//   @override
//   void initState() {
//       // initialize with your custom regex patterns or Strings and styles
//       //* Starting V1.2.0 You also have "text" parameter in default constructor !
//       _controller = RichTextController(
//             targetMatches: [
//       MatchTargetItem(
//         text: 'coco',
//         style: TextStyle(
//           color: Colors.blue,
//           backgroundColor: Colors.green,
//         ),
//         allowInlineMatching: true,
//       ),
//       MatchTargetItem(
//         regex: RegExp(r"\B![a-zA-Z0-9]+\b"),
//         style: TextStyle(
//           color: Colors.yellow,
//           fontStyle: FontStyle.italic,
//         ),
//         allowInlineMatching: true,
//       ),
//     ],
//          //* starting v1.1.0
//          //* Now you have an onMatch callback that gives you access to a List<String>
//          //* which contains all matched strings
//          onMatch: (List<String> matches){
//            // Do something with matches.
//            //! P.S
//            // as long as you're typing, the controller will keep updating the list.
//          }
//          deleteOnBack: true,
//          // You can control the [RegExp] options used:
//          regExpUnicode: true,
//
//       );
//     super.initState();
//   }
// }
// ''');
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final regExp = RegExp(r'^//.*$');
//     print(regExp.hasMatch('// Another comment'));  // Should print true
//     print(regExp.hasMatch('Not a comment'));
//     return Scaffold(
//       backgroundColor: const Color(0xFF2D2A55), // VS Code-like background
//       body: SingleChildScrollView(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 40,
//               child: ListView.builder(
//                 // controller: _lineScrollController,
//                 itemCount: _controller.text.split('\n').length,
//                 // padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 1),
//                     child: Text(
//                       "${index + 1}",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.white60,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 scrollPadding: EdgeInsets.zero,
//                 controller: _controller,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 cursorHeight: 18,
//                 style: const TextStyle(
//                   fontSize: 18, // Match font size
//                   color: Colors.white, // Invisible text
//                 ),
//                 cursorColor: Colors.white,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                   ),
//                   isDense: true,
//                   contentPadding: EdgeInsets.zero,
//                 ),
//                 onChanged: (text) {
//                   setState(() {}); // Refresh syntax highlighting
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
