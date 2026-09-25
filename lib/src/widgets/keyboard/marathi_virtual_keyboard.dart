import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

import 'package:maratha_shivmudra/core/utils/responsive.dart';

class _MatraDefinition {
  const _MatraDefinition({required this.sign, required this.name});

  final String sign;
  final String name;
}

const List<_MatraDefinition> _allMatras = [
  _MatraDefinition(sign: 'ा', name: 'काना (ा)'),
  _MatraDefinition(sign: 'ि', name: 'पहिली वेलांटी (ि)'),
  _MatraDefinition(sign: 'ी', name: 'दुसरी वेलांटी (ी)'),
  _MatraDefinition(sign: 'ु', name: 'पहिला उकार (ु)'),
  _MatraDefinition(sign: 'ू', name: 'दुसरा उकार (ू)'),
  _MatraDefinition(sign: 'े', name: 'एक मात्रा (े)'),
  _MatraDefinition(sign: 'ै', name: 'दोन मात्रे (ै)'),
  _MatraDefinition(sign: 'ो', name: 'एक काना एक मात्रा (ो)'),
  _MatraDefinition(sign: 'ौ', name: 'एक काना दोन मात्रे (ौ)'),
  _MatraDefinition(sign: 'ं', name: 'अनुस्वार (ं)'),
  _MatraDefinition(sign: 'ः', name: 'विसर्ग (ः)'),
  _MatraDefinition(sign: 'ृ', name: 'ऋकार (ृ)'),
  _MatraDefinition(sign: 'ॅ', name: 'चंद्र (ॅ)'),
  _MatraDefinition(sign: 'ॉ', name: 'काना चंद्र (ॉ)'),
  _MatraDefinition(sign: '्', name: 'हलंत / जोडाक्षर (्)'),
];

class _KeyboardPopEntry implements PopEntry<Object?> {
  _KeyboardPopEntry(this.onPop);

  final VoidCallback onPop;

  @override
  final ValueNotifier<bool> canPopNotifier = ValueNotifier<bool>(false);

  @override
  @Deprecated('Use onPopInvokedWithResult instead')
  void onPopInvoked(bool didPop) {
    if (!didPop) onPop();
  }

  @override
  void onPopInvokedWithResult(bool didPop, Object? result) {
    if (!didPop) onPop();
  }
}


/// Professional Responsive Marathi Virtual Keyboard for web & mobile input.
/// - No headers or cross icons (clean on-screen keyboard).
/// - Signs row appears only when a word/character is entered & fits width.
/// - Numbers removed from initial view; shown only in `?123` (Marathi digits).
/// - Swar buttons (a, aa, aai...) expand across width without scrolling.
/// - Backspace is sign-only on the 2nd-last row right bottom.
/// - Complete is tick mark only on the bottom row right bottom.
/// - Comma (,) and dot (.) in opening keyboard bottom row.
/// - Supports physical computer keyboard typing while opened.
class MarathiVirtualKeyboard extends StatefulWidget {
  const MarathiVirtualKeyboard({
    required this.controller,
    super.key,
    this.focusNode,
    this.title = 'मराठी कीबोर्ड',
    this.isMovable = false,
    this.onPanUpdate,
    this.onDone,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String title;
  final bool isMovable;
  final void Function(Offset delta)? onPanUpdate;
  final VoidCallback? onDone;
  final List<TextInputFormatter>? inputFormatters;

  static OverlayEntry? _activeEntry;
  static Completer<void>? _completer;
  static final ValueNotifier<bool> isOpenNotifier = ValueNotifier<bool>(false);
  static DateTime? _lastDismissedAt;
  static ModalRoute<Object?>? _activeRoute;
  static _KeyboardPopEntry? _activePopEntry;

  static bool get isOpen => _activeEntry != null;

  static bool get wasRecentlyDismissed {
    if (_lastDismissedAt == null) return false;
    return DateTime.now().difference(_lastDismissedAt!) <
        const Duration(milliseconds: 600);
  }

  /// Returns whether the device uses a soft keyboard (mobile or tablet).
  static bool isSoftKeyboardDevice(BuildContext context) =>
      Responsive.hasSoftKeyboard(context);

  static void dismiss() {
    _lastDismissedAt = DateTime.now();
    if (_activeRoute != null && _activePopEntry != null) {
      final route = _activeRoute;
      final popEntry = _activePopEntry;
      _activeRoute = null;
      _activePopEntry = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        route?.unregisterPopEntry(popEntry!);
      });
    }
    if (_activeEntry != null) {
      _activeEntry?.remove();
      _activeEntry = null;
      isOpenNotifier.value = false;
      if (_completer != null && !_completer!.isCompleted) {
        _completer!.complete();
      }
      _completer = null;
    }
  }

