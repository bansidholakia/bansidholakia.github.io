import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/section_heading.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final mobile = width < Breakpoints.mobile;
    final educationMobile = width < 850;

    return ColoredBox(
      color: const Color(0xFFF1F1F2),
      child: ContentWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 96),
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Resume',
                title: 'My journey so far',
                subtitle:
                    'A snapshot of the roles, products and learning that shaped how I build mobile software.',
                dark: false,
              ),
              const SizedBox(height: 64),
              const _ResumeTitle(title: 'Work Experience'),
              const SizedBox(height: 28),
              for (var index = 0;
              index < PortfolioData.experience.length;
              index++)
                _ExperienceCard(
                  PortfolioData.experience[index],
                  showDesktopRail: !mobile,
                  isFirst: index == 0,
                  isLast: index == PortfolioData.experience.length - 1,
                ),
              const SizedBox(height: 64),
              const _ResumeTitle(title: 'Education'),
              const SizedBox(height: 34),
              _EducationTimeline(
                items: PortfolioData.education,
                mobile: educationMobile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeTitle extends StatelessWidget {
  const _ResumeTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard(
      this.item, {
        required this.showDesktopRail,
        required this.isFirst,
        required this.isLast,
      });

  final Experience item;
  final bool showDesktopRail;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) => _TimelineCard(
    period: item.period,
    title: item.role,
    subtitle: '${item.company} • ${item.location}',
    points: item.points,
    showDesktopRail: showDesktopRail,
    isFirst: isFirst,
    isLast: isLast,
  );
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.period,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.showDesktopRail,
    required this.isFirst,
    required this.isLast,
  });

  final String period;
  final String title;
  final String subtitle;
  final List<String> points;
  final bool showDesktopRail;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final mobile =
        MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    // ---------------- MOBILE ----------------
    if (mobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE4E4E7),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                period,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              _TimelineContent(
                title: title,
                subtitle: subtitle,
                points: points,
              ),
            ],
          ),
        ),
      );
    }

    // ---------------- DESKTOP ----------------

    const cardPadding = 30.0;
    const periodWidth = 190.0;
    const railWidth = 64.0;
    const markerSize = 40.0;

    // Center of timeline rail
    const railCenterX =
        cardPadding + periodWidth + (railWidth / 2);

    // Marker center vertically
    const markerCenterY =
        cardPadding + (markerSize / 2);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ================= CARD =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(cardPadding),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE4E4E7),
              ),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date
                SizedBox(
                  width: periodWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      period,
                      softWrap: true,
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                // Empty space reserved for timeline
                const SizedBox(
                  width: railWidth,
                ),

                // Experience content
                Expanded(
                  child: _TimelineContent(
                    title: title,
                    subtitle: subtitle,
                    points: points,
                  ),
                ),
              ],
            ),
          ),

          // ================= TIMELINE =================

          if (showDesktopRail) ...[
            // Line coming from previous card
            if (!isFirst)
              Positioned(
                left: railCenterX - 0.75,
                top: -20,
                height: markerCenterY + 20,
                child: Container(
                  width: 1.5,
                  color: const Color(0xFFC8C8CC),
                ),
              ),

            // Line going to next card
            if (!isLast)
              Positioned(
                left: railCenterX - 0.75,
                top: markerCenterY,
                bottom: -20,
                child: Container(
                  width: 1.5,
                  color: const Color(0xFFC8C8CC),
                ),
              ),

            // Work icon
            Positioned(
              left: railCenterX - (markerSize / 2),
              top: cardPadding,
              child: Container(
                width: markerSize,
                height: markerSize,
                decoration: BoxDecoration(
                  color: const Color(0xFF313131),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                child: const Icon(
                  Icons.work_outline,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimelineContent extends StatelessWidget {
  const _TimelineContent({
    required this.title,
    required this.subtitle,
    required this.points,
  });

  final String title;
  final String subtitle;
  final List<String> points;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF18181B),
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF71717A),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...points.map(
                (point) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      point,
                      softWrap: true,
                      style: const TextStyle(
                        color: Color(0xFF52525B),
                        fontSize: 14,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
                              ),
                            ),
          ),
        ],
      );
}

