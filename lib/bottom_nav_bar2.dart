import 'package:flutter/material.dart';

// Package imports (add to pubspec.yaml before using)
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// ─────────────────────────────────────────────────────────────
//  RESTAURANT NAV ITEMS — shared across all styles
// ─────────────────────────────────────────────────────────────

const _restaurantItems = [
  _RmsNavItem(
    icon: Icons.table_restaurant_outlined,
    activeIcon: Icons.table_restaurant,
    label: 'Tables',
    badge: null,
  ),
  _RmsNavItem(
    icon: Icons.receipt_long_outlined,
    activeIcon: Icons.receipt_long,
    label: 'Orders',
    badge: '5',
  ),
  _RmsNavItem(
    icon: Icons.menu_book_outlined,
    activeIcon: Icons.menu_book,
    label: 'Menu',
    badge: null,
  ),
  _RmsNavItem(
    icon: Icons.kitchen_outlined,
    activeIcon: Icons.kitchen,
    label: 'Kitchen',
    badge: '3',
  ),
  // _RmsNavItem(
  //   icon: Icons.bar_chart_outlined,
  //   activeIcon: Icons.bar_chart,
  //   label: 'Reports',
  //   badge: null,
  // ),
];

class _RmsNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String? badge;
  const _RmsNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.badge,
  });
}

// ─────────────────────────────────────────────────────────────
//  DEMO APP
// ─────────────────────────────────────────────────────────────

class RmsApp extends StatelessWidget {
  const RmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RMS Nav Bars',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const StyleChooser(),
    );
  }
}

class StyleChooser extends StatefulWidget {
  const StyleChooser({super.key});

  @override
  State<StyleChooser> createState() => _StyleChooserState();
}

class _StyleChooserState extends State<StyleChooser> {
  int _style = 0;

  static const _styles = [
    'Salomon Bar',
    'Curved Bar',
    'Navy Bar',
    'Animated FAB',
    'Google Nav Bar',
    'Water Drop',
    'Badge Notch (custom)',
    'Glassmorphic (custom)',
    'Chef Hat (custom)',
    'POS Dark (custom)',
  ];

