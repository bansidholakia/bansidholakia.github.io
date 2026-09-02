import 'package:flutter/material.dart';

import 'data/portfolio_data.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/portfolio_section.dart';
import 'sections/resume_section.dart';
import 'theme/app_theme.dart';
import 'widgets/responsive.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${PortfolioData.name} • Portfolio',
        theme: buildTheme(),
        home: const PortfolioPage(),
      );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _resumeKey = GlobalKey();
  final _portfolioKey = GlobalKey();
  final _contactKey = GlobalKey();
  bool _isLoading = true;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_handleScroll);

    Future.delayed(
      const Duration(milliseconds: 2400),
          () {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  void _handleScroll() {
    final shouldShow = _scrollController.offset > 500;

    if (shouldShow != _showBackToTop) {
      setState(() {
        _showBackToTop = shouldShow;
      });
    }
  }

  Future<void> _scrollToTop() async {
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _goTo(GlobalKey key) async {
    final sectionContext = key.currentContext;
    if (sectionContext == null) return;
    await Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Scaffold(
      endDrawer: mobile ? _MobileDrawer(onNavigate: _navigate) : null,
      body: Stack(
        children: [
          // ================= PAGE CONTENT =================
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                KeyedSubtree(
                  key: _homeKey,
                  child: HeroSection(
                    onAboutTap: () => _goTo(_aboutKey),
                  ),
                ),
                KeyedSubtree(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),
                KeyedSubtree(
                  key: _resumeKey,
                  child: const ResumeSection(),
                ),
                KeyedSubtree(
                  key: _portfolioKey,
                  child: const PortfolioSection(),
                ),
                KeyedSubtree(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          // ================= TOP NAVIGATION =================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TopNavigation(
              onNavigate: _navigate,
            ),
          ),

          // ================= BACK TO TOP =================
          Positioned(
            right: mobile ? 18 : 30,
            bottom: mobile ? 20 : 30,
            child: IgnorePointer(
              ignoring: !_showBackToTop,
              child: AnimatedOpacity(
                opacity: _showBackToTop ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: AnimatedScale(
                  scale: _showBackToTop ? 1 : .7,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  child: _BackToTopButton(
                    onTap: _scrollToTop,
                  ),
                ),
              ),
            ),
          ),

          // ================= INITIAL LOADER =================
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !_isLoading,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: _isLoading
                    ? const _InitialLoader(
                  key: ValueKey('loader'),
                )
                    : const SizedBox.shrink(
                  key: ValueKey('content'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(String target) {
    final map = <String, GlobalKey>{
      'Home': _homeKey,
      'About': _aboutKey,
      'Resume': _resumeKey,
      'Portfolio': _portfolioKey,
      'Contact': _contactKey,
    };
    final key = map[target];
    if (key != null) _goTo(key);
  }
}

class _TopNavigation extends StatelessWidget {
  const _TopNavigation({required this.onNavigate});

  final ValueChanged<String> onNavigate;

  static const items = ['Home', 'About', 'Resume', 'Portfolio', 'Contact'];

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return Material(
      color: const Color(0xF20A0A0B),
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: .18),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 68,
          child: ContentWidth(
            child: Row(
              children: [
                const Text(
                  PortfolioData.shortName,
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                if (!mobile)
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: TextButton(
                        onPressed: () => onNavigate(item),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 20,
                          ),
                        ),
                        child: Text(
                          item.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFFE4E4E7),
                            fontSize: 11,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (mobile)
                  Builder(
                    builder: (context) => IconButton(
                      tooltip: 'Menu',
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      icon: const Icon(Icons.menu, color: Colors.white),
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

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({required this.onNavigate});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: AppColors.surface,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 12, 16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        PortfolioData.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Close menu',
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              ..._TopNavigation.items.map(
                (item) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  title: Text(item),
                  trailing: const Icon(Icons.chevron_right, size: 18),
                  onTap: () {
                    Navigator.pop(context);
                    onNavigate(item);
                  },
                ),
              ),
            ],
          ),
        ),
      );
}

class _BackToTopButton extends StatefulWidget {
  const _BackToTopButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<_BackToTopButton> createState() =>
      _BackToTopButtonState();
}

class _BackToTopButtonState
    extends State<_BackToTopButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => hovered = true);
      },
      onExit: (_) {
        setState(() => hovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: hovered
                ? AppColors.accent
                : const Color(0xFF222225),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.accent.withValues(
                alpha: hovered ? 1 : .45,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .20),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}

class _InitialLoader extends StatefulWidget {
  const _InitialLoader({super.key});

  @override
  State<_InitialLoader> createState() => _InitialLoaderState();
}

class _InitialLoaderState extends State<_InitialLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0A0B),
      alignment: Alignment.center,
      child: RotationTransition(
        turns: _controller,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring
              SizedBox(
                width: 56,
                height: 56,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  value: .72,
                  backgroundColor:
                  Colors.white.withValues(alpha: .08),
                  color: AppColors.accent,
                  strokeCap: StrokeCap.round,
                ),
              ),

              // Inner ring rotating visually with outer container
              Transform.rotate(
                angle: 3.14,
                child: SizedBox(
                  width: 38,
                  height: 38,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: .45,
                    backgroundColor:
                    Colors.white.withValues(alpha: .06),
                    color: Colors.white.withValues(alpha: .75),
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),

              // Center dot
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}