class _EducationTimeline extends StatelessWidget {
  const _EducationTimeline({required this.items, required this.mobile});

  final List<EducationItem> items;
  final bool mobile;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          for (var index = 0; index < items.length; index++)
            _EducationTimelineItem(
              item: items[index],
              mobile: mobile,
              isLast: index == items.length - 1,
            ),
        ],
      );
}

class _EducationTimelineItem extends StatelessWidget {
  const _EducationTimelineItem({
    required this.item,
    required this.mobile,
    required this.isLast,
  });

  final EducationItem item;
  final bool mobile;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return _buildMobile();
    }

    return _buildDesktop();
  }

  Widget _buildMobile() {
    const railWidth = 48.0;
    const markerSize = 36.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ================= CONTENT =================
        Padding(
          padding: EdgeInsets.only(
            bottom: isLast ? 0 : 42,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reserve space for timeline
              const SizedBox(
                width: railWidth,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _EducationContent(
                  item: item,
                  mobile: true,
                ),
              ),
            ],
          ),
        ),

        // ================= TIMELINE LINE =================
        if (!isLast)
          Positioned(
            left: (railWidth / 2) - 0.5,
            top: markerSize / 2,
            bottom: 0,
            child: Container(
              width: 1,
              color: const Color(0xFFD0D0D2),
            ),
          ),

        // ================= MARKER =================
        Positioned(
          left: (railWidth - markerSize) / 2,
          top: 0,
          child: Container(
            width: markerSize,
            height: markerSize,
            decoration: const BoxDecoration(
              color: Color(0xFF313131),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktop() {
    const railWidth = 72.0;
    const markerSize = 48.0;
    const bottomSpacing = 50.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Remaining width after removing the fixed timeline column.
        final usableWidth = constraints.maxWidth > railWidth
            ? constraints.maxWidth - railWidth
            : 0.0;

        // Your layout uses flex 35 / 65.
        final leftWidth = usableWidth * 0.35;

        // Center of the timeline column.
        final railCenterX =
            leftWidth + (railWidth / 2);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.only(
                bottom: bottomSpacing,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT - Degree + Date
                  Expanded(
                    flex: 35,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                        right: 44,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.degree,
                            textAlign: TextAlign.right,
                            softWrap: true,
                            style: const TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            item.period,
                            textAlign: TextAlign.right,
                            softWrap: true,
                            style: const TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Reserve timeline space
                  const SizedBox(
                    width: railWidth,
                  ),

                  // RIGHT - School + Details
                  Expanded(
                    flex: 65,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                      ),
                      child: _EducationContent(
                        item: item,
                        mobile: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================= TIMELINE LINE =================

            Positioned(
              left: railCenterX - 0.5,
              top: markerSize / 2,

              // Last item stops before bottom spacing.
              // Other items continue through the spacing,
              // connecting to the next education item.
              bottom: isLast ? bottomSpacing : 0,

              child: Container(
                width: 1,
                color: const Color(0xFFD0D0D2),
              ),
            ),

            // ================= MARKER =================
            Positioned(
              left: railCenterX - (markerSize / 2),
              top: 0,
              child: Container(
                width: markerSize,
                height: markerSize,
                decoration: const BoxDecoration(
                  color: Color(0xFF313131),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.school_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EducationContent extends StatelessWidget {
  const _EducationContent({
    required this.item,
    required this.mobile,
  });

  final EducationItem item;
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (mobile) ...[
          Text(
            item.degree,
            softWrap: true,
            style: const TextStyle(
              color: Color(0xFF313131),
              fontSize: 19,
              fontWeight: FontWeight.w900,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            item.period,
            softWrap: true,
            style: const TextStyle(
              color: Color(0xFF888888),
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 14),
        ],

        Text(
          item.school,
          softWrap: true,
          style: const TextStyle(
            color: Color(0xFF313131),
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1.35,
          ),
        ),

        const SizedBox(height: 13),

        Container(
          width: 50,
          height: 3,
          color: const Color(0xFFC1C1C3),
        ),

        const SizedBox(height: 18),

        ...item.details.map(
              (detail) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: AppColors.accent,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    detail,
                    softWrap: true,
                    style: const TextStyle(
                      color: Color(0xFF66666A),
                      fontSize: 14,
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
