import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/section_heading.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: AppColors.surface,
        child: ContentWidth(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 96),
            child: Column(
              children: [
                const SectionHeading(
                  eyebrow: 'Portfolio',
                  title: 'Check out some of my work.',
                  subtitle:
                      'Explore some of my projects. Hover on desktop or tap a project on mobile to see more.',
                ),
                const SizedBox(height: 54),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 900 ? 2 : 1;
                    const gap = 20.0;
                    final cardWidth =
                        (constraints.maxWidth - gap * (columns - 1)) / columns;

                    return Wrap(
                      spacing: gap,
                      runSpacing: gap,
                      children: PortfolioData.projects
                          .map(
                            (project) => SizedBox(
                              width: cardWidth,
                              child: _ProjectCard(project),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard(this.project);

  final ProjectItem project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool hovered = false;

  Future<void> _openProject() async {
    if (widget.project.url == null) return;

    final uri = Uri.parse(widget.project.url!);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showProjectDetails() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            decoration: const BoxDecoration(
              color: AppColors.surfaceSoft,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bottom-sheet handle
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .25),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  widget.project.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  widget.project.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .72),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 20),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.project.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: .30),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (widget.project.url != null) ...[
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () async {
                        Navigator.pop(sheetContext);
                        await _openProject();
                      },
                      icon: const Icon(
                        Icons.open_in_new_rounded,
                        size: 18,
                      ),
                      label: const Text('View Project'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(
                          double.infinity,
                          52,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile =
        MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    // Only show first 2 technologies on the mobile card.
    final previewTags =
    widget.project.tags.take(2).join(' • ').toUpperCase();

    return MouseRegion(
      cursor: !mobile && widget.project.url != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        if (!mobile) {
          setState(() => hovered = true);
        }
      },
      onExit: (_) {
        if (!mobile) {
          setState(() => hovered = false);
        }
      },
      child: GestureDetector(
        onTap: mobile
            ? _showProjectDetails
            : widget.project.url != null
            ? _openProject
            : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ---------------- IMAGE ----------------
                AnimatedScale(
                  scale: !mobile && hovered ? 1.05 : 1,
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                  child: Image.asset(
                    widget.project.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: const Color(0xFF222328),
                        alignment: Alignment.center,
                        child: Icon(
                          widget.project.icon,
                          size: 64,
                          color: AppColors.accent,
                        ),
                      );
                    },
                  ),
                ),

                // =====================================================
                // DESKTOP HOVER
                // =====================================================
                if (!mobile) ...[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: hovered
                        ? Colors.black.withValues(alpha: .82)
                        : Colors.transparent,
                  ),

                  AnimatedSlide(
                    duration: const Duration(milliseconds: 330),
                    curve: Curves.easeOutCubic,
                    offset:
                    hovered ? Offset.zero : const Offset(-.25, 0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: hovered ? 1 : 0,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            /*Image.asset(
                              widget.project.projectIcon,
                              height: 48,
                            ),
                            const SizedBox(height: 10),*/
                            Text(
                              widget.project.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 31,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              widget.project.description,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white
                                    .withValues(alpha: .78),
                                height: 1.5,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Text(
                              widget.project.tags
                                  .join(' • ')
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.accent,
                                fontSize: 11,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            if (widget.project.url != null) ...[
                              const SizedBox(height: 16),
                              const Icon(
                                Icons.open_in_new_rounded,
                                color: Colors.white,
                                size: 19,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],

                // =====================================================
                // MOBILE
                // =====================================================
                if (mobile) ...[
                  // Subtle gradient only at the bottom.
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: .48,
                      widthFactor: 1,
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: .88),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Minimal information.
                  Positioned(
                    left: 18,
                    right: 14,
                    bottom: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.project.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              if (previewTags.isNotEmpty) ...[
                                const SizedBox(height: 5),

                                Text(
                                  previewTags,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.accent,
                                    fontSize: 10,
                                    letterSpacing: .8,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color:
                            Colors.white.withValues(alpha: .14),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                              Colors.white.withValues(alpha: .18),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
