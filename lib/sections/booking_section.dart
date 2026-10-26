import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/section_title.dart';

class BookingSection extends StatelessWidget {
  final String? initialEventType;

  const BookingSection({super.key, this.initialEventType});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 950;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width < 600 ? 36 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            eyebrow: "— Direct Booking & Inquiries —",
            titlePrefix: "Connect with",
            titleGold: "Balu Saxophonist",
            subtitle:
                "No complicated forms or waiting. Call or WhatsApp directly on 9949008126 to book live performances for weddings, corporate shows, and private galas.",
          ),
          SizedBox(height: width < 600 ? 32 : 48),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildInfoCard(context)),
                      const SizedBox(width: 36),
                      Expanded(flex: 6, child: _buildDirectActionCard(context)),
                    ],
                  )
                : Column(
                    children: [
                      _buildDirectActionCard(context),
                      const SizedBox(height: 36),
                      _buildInfoCard(context),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectActionCard(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      padding: EdgeInsets.all(width < 420 ? 16 : (width < 600 ? 22 : 32)),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 36,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.phone_in_talk_rounded,
                  color: Color(0xFF0A0F1D),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DIRECT CONTACT",
                      style: TextStyle(
                        fontFamily: AppTheme.fontInter,
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Instant Booking & Inquiries",
                      style: TextStyle(
                        fontFamily: AppTheme.fontPlayfair,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Main Call to Action Box: 9949008126
          InkWell(
            onTap: () => UrlHelper.launchPhone(context, BaluSaxData.phoneDigits),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width < 420 ? 14 : 22,
                vertical: width < 420 ? 14 : 18,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.18),
                    AppColors.secondary.withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(width < 420 ? 10 : 14),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.call_rounded,
                      color: const Color(0xFF0A0F1D),
                      size: width < 420 ? 22 : 28,
                    ),
                  ),
                  SizedBox(width: width < 420 ? 12 : 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TAP TO CALL DIRECTLY",
                          style: TextStyle(
                            fontFamily: AppTheme.fontInter,
                            color: AppColors.primaryLight,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            BaluSaxData.phoneDisplay,
                            style: TextStyle(
                              fontFamily: AppTheme.fontInter,
                              color: Colors.white,
                              fontSize: width < 420 ? 22 : 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Main WhatsApp Box: 9949008126
          InkWell(
            onTap: () => UrlHelper.launchWhatsApp(
              context,
              BaluSaxData.phoneDigits,
              "Hello Balu Saxophonist! I want to check your availability for an upcoming live performance.",
            ),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width < 420 ? 14 : 22,
                vertical: width < 420 ? 14 : 18,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF25D366).withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF25D366).withOpacity(0.6), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(width < 420 ? 10 : 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.chat_rounded,
                      color: Colors.white,
                      size: width < 420 ? 22 : 28,
                    ),
                  ),
                  SizedBox(width: width < 420 ? 12 : 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TAP TO CHAT ON WHATSAPP",
                          style: TextStyle(
                            fontFamily: AppTheme.fontInter,
                            color: Color(0xFF25D366),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "+91 99490 08126",
                            style: TextStyle(
                              fontFamily: AppTheme.fontInter,
                              color: Colors.white,
                              fontSize: width < 420 ? 19 : 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF25D366), size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Main Email Box: balarajuipparthi1234@gmail.com
          InkWell(
            onTap: () => UrlHelper.launchEmail(
              context,
              BaluSaxData.email,
              subject: "Live Saxophone Performance Booking Inquiry",
            ),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width < 420 ? 14 : 22,
                vertical: width < 420 ? 14 : 18,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(width < 420 ? 10 : 14),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.mail_rounded,
                      color: const Color(0xFF0A0F1D),
                      size: width < 420 ? 22 : 28,
                    ),
                  ),
                  SizedBox(width: width < 420 ? 12 : 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TAP TO SEND EMAIL",
                          style: TextStyle(
                            fontFamily: AppTheme.fontInter,
                            color: AppColors.primaryLight,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            BaluSaxData.email,
                            style: TextStyle(
                              fontFamily: AppTheme.fontInter,
                              color: Colors.white,
                              fontSize: width < 420 ? 15 : 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.primary, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Location Box: Hyd, Vizag, Mumbai, India
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width < 420 ? 14 : 22,
              vertical: width < 420 ? 14 : 18,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderCyan, width: 1.2),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(width < 420 ? 10 : 14),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.white,
                    size: width < 420 ? 22 : 28,
                  ),
                ),
                SizedBox(width: width < 420 ? 12 : 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "PERFORMANCE LOCATIONS",
                        style: TextStyle(
                          fontFamily: AppTheme.fontInter,
                          color: AppColors.secondaryLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          BaluSaxData.location,
                          style: TextStyle(
                            fontFamily: AppTheme.fontInter,
                            color: Colors.white,
                            fontSize: width < 420 ? 16 : 19,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Direct Actions
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 440;
              return isNarrow
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: "Call: 9949008126",
                            icon: Icons.phone_forwarded_rounded,
                            variant: ButtonVariant.gold,
                            onPressed: () => UrlHelper.launchPhone(context, BaluSaxData.phoneDigits),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: "WhatsApp: 9949008126",
                            icon: Icons.chat_bubble_outline_rounded,
                            variant: ButtonVariant.outline,
                            onPressed: () => UrlHelper.launchWhatsApp(
                              context,
                              BaluSaxData.phoneDigits,
                              "Hello Balu Saxophonist! Inquiring about performance booking.",
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: "Call: 9949008126",
                            icon: Icons.phone_forwarded_rounded,
                            variant: ButtonVariant.gold,
                            onPressed: () => UrlHelper.launchPhone(context, BaluSaxData.phoneDigits),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: CustomButton(
                            text: "WhatsApp",
                            icon: Icons.chat_bubble_outline_rounded,
                            variant: ButtonVariant.outline,
                            onPressed: () => UrlHelper.launchWhatsApp(
                              context,
                              BaluSaxData.phoneDigits,
                              "Hello Balu Saxophonist! Inquiring about performance booking.",
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "A Soulful Stage Experience",
          style: TextStyle(
            fontFamily: AppTheme.fontPlayfair,
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Whether you are planning an intimate wedding reception, a high-profile corporate gala, or a vibrant stage celebration, Balu Saxophonist crafts music that connects with every guest.",
          style: TextStyle(
            fontFamily: AppTheme.fontInter,
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.7,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 24),

        // Info List
        _buildHighlight(
          Icons.verified_rounded,
          "Over 6+ Years & 150+ Live Shows",
          "Years of trusted stage performance across premier venues, luxury palaces, and destination events.",
        ),
        const SizedBox(height: 14),
        _buildHighlight(
          Icons.library_music_rounded,
          "Curated Multi-Genre Repertoire",
          "Soulful romantic melodies, energetic live stage hits, and classic instrumentals.",
        ),
        const SizedBox(height: 14),
        _buildHighlight(
          Icons.public_rounded,
          "Performance Locations",
          "Hyd, Vizag, Mumbai, India. Available across all three cities for live performances, weddings & concerts.",
        ),
        const SizedBox(height: 14),
        _buildHighlight(
          Icons.email_outlined,
          "Official Email Address",
          BaluSaxData.email,
          onTap: () => UrlHelper.launchEmail(context, BaluSaxData.email, subject: "Live Saxophone Performance Inquiry"),
        ),
      ],
    );
  }

  Widget _buildHighlight(IconData icon, String title, String description, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderCyan),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontInter,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontInter,
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 8),
              const Icon(Icons.arrow_outward_rounded, size: 16, color: AppColors.primary),
            ],
          ],
        ),
      ),
    );
  }
}
