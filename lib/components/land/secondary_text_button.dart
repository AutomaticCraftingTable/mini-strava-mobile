import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_strava/theme/dark_theme.dart';

class SecondaryTextButton extends StatefulWidget {
  const SecondaryTextButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  State<SecondaryTextButton> createState() => _SecondaryTextButtonState();
}

class _SecondaryTextButtonState extends State<SecondaryTextButton> {
  bool _pressed = false;

  TextStyle get _style => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: DarkTheme.secondary,
  );

  double _textWidth(BuildContext context) {
    final tp = TextPainter(
      text: TextSpan(text: widget.label, style: _style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return tp.width;
  }

  Future<void> _handleTap() async {
    HapticFeedback.selectionClick();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final color = DarkTheme.secondary;
    final width = _textWidth(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _handleTap,
        onHighlightChanged: (v) => setState(() => _pressed = v),
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.white10,
        highlightColor: Colors.white10,
        child: AnimatedScale(
          scale: _pressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 140),
                  curve: Curves.easeOut,
                  style: _style.copyWith(
                    letterSpacing: _pressed ? 0.35 : 0.0,
                  ),
                  child: Text(widget.label, maxLines: 1, overflow: TextOverflow.fade),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: _pressed
                          ? const Duration(milliseconds: 260)
                          : const Duration(milliseconds: 220),
                      curve: _pressed ? Curves.easeOutCubic : Curves.easeOut,
                      height: 2,
                      width: _pressed ? width : 0,
                      color: color,
                    ),
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
