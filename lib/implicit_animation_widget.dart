import 'package:flutter/material.dart';
import 'dart:math';

/// IMPLICIT ANIMATION
/// Uses [AnimatedContainer] – Flutter automatically interpolates between
/// old and new property values whenever setState() is called.
/// No AnimationController is needed; Flutter handles everything internally.
class ImplicitAnimationWidget extends StatefulWidget {
  const ImplicitAnimationWidget({super.key});

  @override
  State<ImplicitAnimationWidget> createState() =>
      _ImplicitAnimationWidgetState();
}

class _ImplicitAnimationWidgetState extends State<ImplicitAnimationWidget> {
  bool _isExpanded = false;

  // Properties that AnimatedContainer will interpolate between
  double get _width => _isExpanded ? 280 : 120;
  double get _height => _isExpanded ? 200 : 120;
  double get _borderRadius => _isExpanded ? 24 : 60;
  Color get _color =>
      _isExpanded ? const Color(0xFFFF6584) : const Color(0xFF6C63FF);
  double get _padding => _isExpanded ? 20 : 8;
  double get _iconSize => _isExpanded ? 56 : 36;

  // Random rotation for a fun effect when tapping repeatedly
  double _rotation = 0;

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      _rotation += _isExpanded ? pi / 4 : -pi / 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFF6584).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // The star of the show: AnimatedContainer
          Center(
            child: GestureDetector(
              onTap: _toggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut, // springy feel
                width: _width,
                height: _height,
                padding: EdgeInsets.all(_padding),
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: _color.withOpacity(0.5),
                      blurRadius: _isExpanded ? 40 : 20,
                      spreadRadius: _isExpanded ? 8 : 2,
                    ),
                  ],
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _isExpanded
                      ? _ExpandedContent(key: const ValueKey('expanded'))
                      : _CollapsedContent(
                          key: const ValueKey('collapsed'),
                          iconSize: _iconSize,
                        ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Info text
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: TextStyle(
              color: _isExpanded
                  ? const Color(0xFFFF6584)
                  : Colors.white.withOpacity(0.5),
              fontSize: _isExpanded ? 14 : 12,
              fontWeight: _isExpanded ? FontWeight.w600 : FontWeight.normal,
            ),
            child: const Text(
              'Tap the box to animate  (AnimatedContainer)',
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 16),

          // State indicator chips
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StateChip(
                label: 'Width',
                value: '${_width.toInt()}px',
                color: _color,
              ),
              const SizedBox(width: 8),
              _StateChip(
                label: 'Height',
                value: '${_height.toInt()}px',
                color: _color,
              ),
              const SizedBox(width: 8),
              _StateChip(
                label: 'Radius',
                value: '${_borderRadius.toInt()}',
                color: _color,
              ),
            ],
          ),

          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: _toggle,
            icon: Icon(_isExpanded ? Icons.compress : Icons.expand, size: 16),
            label: Text(_isExpanded ? 'Collapse' : 'Expand'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isExpanded
                  ? const Color(0xFFFF6584)
                  : const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CollapsedContent extends StatelessWidget {
  final double iconSize;
  const _CollapsedContent({super.key, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.widgets_rounded, color: Colors.white, size: iconSize),
    );
  }
}

class _ExpandedContent extends StatelessWidget {
  const _ExpandedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle_outline, color: Colors.white, size: 36),
        const SizedBox(height: 10),
        const Text(
          'Expanded!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'AnimatedContainer\ninterpolates smoothly',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 11),
        ),
      ],
    );
  }
}

class _StateChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StateChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(0.7),
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