  static Future<void> show(
    BuildContext context, {
    required TextEditingController controller,
    FocusNode? focusNode,
    String title = 'मराठी कीबोर्ड',
    List<TextInputFormatter>? inputFormatters,
  }) {
    dismiss();

    final completer = Completer<void>();
    _completer = completer;

    // Register PopEntry on current ModalRoute to intercept back gestures
    final route = ModalRoute.of(context);
    if (route != null) {
      final popEntry = _KeyboardPopEntry(dismiss);
      _activePopEntry = popEntry;
      _activeRoute = route;
      route.registerPopEntry(popEntry);
    }

    // Immediately keep the target textfield focused with active cursor!
    if (focusNode != null && !focusNode.hasFocus) {
      focusNode.requestFocus();
    }
    if (controller.selection.start < 0 ||
        controller.selection.start > controller.text.length) {
      final len = controller.text.length;
      controller.selection = TextSelection.collapsed(offset: len);
    }
    if (isSoftKeyboardDevice(context) && !kIsWeb) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }

    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      completer.complete();
      return completer.future;
    }

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 700;

    // Scroll editing field into view ONLY in mobile view!
    // In tab and desktop it should NOT scroll!
    if (isMobile && focusNode?.context != null) {
      Scrollable.ensureVisible(
        focusNode!.context!,
        alignment: 0.25,
        duration: const Duration(milliseconds: 250),
      );
    }

    Offset position = Offset.zero;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) {
        final screenWidth = MediaQuery.sizeOf(ctx).width;
        final isMobile = screenWidth < 700;

        if (isMobile) {
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.viewInsetsOf(ctx).bottom,
                child: TapRegion(
                  groupId: MarathiVirtualKeyboard,
                  onTapOutside: (_) => dismiss(),
                  child: Material(
                    color: Colors.transparent,
                    child: MarathiVirtualKeyboard(
                      controller: controller,
                      focusNode: focusNode,
                      title: title,
                      onDone: dismiss,
                      inputFormatters: inputFormatters,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return StatefulBuilder(
            builder: (ctx, setOverlayState) {
              return Stack(
                children: [
                  Center(
                    child: Transform.translate(
                      offset: position,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: TapRegion(
                          groupId: MarathiVirtualKeyboard,
                          onTapOutside: (_) => dismiss(),
                          child: Material(
                            color: Colors.transparent,
                            child: MarathiVirtualKeyboard(
                              controller: controller,
                              focusNode: focusNode,
                              title: title,
                              isMovable: true,
                              onPanUpdate: (delta) {
                                setOverlayState(() {
                                  position += delta;
                                });
                              },
                              onDone: dismiss,
                              inputFormatters: inputFormatters,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );

    _activeEntry = entry;
    isOpenNotifier.value = true;
    overlay.insert(entry);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (focusNode != null && !focusNode.hasFocus) {
        focusNode.requestFocus();
      }
      if (controller.selection.start < 0 ||
          controller.selection.start > controller.text.length) {
        controller.selection =
            TextSelection.collapsed(offset: controller.text.length);
      }
      if (isSoftKeyboardDevice(context) && !kIsWeb) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    });

    return completer.future;
  }

  @override
  State<MarathiVirtualKeyboard> createState() => _MarathiVirtualKeyboardState();
}

class _MarathiVirtualKeyboardState extends State<MarathiVirtualKeyboard> {
  late final FocusNode _keyboardFocusNode;
  bool _isSymbolsMode = false;

  // Buffer for physical keyboard phonetic transliteration
  String _latinBuffer = '';
  int _lastWordStart = -1;

  // Swar (Vowels) - a, aa, aai... (15 keys)
  static const List<String> _swar = [
    'अ',
    'आ',
    'इ',
    'ई',
    'उ',
    'ऊ',
    'ऋ',
    'ए',
    'ऐ',
    'ओ',
    'औ',
    'अं',
    'अः',
    'ॲ',
    'ऑ',
  ];

  // Vyanjan (Consonants) Rows
  static const List<String> _vyanjanRow1 = [
    'क',
    'ख',
    'ग',
    'घ',
    'ङ',
    'च',
    'छ',
    'ज',
    'झ',
    'ञ',
  ];
  static const List<String> _vyanjanRow2 = [
    'ट',
    'ठ',
    'ड',
    'ढ',
    'ण',
    'त',
    'थ',
    'द',
    'ध',
    'न',
  ];
  static const List<String> _vyanjanRow3 = [
    'प',
    'फ',
    'ब',
    'भ',
    'म',
    'य',
    'र',
    'ल',
    'व',
    'श',
  ];
  // 2nd last row: remaining consonants
  static const List<String> _vyanjanRow4 = [
    'ष',
    'स',
    'ह',
    'ळ',
    'क्ष',
    'ज्ञ',
    'श्र',
    'त्र',
  ];

  // Symbols Mode Rows (?123) - ONLY Marathi Numbers
  static const List<String> _symbolsRow1 = [
    '१',
    '२',
    '३',
    '४',
    '५',
    '६',
    '७',
    '८',
    '९',
    '०',
  ];
  static const List<String> _symbolsRow2 = [
    '@',
    '#',
    r'$',
    '%',
    '&',
    '*',
    '-',
    '+',
    '(',
    ')',
  ];
  static const List<String> _symbolsRow3 = [
    '!',
    '"',
    "'",
    ':',
    ';',
    '/',
    '?',
    '।',
    '॥',
    '_',
  ];
  static const List<String> _symbolsRow4 = [
    '=',
    r'\',
    '|',
    '<',
    '>',
    '{',
    '}',
    '[',
    ']',
    '₹',
  ];

  KeyEvent? _lastProcessedEvent;

  @override
  void initState() {
    super.initState();
    _keyboardFocusNode = FocusNode(
      canRequestFocus: widget.focusNode == null,
      skipTraversal: widget.focusNode != null,
    );
    widget.controller.addListener(_onTextChanged);
    if (widget.focusNode != null) {
      widget.focusNode!.onKeyEvent = _handleHardwareFocusKeyEvent;
    }
    HardwareKeyboard.instance.addHandler(_handleGlobalHardwareKey);
  }

  @override
  void didUpdateWidget(covariant MarathiVirtualKeyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _keyboardFocusNode.canRequestFocus = widget.focusNode == null;
      _keyboardFocusNode.skipTraversal = widget.focusNode != null;
      oldWidget.focusNode?.onKeyEvent = null;
      if (widget.focusNode != null) {
        widget.focusNode!.onKeyEvent = _handleHardwareFocusKeyEvent;
      }
    }
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleGlobalHardwareKey);
    widget.controller.removeListener(_onTextChanged);
    widget.focusNode?.onKeyEvent = null;
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  bool _handleGlobalHardwareKey(KeyEvent event) {
    if (!mounted || !MarathiVirtualKeyboard.isOpen) return false;
    final primary = FocusManager.instance.primaryFocus;
    if (widget.focusNode != null &&
        primary != null &&
        primary != widget.focusNode &&
        primary != _keyboardFocusNode) {
      return false;
    }
    return _processKeyEvent(event);
  }

  /// Core key processor for physical computer keyboard events.
  bool _processKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    // Deduplicate if both FocusNode.onKeyEvent and HardwareKeyboard
    // handler fire for the exact same event instance
    if (identical(_lastProcessedEvent, event)) {
      return true;
    }
    _lastProcessedEvent = event;

    if (event.logicalKey == LogicalKeyboardKey.backspace ||
        event.logicalKey == LogicalKeyboardKey.delete) {
      if (_latinBuffer.isNotEmpty) {
        _latinBuffer = _latinBuffer.substring(0, _latinBuffer.length - 1);
        if (_latinBuffer.isNotEmpty) {
          final mrWord = BilingualHelper.transliterateToMarathi(_latinBuffer);
          _replaceActiveWord(mrWord);
          return true;
        }
      }
      _backspace();
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.space) {
      _latinBuffer = '';
      _lastWordStart = -1;
      _insertChar(' ');
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.enter) {
      widget.onDone != null
          ? widget.onDone!()
          : MarathiVirtualKeyboard.dismiss();
      return true;
    }

    if (event.logicalKey == LogicalKeyboardKey.escape) {
      MarathiVirtualKeyboard.dismiss();
      return true;
    }

    // Allow navigation and system shortcuts to pass directly to textfield / OS
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.home ||
        event.logicalKey == LogicalKeyboardKey.end ||
        event.logicalKey == LogicalKeyboardKey.tab ||
        HardwareKeyboard.instance.isMetaPressed ||
        HardwareKeyboard.instance.isControlPressed) {
      _latinBuffer = '';
      _lastWordStart = -1;
      return false;
    }

    String? char = event.character;
    if (char == null || char.isEmpty) {
      final label = event.logicalKey.keyLabel;
      if (label.isNotEmpty && label.length == 1) {
        char = label;
      }
    }
    if (char == null || char.isEmpty) return false;

    final code = char.codeUnitAt(0);

    // Devanagari character
    if (code >= 0x0900 && code <= 0x097F) {
      _latinBuffer = '';
      _lastWordStart = -1;
      if (_isMatraOrModifier(code)) {
        _applyMatra(char);
      } else {
        _insertChar(char);
      }
      return true;
    }

    // Number keys: convert to Marathi numerals
    const enToMr = {
      '0': '०',
      '1': '१',
      '2': '२',
      '3': '३',
      '4': '४',
      '5': '५',
      '6': '६',
      '7': '७',
      '8': '८',
      '9': '९',
    };
    if (enToMr.containsKey(char)) {
      if (!_allowsDigits) return true;
      _latinBuffer = '';
      _lastWordStart = -1;
      _insertChar(enToMr[char]!);
      return true;
    }

    // Punctuation
    if (char == ',' ||
        char == '.' ||
        char == '-' ||
        char == '/' ||
        char == '!' ||
        char == '?' ||
        char == '@' ||
        char == '#' ||
        char == ':' ||
        char == ';') {
      _latinBuffer = '';
      _lastWordStart = -1;
      _insertChar(char);
      return true;
    }

    // Latin letters a-z, A-Z: phonetic transliteration
    final isLetter = RegExp(r'^[a-zA-Z]$').hasMatch(char);
    if (isLetter) {
      _latinBuffer += char.toLowerCase();
      final mrWord = BilingualHelper.transliterateToMarathi(_latinBuffer);
      _replaceActiveWord(mrWord);
      return true;
    }

    _latinBuffer = '';
    _lastWordStart = -1;
    _insertChar(char);
    return true;
  }

  void _handleHardwareKey(KeyEvent event) {
    _processKeyEvent(event);
  }

  KeyEventResult _handleHardwareFocusKeyEvent(FocusNode node, KeyEvent event) {
    final handled = _processKeyEvent(event);
    return handled ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  void _ensureTargetFieldFocused() {
    if (widget.focusNode != null && !widget.focusNode!.hasFocus) {
      final currentOffset = widget.controller.selection.extentOffset >= 0
          ? widget.controller.selection.extentOffset
          : widget.controller.text.length;
      widget.focusNode!.requestFocus();
      widget.controller.selection =
          TextSelection.collapsed(offset: currentOffset);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!widget.controller.selection.isCollapsed) {
          widget.controller.selection =
              TextSelection.collapsed(offset: currentOffset);
        }
      });
    }
    if (MarathiVirtualKeyboard.isSoftKeyboardDevice(context) && !kIsWeb) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  void _keepTargetFocused() {
    if (widget.focusNode != null && !widget.focusNode!.hasFocus) {
      final currentOffset = widget.controller.selection.extentOffset >= 0
          ? widget.controller.selection.extentOffset
          : widget.controller.text.length;
      widget.focusNode!.requestFocus();
      widget.controller.selection =
          TextSelection.collapsed(offset: currentOffset);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!widget.controller.selection.isCollapsed) {
          widget.controller.selection =
              TextSelection.collapsed(offset: currentOffset);
        }
      });
    }
    if (MarathiVirtualKeyboard.isSoftKeyboardDevice(context) && !kIsWeb) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  void _replaceActiveWord(String newWord) {
    final text = widget.controller.text;
    var selection = widget.controller.selection;
    if (!selection.isCollapsed || selection.start < 0) {
      selection = TextSelection.collapsed(offset: text.length);
    }
    final cursorPos = selection.start;

    if (_lastWordStart < 0 || _lastWordStart > cursorPos) {
      int idx = cursorPos - 1;
      while (idx >= 0 && text[idx] != ' ') {
        idx--;
      }
      _lastWordStart = idx + 1;
    }

    final before = text.substring(0, _lastWordStart);
    final after = text.substring(cursorPos);
    final newText = before + newWord + after;
    final newCursor = (before + newWord).length;

    _updateControllerValue(TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursor),
    ));
  }

  void _updateControllerValue(TextEditingValue candidate) {
    TextEditingValue finalValue = candidate;
    if (widget.inputFormatters != null && widget.inputFormatters!.isNotEmpty) {
      final oldValue = widget.controller.value;
      for (final formatter in widget.inputFormatters!) {
        finalValue = formatter.formatEditUpdate(oldValue, finalValue);
      }
    }
    widget.controller.value = finalValue;
    _ensureTargetFieldFocused();
  }

  bool get _allowsDigits {
    if (widget.inputFormatters == null || widget.inputFormatters!.isEmpty) {
      return true;
    }
    const testOld = TextEditingValue.empty;
    const testNew = TextEditingValue(text: '१');
    for (final formatter in widget.inputFormatters!) {
      final res = formatter.formatEditUpdate(testOld, testNew);
      if (!res.text.contains('१')) {
        return false;
      }
    }
    return true;
  }

  bool _allowsChar(String c) {
    if (widget.inputFormatters == null || widget.inputFormatters!.isEmpty) {
      return true;
    }
    const testOld = TextEditingValue.empty;
    final testNew = TextEditingValue(text: c);
    for (final formatter in widget.inputFormatters!) {
      final res = formatter.formatEditUpdate(testOld, testNew);
      if (!res.text.contains(c)) {
        return false;
      }
    }
    return true;
  }

  /// Finds the active Devanagari base consonant / conjunct preceding cursor.
  String? _getActiveBase() {
    final text = widget.controller.text;
    var selection = widget.controller.selection;
    if (!selection.isCollapsed || selection.start < 0) {
      selection = TextSelection.collapsed(offset: text.length);
    }
    final cursorPos = selection.start;
    if (cursorPos == 0 || text.isEmpty) return null;

    final before = text.substring(0, cursorPos);
    int idx = before.length - 1;
    while (idx >= 0 && _isMatraOrModifier(before.codeUnitAt(idx))) {
      idx--;
    }
    if (idx < 0) return null;

    final baseText = before.substring(0, idx + 1);

    const conjuncts = ['क्ष', 'ज्ञ', 'श्र', 'त्र'];
    for (final c in conjuncts) {
      if (baseText.endsWith(c)) return c;
    }

    final code = baseText.codeUnitAt(baseText.length - 1);
    if ((code >= 0x0904 && code <= 0x0939) ||
        (code >= 0x0958 && code <= 0x095F)) {
      return baseText[baseText.length - 1];
    }
    return null;
  }

  bool _isMatraOrModifier(int code) {
    return (code >= 0x093E && code <= 0x094D) ||
        code == 0x0901 ||
        code == 0x0902 ||
        code == 0x0903 ||
        code == 0x093C;
  }

  void _vibrate() {
    HapticFeedback.lightImpact();
  }

  void _insertChar(String char) {
    _vibrate();
    _latinBuffer = '';
    _lastWordStart = -1;
    final text = widget.controller.text;
    var selection = widget.controller.selection;

    // Never replace existing text when typing on virtual keyboard:
    // If text was selected (e.g. browser focus auto-select),
    // collapse to cursor!
    if (!selection.isCollapsed) {
      final target = (selection.extentOffset >= 0 &&
              selection.extentOffset <= text.length)
          ? selection.extentOffset
          : text.length;
      selection = TextSelection.collapsed(offset: target);
      widget.controller.selection = selection;
    }

    final start = selection.start >= 0 ? selection.start : text.length;
    final newText = text.replaceRange(start, start, char);
    final newOffset = start + char.length;

    _updateControllerValue(TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    ));
  }

  void _applyMatra(String sign) {
    _vibrate();
    _latinBuffer = '';
    _lastWordStart = -1;
    final text = widget.controller.text;
    var selection = widget.controller.selection;
    if (!selection.isCollapsed) {
      final target = (selection.extentOffset >= 0 &&
              selection.extentOffset <= text.length)
          ? selection.extentOffset
          : text.length;
      selection = TextSelection.collapsed(offset: target);
      widget.controller.selection = selection;
    }
    final cursorPos = selection.start >= 0 ? selection.start : text.length;

    if (cursorPos == 0) {
      _insertChar(sign);
      return;
    }

    final before = text.substring(0, cursorPos);
    final after = text.substring(cursorPos);

    if (sign == '\u0902') {
      if (before.endsWith('\u0902')) {
        final newBefore = before.substring(0, before.length - 1);
        _updateControllerValue(TextEditingValue(
          text: newBefore + after,
          selection: TextSelection.collapsed(offset: newBefore.length),
        ));
        return;
      }
      _insertChar(sign);
      return;
    }

    if (sign == '\u0903') {
      if (before.endsWith('\u0903')) {
        final newBefore = before.substring(0, before.length - 1);
        _updateControllerValue(TextEditingValue(
          text: newBefore + after,
          selection: TextSelection.collapsed(offset: newBefore.length),
        ));
        return;
      }
      _insertChar(sign);
      return;
    }

    final hasTrailingAnusvara = before.endsWith('\u0902');
    final working = hasTrailingAnusvara
        ? before.substring(0, before.length - 1)
        : before;

    if (working.isNotEmpty) {
      final lastCode = working.codeUnitAt(working.length - 1);
      final isVowelMatra = lastCode >= 0x093E && lastCode <= 0x094D;
      if (isVowelMatra) {
        final replaced = working.substring(0, working.length - 1) + sign;
        final finalBefore = hasTrailingAnusvara ? '$replaced\u0902' : replaced;
        _updateControllerValue(TextEditingValue(
          text: finalBefore + after,
          selection: TextSelection.collapsed(offset: finalBefore.length),
        ));
        return;
      }
    }

    _insertChar(sign);
  }

  void _backspace() {
    _vibrate();
    _latinBuffer = '';
    _lastWordStart = -1;
    final text = widget.controller.text;
    var selection = widget.controller.selection;

    if (text.isEmpty) return;

    if (!selection.isCollapsed && selection.start >= 0) {
      final start = selection.start;
      final end = selection.end;
      final newText = text.replaceRange(start, end, '');
      _updateControllerValue(TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: start),
      ));
      return;
    }

    if (selection.start < 0) {
      selection = TextSelection.collapsed(offset: text.length);
    }

    if (selection.start > 0) {
      final start = selection.start;
      final newText =
          text.substring(0, start - 1) + text.substring(start);
      _updateControllerValue(TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: start - 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final activeBase = _getActiveBase();

    final keyboardBody = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _keepTargetFocused,
      onPanUpdate: (details) {
        if (widget.isMovable) {
          widget.onPanUpdate?.call(details.delta);
        }
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.sizeOf(context).height * (isMobile ? 0.88 : 0.82),
          maxWidth: 680,
        ),
        padding: EdgeInsets.fromLTRB(
          isMobile ? 2 : 6,
          isMobile ? 4 : 8,
          isMobile ? 2 : 6,
          isMobile ? 4 : 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF180C0C),
          borderRadius: isMobile
              ? const BorderRadius.vertical(top: Radius.circular(20))
              : BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gold.withValues(alpha: 0.45),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.85),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dynamic Kanamatra / Chinhe Bar: Always active with constant
            // height to prevent layout shift. Shows empty sign (◌ा) initially
            // and replaces with active character (का) when typed.
            if (!_isSymbolsMode)
              _buildDynamicSignsRow(activeBase, isMobile: isMobile),

            // Normal Marathi vs ?123 Symbols Keyboard
            if (_isSymbolsMode)
              _buildSymbolsKeyboard(isMobile: isMobile)
            else
              _buildNormalKeyboard(isMobile: isMobile),
          ],
        ),
      ),
    );

    if (widget.focusNode != null) {
      return keyboardBody;
    }

    return KeyboardListener(
      focusNode: _keyboardFocusNode,
      autofocus: true,
      onKeyEvent: _handleHardwareKey,
      child: keyboardBody,
    );
  }

  /// Dynamic Kanamatra / Chinhe Bar: Expands across 100% width with ZERO scroll.
  /// Kept always active at fixed height to prevent jarring height shifts.
  Widget _buildDynamicSignsRow(String? activeBase, {bool isMobile = false}) {
    final chipHeight = isMobile ? 26.0 : 34.0;
    final fontSize = isMobile ? 11.5 : 13.0;

    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 3 : 6),
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: isMobile ? 2 : 3),
      decoration: BoxDecoration(
        color: const Color(0xFF261414),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: activeBase != null
              ? AppColors.gold.withValues(alpha: 0.6)
              : AppColors.gold.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: _allMatras.map((matra) {
          final displayChar = activeBase != null
              ? '$activeBase${matra.sign}'
              : '\u25CC${matra.sign}';
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 0.5 : 1),
              child: _buildMatraChip(
                matra,
                displayChar,
                height: chipHeight,
                fontSize: fontSize,
                isActive: activeBase != null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMatraChip(
    _MatraDefinition matra,
    String displayChar, {
    double height = 34,
    double fontSize = 13,
    bool isActive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        canRequestFocus: false,
        onTap: () => _applyMatra(matra.sign),
        borderRadius: BorderRadius.circular(4),
        child: Tooltip(
          message: matra.name,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.gold.withValues(alpha: 0.16)
                  : const Color(0xFF1E1111),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isActive
                    ? AppColors.gold.withValues(alpha: 0.45)
                    : AppColors.gold.withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: Text(
                displayChar,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: isActive ? AppColors.goldLight : AppColors.textMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Normal Devanagari Keyboard
  Widget _buildNormalKeyboard({bool isMobile = false}) {
    final rowGap = isMobile ? 2.5 : 5.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: Swar (a, aa, aai...) - Expands across 100% width
        // without scroll
        _buildSwarRow(isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 2: Vyanjan Row 1 (10 keys)
        _buildKeyRow(_vyanjanRow1, isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 3: Vyanjan Row 2 (10 keys)
        _buildKeyRow(_vyanjanRow2, isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 4: Vyanjan Row 3 (10 keys)
        _buildKeyRow(_vyanjanRow3, isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 5: 2nd-last row: Consonants + Backspace icon on right bottom
        _buildSecondLastRow(isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 6: Bottom Action Row (?123, comma, space, dot, tick mark)
        _buildBottomActionRow(isMobile: isMobile),
      ],
    );
  }

  /// Swar (a, aa, aai...) in a single row - Expands to fit width
  Widget _buildSwarRow({bool isMobile = false}) {
    return Row(
      children: _swar.map((char) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 0.5 : 1),
            child: _buildKeyButton(char, isSwar: true, isMobile: isMobile),
          ),
        );
      }).toList(),
    );
  }

  /// 2nd last row: Consonants + Backspace on right bottom
  Widget _buildSecondLastRow({bool isMobile = false}) {
    return Row(
      children: [
        ..._vyanjanRow4.map((char) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 0.75 : 1),
              child: _buildKeyButton(char, isMobile: isMobile),
            ),
          );
        }),
        // Backspace: sign only on right bottom of 2nd last row
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 0.75 : 1),
            child: _buildInlineBackspaceKey(isMobile: isMobile),
          ),
        ),
      ],
    );
  }

  /// ?123 Symbols Keyboard (ONLY Marathi Numbers)
  Widget _buildSymbolsKeyboard({bool isMobile = false}) {
    final rowGap = isMobile ? 2.5 : 5.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: Marathi Numbers only + Backspace
        _buildKeyRow(_symbolsRow1, isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 2: Symbols Row 2
        _buildKeyRow(_symbolsRow2, isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 3: Symbols Row 3
        _buildKeyRow(_symbolsRow3, isMobile: isMobile),
        SizedBox(height: rowGap),

        // Row 4: 2nd last row with Backspace on right
        Row(
          children: [
            ..._symbolsRow4.map((char) {
              return Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isMobile ? 0.75 : 1),
                  child: _buildKeyButton(char, isMobile: isMobile),
                ),
              );
            }),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: isMobile ? 0.75 : 1),
                child: _buildInlineBackspaceKey(isMobile: isMobile),
              ),
            ),
          ],
        ),
        SizedBox(height: rowGap),

        // Row 5: Bottom Action Row
        _buildBottomActionRow(isMobile: isMobile),
      ],
    );
  }

  Widget _buildKeyRow(List<String> keys, {bool isMobile = false}) {
    return Row(
      children: keys.map((key) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 0.75 : 1),
            child: _buildKeyButton(key, isMobile: isMobile),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeyButton(
    String char, {
    bool isSwar = false,
    bool isMobile = false,
    double? height,
    double? fontSize,
    Color? color,
  }) {
    final effectiveHeight = height ?? (isMobile ? 32.0 : 38.0);
    final effectiveFontSize = fontSize ??
        (isSwar
            ? (isMobile ? 13.0 : 14.0)
            : (isMobile ? 14.0 : 15.0));

    return Material(
      color: Colors.transparent,
      child: InkWell(
        canRequestFocus: false,
        onTap: () => _insertChar(char),
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: effectiveHeight,
          decoration: BoxDecoration(
            color:
                color ??
                (isSwar ? const Color(0xFF281813) : AppColors.darkSurface),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isSwar
                  ? AppColors.saffron.withValues(alpha: 0.45)
                  : AppColors.darkBorder,
            ),
          ),
          child: Center(
            child: Text(
              char,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: effectiveFontSize,
                fontWeight: FontWeight.bold,
                color: isSwar ? AppColors.saffronLight : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInlineBackspaceKey({bool isMobile = false, double? height}) {
    final effectiveHeight = height ?? (isMobile ? 32.0 : 38.0);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        canRequestFocus: false,
        onTap: _backspace,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: effectiveHeight,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Icon(
              Icons.backspace_outlined,
              size: isMobile ? 15 : 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActionRow({bool isMobile = false}) {
    final gap = isMobile ? 2.0 : 3.0;
    final rowHeight = isMobile ? 32.0 : 38.0;
    final allowDigits = _allowsDigits;
    final allowComma = _allowsChar(',');
    final allowDot = _allowsChar('.');
    final allowSpace = _allowsChar(' ');

    return Row(
      children: [
        if (allowDigits) ...[
          // ?123 Mode Switcher Button
          Expanded(
            flex: 2,
            child: _buildSpecialActionButton(
              label: _isSymbolsMode ? 'मराठी' : '?123',
              height: rowHeight,
              color: AppColors.saffron.withValues(alpha: 0.22),
              borderColor: AppColors.saffron.withValues(alpha: 0.6),
              textColor: AppColors.goldLight,
              onTap: () {
                _vibrate();
                setState(() {
                  _isSymbolsMode = !_isSymbolsMode;
                });
              },
            ),
          ),
          SizedBox(width: gap),
        ],

        if (allowComma) ...[
          // Comma (,) in opening keyboard
          Expanded(
            child: _buildKeyButton(
              ',',
              isMobile: isMobile,
              height: rowHeight,
              fontSize: isMobile ? 15 : 16,
              color: AppColors.darkSurface,
            ),
          ),
          SizedBox(width: gap),
        ],

        // Spacebar
        if (allowSpace)
          Expanded(
            flex: allowDigits ? 6 : 8,
            child: _buildSpecialActionButton(
              label: 'स्पेस',
              height: rowHeight,
              icon: Icons.space_bar_rounded,
              onTap: () => _insertChar(' '),
            ),
          )
        else
          const Spacer(flex: 2),

        if (allowDot) ...[
          SizedBox(width: gap),
          // Dot (.) in opening keyboard
          Expanded(
            child: _buildKeyButton(
              '.',
              isMobile: isMobile,
              height: rowHeight,
              fontSize: isMobile ? 15 : 16,
              color: AppColors.darkSurface,
            ),
          ),
        ],
        SizedBox(width: gap),

        // Complete / Done: ONLY TICK MARK SIGN
        Expanded(
          flex: 2,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              canRequestFocus: false,
              onTap: () {
                _vibrate();
                widget.onDone != null
                    ? widget.onDone!()
                    : MarathiVirtualKeyboard.dismiss();
              },
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: rowHeight,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.greenAccent.withValues(alpha: 0.6),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: isMobile ? 18 : 20,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialActionButton({
    required String label,
    required VoidCallback onTap,
    double height = 38,
    IconData? icon,
    Color? color,
    Color? borderColor,
    Color? textColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        canRequestFocus: false,
        onTap: () {
          onTap();
          _ensureTargetFieldFocused();
        },
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color ?? AppColors.darkSurface,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor ?? AppColors.darkBorder),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 14, color: textColor ?? Colors.white),
                  const SizedBox(width: 2),
                ],
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: textColor ?? Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
