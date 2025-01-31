import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RetroGameButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color buttonColor;
  final Color iconColor;

  const RetroGameButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 80.0,
    this.buttonColor = const Color(0xFF303030),
    this.iconColor = Colors.white,
  });

  @override
  State<RetroGameButton> createState() => _RetroGameButtonState();
}

class _RetroGameButtonState extends State<RetroGameButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
    HapticFeedback.mediumImpact();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.buttonColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, _isPressed ? 2 : 4),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.buttonColor.withOpacity(0.9),
                widget.buttonColor,
              ],
            ),
          ),
          child: Icon(
            widget.icon,
            color: widget.iconColor,
            size: widget.size * 0.5,
          ),
        ),
      ),
    );
  }
}
