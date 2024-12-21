// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
//
// class RichWrapper extends StatefulWidget {
//   final String? initialText;
//   final List<MatchTargetItem> targetMatches;
//   final Function(List<String> match)? onMatch;
//   final Function(List<Map<String, List<int>>>)? onMatchIndex;
//   final bool? deleteOnBack;
//   final bool regExpCaseSensitive;
//   final bool regExpDotAll;
//   final bool regExpMultiLine;
//   final bool regExpUnicode;
//   final Widget Function(RichTextController controller) child;
//
//   const RichWrapper({
//     super.key,
//     this.initialText,
//     required this.targetMatches,
//     this.onMatch,
//     this.onMatchIndex,
//     this.regExpCaseSensitive = true,
//     this.regExpDotAll = false,
//     this.regExpMultiLine = false,
//     this.regExpUnicode = false,
//     this.deleteOnBack = false,
//     required this.child,
//   });
//
//   @override
//   State<RichWrapper> createState() => _RichWrapperState();
// }
//
// class _RichWrapperState extends State<RichWrapper> {
//   late RichTextController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = RichTextController(
//       text: widget.initialText,
//       targetMatches: widget.targetMatches,
//       onMatch: widget.onMatch ?? (x) {},
//       deleteOnBack: widget.deleteOnBack,
//       onMatchIndex: widget.onMatchIndex,
//       regExpCaseSensitive: widget.regExpCaseSensitive,
//       regExpDotAll: widget.regExpDotAll,
//       regExpMultiLine: widget.regExpMultiLine,
//       regExpUnicode: widget.regExpUnicode,
//     );
//   }
//
//   @override
//   void didUpdateWidget(covariant RichWrapper oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.targetMatches != widget.targetMatches) {
//       _controller.updateMatches(widget.targetMatches);
//     }
//     if (oldWidget.initialText != widget.initialText) {
//       _controller.text = widget.initialText ?? '';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child(_controller);
//   }
// }
//
// class RichTextController extends TextEditingController {
//   final List<MatchTargetItem> targetMatches;
//   final Function(List<String> match) onMatch;
//   final Function(List<Map<String, List<int>>>)? onMatchIndex;
//   final bool? deleteOnBack;
//   final bool regExpCaseSensitive;
//   final bool regExpDotAll;
//   final bool regExpMultiLine;
//   final bool regExpUnicode;
//
//   RegExp? _compiledRegex;
//
//   RichTextController({
//     super.text,
//     required this.targetMatches,
//     required this.onMatch,
//     this.onMatchIndex,
//     this.deleteOnBack = false,
//     this.regExpCaseSensitive = true,
//     this.regExpDotAll = false,
//     this.regExpMultiLine = false,
//     this.regExpUnicode = false,
//   }) {
//     _compileRegex();
//   }
//
//   // Method to compile regex just once and reuse it
//   void _compileRegex() {
//     String pattern = targetMatches.map((item) {
//       String b = item.allowInlineMatching ? '' : r'\b';
//       if (item.text != null) return '$b${item.text}$b';  // Apply word boundary for `text`
//       if (item.regex != null) return '$b${item.regex!.pattern}$b';  // Apply word boundary for regex
//       return '';
//     }).join('|');
//
//     // Exclude matching text inside single or double quotes (strings)
//     _compiledRegex = RegExp(
//       r'''(?!(['\"].*['\"]))''' + pattern,  // Negative lookahead to exclude strings
//       caseSensitive: regExpCaseSensitive,
//       dotAll: regExpDotAll,
//       multiLine: regExpMultiLine,
//       unicode: regExpUnicode,
//     );
//   }
//
//   void updateMatches(List<MatchTargetItem> newMatches) {
//     targetMatches.clear();
//     targetMatches.addAll(newMatches);
//     _compileRegex();  // Recompile regex on match change
//   }
//
//   @override
//   TextSpan buildTextSpan({
//     required BuildContext context,
//     TextStyle? style,
//     required bool withComposing,
//   }) {
//     final matches = <String>{};
//     List<TextSpan> children = [];
//
//     text.splitMapJoin(
//       _compiledRegex!,
//       onNonMatch: (String span) {
//         children.add(TextSpan(text: span, style: style));
//         return span;
//       },
//       onMatch: (Match m) {
//         if (m[0] == null) return '';
//
//         String mTxt = m[0]!;
//         matches.add(mTxt);
//
//         final matchedItem = targetMatches.firstWhere(
//               (r) {
//             if (r.text != null) {
//               return regExpCaseSensitive
//                   ? r.text == mTxt
//                   : r.text!.toLowerCase() == mTxt.toLowerCase();
//             }
//             return r.regex!.allMatches(mTxt).isNotEmpty;
//           },
//           orElse: () => MatchTargetItem(style: style ?? const TextStyle()),
//         );
//
//         children.add(TextSpan(text: mTxt, style: matchedItem.style));
//
//         if (onMatchIndex != null) {
//           final resultMatchIndex = matchValueIndex(m);
//           if (resultMatchIndex != null) {
//             onMatchIndex!([resultMatchIndex]);
//           }
//         }
//
//         return '';
//       },
//     );
//
//     return TextSpan(style: style, children: children);
//   }
//
//   Map<String, List<int>>? matchValueIndex(Match match) {
//     final matchValue = match[0]?.replaceFirstMapped('#', (match) => '');
//     if (matchValue != null) {
//       return {matchValue: [match.start, match.end]};
//     }
//     return null;
//   }
// }
//
// class MatchTargetItem {
//   final String? text;
//   final RegExp? regex;
//   final TextStyle style;
//   final bool allowInlineMatching;
//
//   MatchTargetItem({
//     this.text,
//     this.regex,
//     required this.style,
//     this.allowInlineMatching = false,
//   });
// }
//

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'code_viewer.dart';