  static const _descriptions = [
    'salomon_bottom_bar — pill-shaped label reveal',
    'curved_navigation_bar — wave cutout effect',
    'bottom_navy_bar — icon + label with progress',
    'animated_bottom_navigation_bar — FAB + animated icons',
    'google_nav_bar — Material You style',
    'water_drop_nav_bar — water drop indicator',
    'Custom — notification badges + floating notch',
    'Custom — frosted glass dark theme',
    'Custom — restaurant-themed icon shapes',
    'Custom — POS terminal dark UI',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Nav Bars'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Row(
                  children: List.generate(_styles.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_styles[i]),
                        selected: i == _style,
                        onSelected: (_) => setState(() => _style = i),
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _descriptions[_style],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
      body: [
        const _SalomonDemo(),
        const _CurvedDemo(),
        const _NavyDemo(),
        const _AnimatedFabDemo(),
        const _GoogleNavDemo(),
        const _WaterDropDemo(),
        const _BadgeNotchDemo(),
        const _GlassmorphicDemo(),
        const _ChefHatDemo(),
        const _PosDarkDemo(),
      ][_style],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 1. SALOMON BOTTOM BAR  (package: salomon_bottom_bar)
// ════════════════════════════════════════════════════════════════
/// Sliding pill reveals label on active item.
/// Clean and unobtrusive — great for table staff tablets.

class _SalomonDemo extends StatefulWidget {
  const _SalomonDemo();

  @override
  State<_SalomonDemo> createState() => _SalomonDemoState();
}

class _SalomonDemoState extends State<_SalomonDemo> {
  int _index = 0;

  static const _colors = [
    Color(0xFFE65100),
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFB71C1C),
    // Color(0xFF4527A0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F4),
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        backgroundColor: Colors.white,
        items: List.generate(_restaurantItems.length, (i) {
          return SalomonBottomBarItem(
            icon: Icon(_restaurantItems[i].icon),
            activeIcon: Icon(_restaurantItems[i].activeIcon),
            title: Text(_restaurantItems[i].label),
            selectedColor: _colors[i],
            unselectedColor: Colors.grey,
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 2. CURVED NAVIGATION BAR  (package: curved_navigation_bar)
// ════════════════════════════════════════════════════════════════
/// Animated wave cutout under active icon.
/// Bold, fun — great for customer-facing kiosk displays.

class _CurvedDemo extends StatefulWidget {
  const _CurvedDemo();

  @override
  State<_CurvedDemo> createState() => _CurvedDemoState();
}

class _CurvedDemoState extends State<_CurvedDemo> {
  int _index = 0;
  final _key = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFFFF3E0),
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: CurvedNavigationBar(
        key: _key,
        index: _index,
        height: 60,
        color: const Color(0xFFBF360C),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xFFE64A19),
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        items: _restaurantItems
            .map((e) => Icon(e.activeIcon, color: Colors.white, size: 28))
            .toList(),
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 3. BOTTOM NAVY BAR  (package: bottom_navy_bar)
// ════════════════════════════════════════════════════════════════
/// Smooth icon + label transition with indicator.
/// Professional look suited to manager dashboards.

class _NavyDemo extends StatefulWidget {
  const _NavyDemo();

  @override
  State<_NavyDemo> createState() => _NavyDemoState();
}

class _NavyDemoState extends State<_NavyDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _index,
        showElevation: true,
        backgroundColor: const Color(0xFF1A237E),
        onItemSelected: (i) => setState(() => _index = i),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.table_restaurant),
            title: const Text('Tables'),
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.white54,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.receipt_long),
            title: const Text('Orders'),
            activeColor: Colors.greenAccent,
            inactiveColor: Colors.white54,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.menu_book),
            title: const Text('Menu'),
            activeColor: Colors.pinkAccent,
            inactiveColor: Colors.white54,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.kitchen),
            title: const Text('Kitchen'),
            activeColor: Colors.cyanAccent,
            inactiveColor: Colors.white54,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.bar_chart),
            title: const Text('Reports'),
            activeColor: Colors.purpleAccent,
            inactiveColor: Colors.white54,
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 4. ANIMATED BOTTOM NAVIGATION BAR  (package: animated_bottom_navigation_bar)
// ════════════════════════════════════════════════════════════════
/// Central FAB + 4 items on either side with animated icons.
/// Ideal when a primary action (new order) needs prominence.

class _AnimatedFabDemo extends StatefulWidget {
  const _AnimatedFabDemo();

  @override
  State<_AnimatedFabDemo> createState() => _AnimatedFabDemoState();
}

class _AnimatedFabDemoState extends State<_AnimatedFabDemo> {
  int _index = 0;

  static const _icons = [
    Icons.table_restaurant,
    Icons.receipt_long,
    Icons.kitchen,
    Icons.bar_chart,
  ];

  static const _labels = ['Tables', 'Orders', 'Kitchen', 'Reports'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF0E6),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD84315),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('New Order'))),
      ),
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icons,
        activeIndex: _index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: Colors.white,
        activeColor: const Color(0xFFD84315),
        inactiveColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 5. GOOGLE NAV BAR  (package: google_nav_bar)
// ════════════════════════════════════════════════════════════════
/// Material You pill-based nav with icon+label pill on active.
/// Best for modern Android-first RMS apps.

class _GoogleNavDemo extends StatefulWidget {
  const _GoogleNavDemo();

  @override
  State<_GoogleNavDemo> createState() => _GoogleNavDemoState();
}

class _GoogleNavDemoState extends State<_GoogleNavDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.orange[100]!,
              hoverColor: Colors.orange[100]!,
              haptic: true,
              tabBorderRadius: 16,
              duration: const Duration(milliseconds: 400),
              gap: 8,
              color: Colors.grey[700]!,
              activeColor: Colors.white,
              iconSize: 24,
              tabBackgroundColor: const Color(0xFFE64A19),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              selectedIndex: _index,
              onTabChange: (i) => setState(() => _index = i),
              tabs: _restaurantItems
                  .map((e) => GButton(icon: e.icon, text: e.label))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 6. WATER DROP NAV BAR  (package: water_drop_nav_bar)
