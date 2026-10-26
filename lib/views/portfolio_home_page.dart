import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../core/utils/url_helper.dart';
import '../sections/about_section.dart';
import '../sections/booking_section.dart';
import '../sections/hero_section.dart';
import '../sections/instagram_section.dart';
import '../sections/music_section.dart';
import '../sections/testimonials_section.dart';
import '../sections/videos_section.dart';
import '../widgets/animated_music_bg.dart';
import '../widgets/footer.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/navbar.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _musicKey = GlobalKey();
  final GlobalKey _videosKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _instagramKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  int _activeNavIndex = 0;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (offset <= 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  void _scrollToSection(int index) {
    if (index == -1 || index == 0) {
      setState(() => _activeNavIndex = 0);
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
      return;
    }

    GlobalKey targetKey;
    switch (index) {
      case 1:
        targetKey = _aboutKey;
        break;
      case 2:
        targetKey = _musicKey;
        break;
      case 3:
        targetKey = _videosKey;
        break;
      case 4:
        targetKey = _testimonialsKey;
        break;
      case 5:
        targetKey = _instagramKey;
        break;
      case 6:
        targetKey = _contactKey;
        break;
      default:
        targetKey = _heroKey;
        break;
    }

    setState(() => _activeNavIndex = index);

    final targetContext = targetKey.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: MobileDrawer(
        activeIndex: _activeNavIndex,
        onNavItemSelected: _scrollToSection,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_showBackToTop) ...[
            FloatingActionButton.small(
              heroTag: "backToTopFab",
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primary,
              tooltip: "Back to Top",
              onPressed: () => _scrollToSection(-1),
              child: const Icon(Icons.arrow_upward_rounded),
            ),
            const SizedBox(height: 12),
          ],
          Builder(
            builder: (ctx) {
              final isSmall = MediaQuery.sizeOf(ctx).width < 380;
              if (isSmall) {
                return FloatingActionButton(
                  heroTag: "whatsappFab",
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  tooltip: "Chat directly on WhatsApp (9949008126)",
                  onPressed: () => UrlHelper.launchWhatsApp(
                    context,
                    BaluSaxData.phoneDigits,
                    "Hello Balu Saxophonist! Inquiring about live performance booking.",
                  ),
                  child: const Icon(Icons.chat_rounded, size: 22),
                );
              }
              return FloatingActionButton.extended(
                heroTag: "whatsappFab",
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.chat_rounded, size: 20),
                label: const Text(
                  "WhatsApp",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                tooltip: "Chat directly on WhatsApp (9949008126)",
                onPressed: () => UrlHelper.launchWhatsApp(
                  context,
                  BaluSaxData.phoneDigits,
                  "Hello Balu Saxophonist! Inquiring about live performance booking.",
                ),
              );
            },
          ),
        ],
      ),
      body: AnimatedMusicBg(
        child: Stack(
          children: [
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Navbar height spacing
                    const SizedBox(height: 78),

                    // Main Container with responsive padding
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.horizontalPadding(context),
                      ),
                      child: Column(
                        children: [
                          // 0. Hero Section (Branding, Spotlight, Motto, Data, Direct Call: 9949008126)
                          Container(
                            key: _heroKey,
                            child: HeroSection(
                              onScrollDown: () => _scrollToSection(1),
                              onWatchVideos: () => _scrollToSection(3),
                            ),
                          ),

                          // 1. About the Artist (Narrative, Authentic Photos, 10+ Years, 200+ Shows, Repertoire)
                          Container(
                            key: _aboutKey,
                            child: const AboutSection(),
                          ),

                          // 2. Music / Signature Sets (Romantic Melodies, High Energy Hits, Concerts)
                          Container(
                            key: _musicKey,
                            child: MusicSection(
                              onSetSelected: (_) => _scrollToSection(6),
                            ),
                          ),

                          // 3. Videos Section (Authentic live videos from assets/videos)
                          Container(
                            key: _videosKey,
                            child: const VideosSection(),
                          ),

                          // 4. Testimonials Section (Audience & Client Reviews)
                          Container(
                            key: _testimonialsKey,
                            child: const TestimonialsSection(),
                          ),

                          // 6. Instagram Section (Active link to balu_music_vibes_)
                          Container(
                            key: _instagramKey,
                            child: const InstagramSection(),
                          ),

                          // 7. Direct Contact Card (Call 9949008126, WhatsApp 9949008126)
                          Container(
                            key: _contactKey,
                            child: const BookingSection(),
                          ),

                          const SizedBox(height: 60),
                        ],
                      ),
                    ),

                    // Footer
                    Footer(
                      onBackToTop: () => _scrollToSection(-1),
                      onNavItemSelected: _scrollToSection,
                    ),
                  ],
                ),
              ),
            ),

            // Sticky Glass Luxury Navbar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Navbar(
                activeIndex: _activeNavIndex,
                onNavItemSelected: _scrollToSection,
                onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