class RichWrapper extends StatefulWidget {
  final String? initialText;
  final List<MatchTargetItem> targetMatches;
  final Function(List<String> match)? onMatch;
  final Function(List<Map<String, List<int>>>)? onMatchIndex;
  final bool? deleteOnBack;
  final bool regExpCaseSensitive;
  final bool regExpDotAll;
  final bool regExpMultiLine;
  final bool regExpUnicode;
  final Widget Function(RichTextController controller) child;

  const RichWrapper({
    super.key,
    this.initialText,
    required this.targetMatches,
    this.onMatch,
    this.onMatchIndex,
    this.regExpCaseSensitive = true,
    this.regExpDotAll = false,
    this.regExpMultiLine = false,
    this.regExpUnicode = false,
    this.deleteOnBack = false,
    required this.child,
  });

  @override
  State<RichWrapper> createState() => _RichWrapperState();
}

class _RichWrapperState extends State<RichWrapper> {
  late RichTextController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RichTextController(
      text: widget.initialText,
      targetMatches: widget.targetMatches,
      onMatch: widget.onMatch ?? (x) {},
      deleteOnBack: widget.deleteOnBack,
      onMatchIndex: widget.onMatchIndex,
      regExpCaseSensitive: widget.regExpCaseSensitive,
      regExpDotAll: widget.regExpDotAll,
      regExpMultiLine: widget.regExpMultiLine,
      regExpUnicode: widget.regExpUnicode,
    );
  }

  @override
  void didUpdateWidget(covariant RichWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetMatches != widget.targetMatches) {
      _controller.updateMatches(widget.targetMatches);
    }
    if (oldWidget.initialText != widget.initialText) {
      _controller.text = widget.initialText ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(_controller);
  }
}

class RichTextController extends TextEditingController {
  final List<MatchTargetItem> targetMatches;
  final Function(List<String> match) onMatch;
  final Function(List<Map<String, List<int>>>)? onMatchIndex;
  final bool? deleteOnBack;
  final bool regExpCaseSensitive;
  final bool regExpDotAll;
  final bool regExpMultiLine;
  final bool regExpUnicode;

  RegExp? _compiledRegex;

  RichTextController({
    super.text,
    required this.targetMatches,
    required this.onMatch,
    this.onMatchIndex,
    this.deleteOnBack = false,
    this.regExpCaseSensitive = true,
    this.regExpDotAll = false,
    this.regExpMultiLine = false,
    this.regExpUnicode = false,
  }) {
    _compileRegex();
  }

