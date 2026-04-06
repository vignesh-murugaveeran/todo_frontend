import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// DEMO APP — showcases all 4 nav bar styles
// ─────────────────────────────────────────────

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Nav Bars',
      theme: ThemeData(useMaterial3: true),
      home: const StylePickerScreen(),
    );
  }
}

class StylePickerScreen extends StatefulWidget {
  const StylePickerScreen({super.key});

  @override
  State<StylePickerScreen> createState() => _StylePickerScreenState();
}

class _StylePickerScreenState extends State<StylePickerScreen> {
  int _style = 0;

  static const _labels = [
    'Floating Pill',
    'Slide-Up Label',
    'Neon Glow',
    'Line Indicator',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nav Bar Styles'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: List.generate(_labels.length, (i) {
                final selected = i == _style;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_labels[i]),
                    selected: selected,
                    onSelected: (_) => setState(() => _style = i),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: [
        const _FloatingPillDemo(),
        const _SlideUpLabelDemo(),
        const _NeonGlowDemo(),
        const _LineIndicatorDemo(),
      ][_style],
    );
  }
}

// ═══════════════════════════════════════════════════════
// STYLE 1 — FLOATING PILL / BUBBLE BAR
// ═══════════════════════════════════════════════════════

/// A floating card nav bar where the active item gets a
/// animated pill background that slides smoothly between items.
class FloatingPillNavBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final Color inactiveColor;
  final Color pillColor;
  final Color backgroundColor;

  const FloatingPillNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0xFF9E9E9E),
    this.pillColor = const Color(0xFF6C63FF),
    this.backgroundColor = Colors.white,
  });

  @override
  State<FloatingPillNavBar> createState() => _FloatingPillNavBarState();
}

