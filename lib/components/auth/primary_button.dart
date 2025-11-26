import 'package:flutter/material.dart';
import 'package:project_strava/theme/dark_theme.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.loading = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool loading;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _curve;
  double _pressScale = 1.0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _curve = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.loading || widget.onPressed == null) return;
    setState(() => _pressScale = 0.97);
  }

  void _onTapUp(TapUpDetails _) {
    if (widget.loading || widget.onPressed == null) return;
    setState(() => _pressScale = 1.0);
  }

  void _onTapCancel() {
    if (widget.loading || widget.onPressed == null) return;
    setState(() => _pressScale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.loading || widget.onPressed == null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: isDisabled ? null : _onTapDown,
      onTapUp: isDisabled ? null : _onTapUp,
      onTapCancel: isDisabled ? null : _onTapCancel,
      onTap: isDisabled ? null : widget.onPressed,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, _) {
          final slide = -1.2 + 2.4 * _curve.value;

          return AnimatedScale(
            scale: _pressScale,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment(-1 + slide, 0),
                    end: Alignment(1 + slide, 0),
                    colors: [
                      DarkTheme.secondary,
                      Color.lerp(DarkTheme.secondary, DarkTheme.fade, 0.55)!,
                      DarkTheme.secondary,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: DarkTheme.secondary.withOpacity(0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: widget.loading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: DarkTheme.bg,
                      ),
                    )
                        : Text(
                      widget.label,
                      style: const TextStyle(
                        color: DarkTheme.bg,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