  // Method to compile regex just once and reuse it
  void _compileRegex() {
    String pattern = targetMatches.map((item) {
      String b = item.allowInlineMatching ? '' : r'\b';
      if (item.text != null)
        return '$b${item.text}$b'; // Apply word boundary for `text`
      if (item.regex != null)
        return '$b${item.regex!.pattern}$b'; // Apply word boundary for regex
      return '';
    }).join('|');

    // Exclude matching text inside single or double quotes (strings)
    _compiledRegex = RegExp(
      r'''(?!(['\"].*['\"]))''' + pattern,
      // Negative lookahead to exclude strings
      caseSensitive: regExpCaseSensitive,
      dotAll: regExpDotAll,
      multiLine: regExpMultiLine,
      unicode: regExpUnicode,
    );
  }

  void updateMatches(List<MatchTargetItem> newMatches) {
    targetMatches.clear();
    targetMatches.addAll(newMatches);
    _compileRegex(); // Recompile regex on match change
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final matches = <String>{};
    List<TextSpan> children = [];
    text.splitMapJoin(
      _compiledRegex!,
      onNonMatch: (String span) {
        children.add(TextSpan(text: span, style: style));
        return span;
      },
      onMatch: (Match m) {
        if (m[0] == null) return '';

        String mTxt = m[0]!;
        matches.add(mTxt);

        // Apply different styles based on the match
        TextStyle? matchStyle;

        // Check if the match is a capitalized word (like class names)
        if (RegExp(r'^[A-Z][a-zA-Z]*$').hasMatch(mTxt)) {
          matchStyle = TextStyle(
              fontSize: 18, color: Colors.blue); // Capitalized words are blue
        }
        // Check if the match is a string literal
        else if (RegExp(r'''["\'].*?["\']''').hasMatch(mTxt)) {
          matchStyle =
              TextStyle(fontSize: 18, color: Colors.green); // Strings are green
        } else if (RegExp(r'^//.*$').hasMatch(mTxt)) {
          print(mTxt);
          matchStyle = TextStyle(
              fontSize: 18, color: Colors.yellow); // Strings are green
        }
        // Apply style for specific keywords (e.g., "home:", "theme:")
        else if (keyWards.contains(mTxt)) {
          matchStyle = TextStyle(
              fontSize: 18,
              color: Colors.orange.shade700); // Specific keywords are orange
        } else {
          print(mTxt);
          matchStyle = TextStyle(
              fontSize: 18, color: Colors.white); // Default text color
        }

        children.add(TextSpan(text: mTxt, style: matchStyle));

        if (onMatchIndex != null) {
          final resultMatchIndex = matchValueIndex(m);
          if (resultMatchIndex != null) {
            onMatchIndex!([resultMatchIndex]);
          }
        }

        return '';
      },
    );
    // text.splitMapJoin(
    //   _compiledRegex!,
    //   onNonMatch: (String span) {
    //     children.add(TextSpan(text: span, style: style));
    //     return span;
    //   },
    //   onMatch: (Match m) {
    //     if (m[0] == null) return '';
    //
    //     String mTxt = m[0]!;
    //     matches.add(mTxt);
    //
    //     final matchedItem = targetMatches.firstWhere(
    //           (r) {
    //         if (r.text != null) {
    //           return regExpCaseSensitive
    //               ? r.text == mTxt
    //               : r.text!.toLowerCase() == mTxt.toLowerCase();
    //         }
    //         return r.regex!.allMatches(mTxt).isNotEmpty;
    //       },
    //       orElse: () => MatchTargetItem(style: style ?? const TextStyle()),
    //     );
    //
    //     children.add(TextSpan(text: mTxt, style: matchedItem.style));
    //
    //     if (onMatchIndex != null) {
    //       final resultMatchIndex = matchValueIndex(m);
    //       if (resultMatchIndex != null) {
    //         onMatchIndex!([resultMatchIndex]);
    //       }
    //     }
    //
    //     return '';
    //   },
    // );

    return TextSpan(style: style, children: children);
  }

  Map<String, List<int>>? matchValueIndex(Match match) {
    final matchValue = match[0]?.replaceFirstMapped('#', (match) => '');
    if (matchValue != null) {
      return {
        matchValue: [match.start, match.end]
      };
    }
    return null;
  }
}

class MatchTargetItem {
  final String? text;
  final RegExp? regex;
  final TextStyle style;
  final bool allowInlineMatching;

  MatchTargetItem({
    this.text,
    this.regex,
    required this.style,
    this.allowInlineMatching = false,
  });
}