// ════════════════════════════════════════════════════════════════
/// Animated water drop blob indicator over active icon.
/// Eye-catching for front-of-house staff apps.

class _WaterDropDemo extends StatefulWidget {
  const _WaterDropDemo();

  @override
  State<_WaterDropDemo> createState() => _WaterDropDemoState();
}

class _WaterDropDemoState extends State<_WaterDropDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        waterDropColor: const Color(0xFF00695C),
        onItemSelected: (i) => setState(() => _index = i),
        selectedIndex: _index,
        barItems: _restaurantItems
            .map((e) => BarItem(filledIcon: e.activeIcon, outlinedIcon: e.icon))
            .toList(),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 7. CUSTOM — BADGE NOTCH NAV BAR
// ════════════════════════════════════════════════════════════════
/// Custom-built. Floating notch for the central action button,
/// notification badges on Orders and Kitchen.
/// Best for busy restaurant floors where staff need alerts.

class _BadgeNotchDemo extends StatefulWidget {
  const _BadgeNotchDemo();

  @override
  State<_BadgeNotchDemo> createState() => _BadgeNotchDemoState();
}

class _BadgeNotchDemoState extends State<_BadgeNotchDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF6F00),
        elevation: 4,
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
        onPressed: () {},
      ),
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: BadgeNotchNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class BadgeNotchNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BadgeNotchNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (
      icon: Icons.table_restaurant_outlined,
      active: Icons.table_restaurant,
      label: 'Tables',
      badge: null,
    ),
    (
      icon: Icons.receipt_long_outlined,
      active: Icons.receipt_long,
      label: 'Orders',
      badge: '5',
    ),
    (
      icon: Icons.kitchen_outlined,
      active: Icons.kitchen,
      label: 'Kitchen',
      badge: '3',
    ),
    (
      icon: Icons.bar_chart_outlined,
      active: Icons.bar_chart,
      label: 'Reports',
      badge: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      elevation: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ..._items
                .sublist(0, 2)
                .asMap()
                .entries
                .map(
                  (e) => _BadgeItem(
                    item: _items[e.key],
                    active: currentIndex == e.key,
                    onTap: () => onTap(e.key),
                  ),
                ),
            const SizedBox(width: 48), // FAB gap
            ..._items
                .sublist(2)
                .asMap()
                .entries
                .map(
                  (e) => _BadgeItem(
                    item: _items[e.key + 2],
                    active: currentIndex == e.key + 2,
                    onTap: () => onTap(e.key + 2),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final ({IconData icon, IconData active, String label, String? badge}) item;
  final bool active;
  final VoidCallback onTap;

  const _BadgeItem({
    required this.item,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: active
                  ? const Color(0xFFFF6F00).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  active ? item.active : item.icon,
                  color: active ? const Color(0xFFFF6F00) : Colors.grey,
                  size: 22,
                ),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: active ? const Color(0xFFFF6F00) : Colors.grey,
                    fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          if (item.badge != null)
            Positioned(
              top: -2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 8. CUSTOM — GLASSMORPHIC DARK NAV BAR
// ════════════════════════════════════════════════════════════════
/// Frosted glass dark nav bar with blur effect and glowing active indicator.
/// Suitable for upscale restaurants or nighttime bar management.

class _GlassmorphicDemo extends StatefulWidget {
  const _GlassmorphicDemo();

  @override
  State<_GlassmorphicDemo> createState() => _GlassmorphicDemoState();
}

class _GlassmorphicDemoState extends State<_GlassmorphicDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A14),
      extendBody: true,
      body: _PageBody(index: _index, items: _restaurantItems, dark: true),
      bottomNavigationBar: GlassmorphicNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class GlassmorphicNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GlassmorphicNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _accentColor = Color(0xFFFF6B35);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Row(
            children: List.generate(_restaurantItems.length, (i) {
              final active = i == currentIndex;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: active
                          ? _accentColor.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                      border: active
                          ? Border.all(
                              color: _accentColor.withOpacity(0.4),
                              width: 0.5,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          active
                              ? _restaurantItems[i].activeIcon
                              : _restaurantItems[i].icon,
                          color: active ? _accentColor : Colors.white38,
                          size: 22,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _restaurantItems[i].label,
                          style: TextStyle(
                            fontSize: 9,
                            color: active ? _accentColor : Colors.white38,
                            fontWeight: active
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 9. CUSTOM — CHEF HAT THEMED NAV BAR
// ════════════════════════════════════════════════════════════════
/// Custom restaurant-themed nav bar with warm colour palette,
/// custom indicator shape, and handcrafted icon containers.
/// Best for branded restaurant chain apps.

class _ChefHatDemo extends StatefulWidget {
  const _ChefHatDemo();

  @override
  State<_ChefHatDemo> createState() => _ChefHatDemoState();
}

class _ChefHatDemoState extends State<_ChefHatDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: _PageBody(index: _index, items: _restaurantItems),
      bottomNavigationBar: ChefHatNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class ChefHatNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ChefHatNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _warmOrange = Color(0xFFE65100);
  static const _warmCream = Color(0xFFFFF8F0);
  static const _darkChocolate = Color(0xFF3E1F00);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: _darkChocolate,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: _darkChocolate.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_restaurantItems.length, (i) {
          final active = i == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    width: active ? 48 : 36,
                    height: active ? 48 : 36,
                    decoration: BoxDecoration(
                      color: active ? _warmOrange : Colors.transparent,
                      borderRadius: active
                          ? BorderRadius.circular(14)
                          : BorderRadius.circular(10),
                    ),
                    child: Icon(
                      active
                          ? _restaurantItems[i].activeIcon
                          : _restaurantItems[i].icon,
                      color: active ? Colors.white : Colors.white38,
                      size: active ? 24 : 20,
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: active ? 10 : 0,
                      color: _warmCream,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Text(_restaurantItems[i].label),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 10. CUSTOM — POS DARK TERMINAL NAV BAR
// ════════════════════════════════════════════════════════════════
/// Inspired by POS terminal screens. Dark, high-contrast,
/// segmented buttons with sharp corners and accent highlight.
/// Best for kitchen display systems and back-of-house tablets.

class _PosDarkDemo extends StatefulWidget {
  const _PosDarkDemo();

  @override
  State<_PosDarkDemo> createState() => _PosDarkDemoState();
}

class _PosDarkDemoState extends State<_PosDarkDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: _PageBody(index: _index, items: _restaurantItems, dark: true),
      bottomNavigationBar: PosNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class PosNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PosNavBar({super.key, required this.currentIndex, required this.onTap});

  static const _bg = Color(0xFF161B22);
  static const _border = Color(0xFF30363D);
  static const _activeColor = Color(0xFF58A6FF);
  static const _activeBg = Color(0xFF1F2D3D);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: _bg,
      child: Row(
        children: List.generate(_restaurantItems.length, (i) {
          final active = i == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: active ? _activeBg : Colors.transparent,
                  border: Border(
                    top: BorderSide(
                      color: active ? _activeColor : Colors.transparent,
                      width: 2,
                    ),
                    right: BorderSide(color: _border, width: 0.5),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            active
                                ? _restaurantItems[i].activeIcon
                                : _restaurantItems[i].icon,
                            color: active ? _activeColor : Colors.white24,
                            size: 20,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _restaurantItems[i].label.toUpperCase(),
                            style: TextStyle(
                              fontSize: 8,
                              letterSpacing: 1,
                              color: active ? _activeColor : Colors.white24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Badge
                    if (_restaurantItems[i].badge != null)
                      Positioned(
                        top: 8,
                        right: 12,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.red.shade700,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _restaurantItems[i].badge!,
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SHARED PAGE BODY WIDGET
// ─────────────────────────────────────────────────────────────

class _PageBody extends StatelessWidget {
  final int index;
  final List<_RmsNavItem> items;
  final bool dark;

  const _PageBody({
    required this.index,
    required this.items,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    final item = items[index];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.activeIcon,
            size: 64,
            color: dark ? Colors.white38 : Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w300,
              color: dark ? Colors.white54 : Colors.grey.shade500,
              letterSpacing: 2,
            ),
          ),
          if (item.badge != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${item.badge} pending',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
