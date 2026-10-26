import 'package:flutter/material.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/section_title.dart';

class EventsSection extends StatelessWidget {
  final Function(String eventTitle)? onReserveEvent;

  const EventsSection({super.key, this.onReserveEvent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            eyebrow: "— Upcoming Events —",
            titlePrefix: "Catch Him",
            titleGold: "Live",
            subtitle:
                "Experience the acoustic presence and melodic soul of live saxophone in premier concert halls, palaces, and private gatherings.",
          ),
          const SizedBox(height: 48),

          // Events list
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: BaluSaxData.upcomingEvents.length,
              separatorBuilder: (context, index) => const SizedBox(height: 18),
              itemBuilder: (context, index) {
                final event = BaluSaxData.upcomingEvents[index];
                return _EventRow(
                  event: event,
                  onReserve: () {
                    if (onReserveEvent != null) {
                      onReserveEvent!("${event.title} (${event.venue})");
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EventRow extends StatefulWidget {
  final EventItem event;
  final VoidCallback onReserve;

  const _EventRow({required this.event, required this.onReserve});

  @override
  State<_EventRow> createState() => _EventRowState();
}

class _EventRowState extends State<_EventRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(_isHovered ? 6.0 : 0.0, 0.0, 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceCard : AppColors.surface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? AppColors.gold : AppColors.goldLine,
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? AppColors.gold.withOpacity(0.18) : Colors.black.withOpacity(0.2),
              blurRadius: 18,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildDateBadge(event),
                      const SizedBox(width: 16),
                      Expanded(child: _buildEventInfo(event)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Reserve Seat",
                      variant: ButtonVariant.ghostSmall,
                      onPressed: widget.onReserve,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  _buildDateBadge(event),
                  const SizedBox(width: 24),
                  Expanded(child: _buildEventInfo(event)),
                  const SizedBox(width: 20),
                  CustomButton(
                    text: "Reserve",
                    variant: ButtonVariant.ghostSmall,
                    onPressed: widget.onReserve,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDateBadge(EventItem event) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gold.withOpacity(0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            event.day,
            style: const TextStyle(
              fontFamily: AppTheme.fontPlayfair,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.gold,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            event.month.toUpperCase(),
            style: const TextStyle(
              fontFamily: AppTheme.fontInter,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfo(EventItem event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: TextStyle(
            fontFamily: AppTheme.fontPlayfair,
            color: _isHovered ? AppColors.goldLight : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 14, color: AppColors.gold),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                "${event.venue} · ${event.location}",
                style: const TextStyle(
                  fontFamily: AppTheme.fontInter,
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