class _FloatingPillNavBarState extends State<FloatingPillNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pillAnim;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _pillAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _previousIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant FloatingPillNavBar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _previousIndex = old.currentIndex;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / widget.items.length;
            return AnimatedBuilder(
              animation: _pillAnim,
              builder: (context, child) {
                final pillX = Tween<double>(
                  begin: _previousIndex * itemWidth,
                  end: widget.currentIndex * itemWidth,
                ).evaluate(_pillAnim);

                return Stack(
                  children: [
                    Positioned(
                      left: pillX + 6,
                      top: 6,
                      child: Container(
                        width: itemWidth - 12,
                        height: 52,
                        decoration: BoxDecoration(
                          color: widget.pillColor,
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(widget.items.length, (i) {
                        final active = i == widget.currentIndex;
                        return Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => widget.onTap(i),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  active
                                      ? widget.items[i].activeIcon
                                      : widget.items[i].icon,
                                  color: active
                                      ? widget.activeColor
                                      : widget.inactiveColor,
                                  size: 22,
                                ),
                                if (widget.items[i].label != null) ...[
                                  const SizedBox(height: 2),
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 200),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: active
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: active
                                          ? widget.activeColor
                                          : widget.inactiveColor,
                                    ),
                                    child: Text(widget.items[i].label!),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _FloatingPillDemo extends StatefulWidget {
  const _FloatingPillDemo();

  @override
  State<_FloatingPillDemo> createState() => _FloatingPillDemoState();
}

class _FloatingPillDemoState extends State<_FloatingPillDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F8),
      body: Center(
        child: Text(
          'Page: ${_demoItems[_index].label}',
          style: const TextStyle(fontSize: 22),
        ),
      ),
      bottomNavigationBar: FloatingPillNavBar(
        items: _demoItems,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// STYLE 2 — ANIMATED ICON WITH SLIDE-UP LABEL
// ═══════════════════════════════════════════════════════

/// Icons are always visible; the label animates up from below
/// when that item becomes active. A small dot indicates active state.
class SlideUpLabelNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  const SlideUpLabelNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = const Color(0xFF00BFA5),
    this.inactiveColor = const Color(0xFFBDBDBD),
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final active = i == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: _SlideUpItem(
                item: items[i],
                active: active,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _SlideUpItem extends StatelessWidget {
  final BottomNavItem item;
  final bool active;
  final Color activeColor;
  final Color inactiveColor;

  const _SlideUpItem({
    required this.item,
    required this.active,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, active ? -4 : 0, 0),
          child: Icon(
            active ? item.activeIcon : item.icon,
            color: active ? activeColor : inactiveColor,
            size: 26,
          ),
        ),
        ClipRect(
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            alignment: Alignment.bottomCenter,
            heightFactor: active ? 1.0 : 0.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                item.label ?? '',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: activeColor,
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(top: 2),
          width: active ? 4 : 0,
          height: active ? 4 : 0,
          decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
        ),
      ],
    );
  }
}

class _SlideUpLabelDemo extends StatefulWidget {
  const _SlideUpLabelDemo();

  @override
  State<_SlideUpLabelDemo> createState() => _SlideUpLabelDemoState();
}

class _SlideUpLabelDemoState extends State<_SlideUpLabelDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page: ${_demoItems[_index].label}',
          style: const TextStyle(fontSize: 22),
        ),
      ),
      bottomNavigationBar: SlideUpLabelNavBar(
        items: _demoItems,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// STYLE 3 — NEON GLOW DARK THEME
// ═══════════════════════════════════════════════════════

/// Dark background with a glowing active indicator.
/// Active icon gets a colored glow shadow effect.
class NeonGlowNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color glowColor;
  final Color backgroundColor;

  const NeonGlowNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.glowColor = const Color(0xFF7C4DFF),
    this.backgroundColor = const Color(0xFF12111A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: glowColor.withOpacity(0.2))),
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final active = i == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: _NeonItem(
                item: items[i],
                active: active,
                glowColor: glowColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NeonItem extends StatelessWidget {
  final BottomNavItem item;
  final bool active;
  final Color glowColor;

  const _NeonItem({
    required this.item,
    required this.active,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? glowColor.withOpacity(0.18) : Colors.transparent,
            boxShadow: active
                ? [
                    BoxShadow(
                      color: glowColor.withOpacity(0.6),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            active ? item.activeIcon : item.icon,
            color: active ? glowColor : const Color(0xFF555565),
            size: 24,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          item.label ?? '',
          style: TextStyle(
            fontSize: 10,
            color: active ? glowColor : const Color(0xFF555565),
            fontWeight: active ? FontWeight.w700 : FontWeight.normal,
            shadows: active
                ? [Shadow(color: glowColor.withOpacity(0.8), blurRadius: 8)]
                : [],
          ),
        ),
      ],
    );
  }
}

class _NeonGlowDemo extends StatefulWidget {
  const _NeonGlowDemo();

  @override
  State<_NeonGlowDemo> createState() => _NeonGlowDemoState();
}

class _NeonGlowDemoState extends State<_NeonGlowDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0C14),
      body: Center(
        child: Text(
          'Page: ${_demoItems[_index].label}',
          style: const TextStyle(fontSize: 22, color: Colors.white70),
        ),
      ),
      bottomNavigationBar: NeonGlowNavBar(
        items: _demoItems,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// STYLE 4 — MINIMAL LINE INDICATOR
// ═══════════════════════════════════════════════════════

/// Ultra-clean: icon only, animated top line slides across.
/// Ideal for content-heavy apps where the bar should stay invisible.
class LineIndicatorNavBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final Color inactiveColor;
  final Color lineColor;
  final Color backgroundColor;

  const LineIndicatorNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor = const Color(0xFF1A1A2E),
    this.inactiveColor = const Color(0xFFBBBBBB),
    this.lineColor = const Color(0xFFE91E63),
    this.backgroundColor = Colors.white,
  });

  @override
  State<LineIndicatorNavBar> createState() => _LineIndicatorNavBarState();
}

class _LineIndicatorNavBarState extends State<LineIndicatorNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _lineAnim;
  int _prev = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _lineAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    _prev = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant LineIndicatorNavBar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _prev = old.currentIndex;
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: widget.backgroundColor,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final itemW = constraints.maxWidth / widget.items.length;
          final lineW = itemW * 0.4;
          return AnimatedBuilder(
            animation: _lineAnim,
            builder: (context, child) {
              final lineX = Tween<double>(
                begin: _prev * itemW + (itemW - lineW) / 2,
                end: widget.currentIndex * itemW + (itemW - lineW) / 2,
              ).evaluate(_lineAnim);

              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: lineX,
                    child: Container(
                      width: lineW,
                      height: 3,
                      decoration: BoxDecoration(
                        color: widget.lineColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(widget.items.length, (i) {
                      final active = i == widget.currentIndex;
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => widget.onTap(i),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                active
                                    ? widget.items[i].activeIcon
                                    : widget.items[i].icon,
                                color: active
                                    ? widget.activeColor
                                    : widget.inactiveColor,
                                size: 22,
                              ),
                              if (widget.items[i].label != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    widget.items[i].label!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: active
                                          ? widget.activeColor
                                          : widget.inactiveColor,
                                      fontWeight: active
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _LineIndicatorDemo extends StatefulWidget {
  const _LineIndicatorDemo();

  @override
  State<_LineIndicatorDemo> createState() => _LineIndicatorDemoState();
}

class _LineIndicatorDemoState extends State<_LineIndicatorDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page: ${_demoItems[_index].label}',
          style: const TextStyle(fontSize: 22),
        ),
      ),
      bottomNavigationBar: LineIndicatorNavBar(
        items: _demoItems,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// SHARED DATA MODEL
// ═══════════════════════════════════════════════════════

/// Simple model to represent a navigation item.
class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String? label;
  final String? badge; // optional badge text e.g. "3"

  const BottomNavItem({
    required this.icon,
    IconData? activeIcon,
    this.label,
    this.badge,
  }) : activeIcon = activeIcon ?? icon;
}

/// Shared demo items used across all style demos.
const _demoItems = [
  BottomNavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'Home',
  ),
  BottomNavItem(
    icon: Icons.search_outlined,
    activeIcon: Icons.search_rounded,
    label: 'Search',
  ),
  BottomNavItem(
    icon: Icons.favorite_outline_rounded,
    activeIcon: Icons.favorite_rounded,
    label: 'Saved',
  ),
  BottomNavItem(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];
