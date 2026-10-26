import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../core/constants/portfolio_data.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../widgets/section_title.dart';

class VideosSection extends StatefulWidget {
  const VideosSection({super.key});

  @override
  State<VideosSection> createState() => _VideosSectionState();
}

class _VideosSectionState extends State<VideosSection> {
  // Keep track of the currently actively playing video index so only one video plays audio at a time
  int? _activePlayingIndex;

  void _onVideoPlay(int index) {
    setState(() {
      _activePlayingIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth < 600 ? 36 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            eyebrow: "— Live Video Performances —",
            titlePrefix: "Watch",
            titleGold: "Live in Frame",
            subtitle:
                "Authentic recorded live performances showcasing acoustic saxophone melodies, vibrant stage presence, and soulful crowd engagement.",
          ),
          SizedBox(height: screenWidth < 600 ? 32 : 48),

          // Responsive 3-card or 2-card Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = width >= 1024 ? 3 : (width >= 680 ? 2 : 1);
              final double cardAspectRatio = width >= 1024
                  ? 0.76
                  : (width >= 680 ? 0.80 : (width < 380 ? 0.72 : 0.76));

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: BaluSaxData.videos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: width < 600 ? 16 : 24,
                  mainAxisSpacing: width < 600 ? 20 : 28,
                  childAspectRatio: cardAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final video = BaluSaxData.videos[index];
                  final isCurrentlyActive = _activePlayingIndex == index;

                  return _VideoPerformanceCard(
                    key: ValueKey(video.assetPath),
                    video: video,
                    index: index,
                    isOtherPlaying: _activePlayingIndex != null && !isCurrentlyActive,
                    onPlayStarted: () => _onVideoPlay(index),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VideoPerformanceCard extends StatefulWidget {
  final VideoItem video;
  final int index;
  final bool isOtherPlaying;
  final VoidCallback onPlayStarted;

  const _VideoPerformanceCard({
    super.key,
    required this.video,
    required this.index,
    required this.isOtherPlaying,
    required this.onPlayStarted,
  });

  @override
  State<_VideoPerformanceCard> createState() => _VideoPerformanceCardState();
}

class _VideoPerformanceCardState extends State<_VideoPerformanceCard> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isLoading = false;
  bool _isHovered = false;
  bool _hasError = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    // Do NOT eagerly initialize videos on startup to ensure instant page load!
  }

  Future<void> _initPlayer() async {
    try {
      final controller = VideoPlayerController.asset(widget.video.assetPath);
      await controller.initialize();
      controller.setLooping(true);
      controller.addListener(_videoListener);
      if (mounted) {
        setState(() {
          _controller = controller;
          _isInitialized = true;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
        });
      }
    }
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant _VideoPerformanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If another card started playing, pause this one
    if (_isInitialized && widget.isOtherPlaying && (_controller?.value.isPlaying ?? false)) {
      _controller?.pause();
    }
  }

  @override
  void dispose() {
    if (_isInitialized && _controller != null) {
      _controller!.removeListener(_videoListener);
      _controller!.dispose();
    }
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (!_isInitialized) {
      if (_isLoading) return;
      setState(() => _isLoading = true);
      await _initPlayer();
      if (!mounted) return;
      setState(() => _isLoading = false);
    }

    if (_controller == null || !_isInitialized) return;

    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      widget.onPlayStarted();
      _controller!.play();
    }
  }

  void _toggleMute() {
    if (_controller == null || !_isInitialized) return;
    setState(() {
      _isMuted = !_isMuted;
      _controller!.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _openTheaterDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (dialogCtx) => _TheaterVideoDialog(
        video: widget.video,
        assetPath: widget.video.assetPath,
      ),
    );
  }

  String _getThumbnailAsset(int index) {
    if (index == 0) return BaluSaxData.livePerformancesAsset;
    if (index == 1) return BaluSaxData.suitPortraitAsset;
    return BaluSaxData.circleWhiteAsset;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;
    final isPlaying = _isInitialized && (_controller?.value.isPlaying ?? false);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered || isPlaying ? AppColors.primary : AppColors.borderCyan,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (_isHovered || isPlaying)
                  ? AppColors.primary.withOpacity(0.25)
                  : Colors.black.withOpacity(0.35),
              blurRadius: (_isHovered || isPlaying) ? 30 : 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Player Area
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Video display or Lazy Poster Preview
                      if (_isInitialized && _controller != null)
                        Center(
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio > 0
                                ? _controller!.value.aspectRatio
                                : 16 / 9,
                            child: VideoPlayer(_controller!),
                          ),
                        )
                      else if (_isLoading)
                        Container(
                          color: const Color(0xFF101626),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "Loading live video...",
                                  style: TextStyle(
                                    color: AppColors.primaryLight,
                                    fontSize: 12,
                                    fontFamily: AppTheme.fontInter,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (_hasError)
                        Container(
                          color: const Color(0xFF101626),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.video_library_outlined, color: AppColors.primary, size: 48),
                                SizedBox(height: 8),
                                Text(
                                  "Live Video Performance",
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        // High Performance Preview Poster (Zero startup video load!)
                        Image.asset(
                          _getThumbnailAsset(widget.index),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.25),
                                Colors.black.withOpacity(0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],

                      // Gentle overlay when not hovering or when paused
                      if (!isPlaying)
                        Container(
                          color: Colors.black.withOpacity(0.25),
                        ),

                      // Category & Status Badges
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xDD0A0F1D),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isPlaying ? Colors.redAccent : AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                video.category.toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Theater / Lightbox Expand button
                      Positioned(
                        top: 12,
                        right: 12,
                        child: InkWell(
                          onTap: _openTheaterDialog,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xDD0A0F1D),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                            ),
                            child: const Icon(
                              Icons.fullscreen_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      // Big Center Play / Pause Button
                      Center(
                        child: GestureDetector(
                          onTap: _togglePlay,
                          child: AnimatedOpacity(
                            opacity: (!isPlaying || _isHovered) ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.6),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                              child: _isLoading
                                  ? const Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0A0F1D)),
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                      size: 34,
                                      color: const Color(0xFF0A0F1D),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      // Bottom Video Controls Bar
                      if (_isInitialized && _controller != null)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: AnimatedOpacity(
                            opacity: (_isHovered || !isPlaying) ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.transparent, Color(0xEE0A0F1D)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Video Progress Scrubber
                                  VideoProgressIndicator(
                                    _controller!,
                                    allowScrubbing: true,
                                    colors: const VideoProgressColors(
                                      playedColor: AppColors.primary,
                                      bufferedColor: Color(0x5500E5FF),
                                      backgroundColor: Color(0x33FFFFFF),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Play/Pause icon button
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: Icon(
                                          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: _togglePlay,
                                      ),
                                      const SizedBox(width: 8),

                                      // Elapsed / Total Duration
                                      Text(
                                        "${_formatDuration(_controller!.value.position)} / ${_formatDuration(_controller!.value.duration)}",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 11,
                                          fontFamily: AppTheme.fontInter,
                                        ),
                                      ),

                                      const Spacer(),

                                      // Mute / Unmute Button
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: Icon(
                                          _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        onPressed: _toggleMute,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Title and Narrative Area
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.sizeOf(context).width < 400 ? 12 : 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTheme.fontPlayfair,
                              color: (_isHovered || isPlaying)
                                  ? AppColors.primaryLight
                                  : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            video.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontInter,
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),

                      // Interactive Tap to Play / Theater bar
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: _togglePlay,
                              child: Row(
                                children: [
                                  Icon(
                                    isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                                    color: AppColors.primary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    isPlaying ? "PAUSE CLIP" : "PLAY VIDEO",
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            InkWell(
                              onTap: _openTheaterDialog,
                              child: const Row(
                                children: [
                                  Text(
                                    "EXPAND",
                                    style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.open_in_full_rounded, size: 12, color: AppColors.textMuted),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fullscreen / Theater Modal for high definition viewing of the performance
class _TheaterVideoDialog extends StatefulWidget {
  final VideoItem video;
  final String assetPath;

  const _TheaterVideoDialog({
    required this.video,
    required this.assetPath,
  });

  @override
  State<_TheaterVideoDialog> createState() => _TheaterVideoDialogState();
}

class _TheaterVideoDialogState extends State<_TheaterVideoDialog> {
  late VideoPlayerController _theaterController;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _theaterController = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _ready = true);
          _theaterController.play();
        }
      });
  }

  @override
  void dispose() {
    _theaterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    final mediaHeight = MediaQuery.sizeOf(context).height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: mediaWidth < 400 ? 10 : 16,
        vertical: 20,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 880,
          maxHeight: mediaHeight * 0.9,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0A0F1D),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 36,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.video.title,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontPlayfair,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: AppColors.primary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Player
              Flexible(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: _ready
                        ? AspectRatio(
                            aspectRatio: _theaterController.value.aspectRatio > 0
                                ? _theaterController.value.aspectRatio
                                : 16 / 9,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                VideoPlayer(_theaterController),
                                VideoProgressIndicator(
                                  _theaterController,
                                  allowScrubbing: true,
                                  colors: const VideoProgressColors(
                                    playedColor: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              ),

              // Controls Footer
              if (_ready)
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          _theaterController.value.isPlaying
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_fill_rounded,
                          color: AppColors.primary,
                          size: 36,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_theaterController.value.isPlaying) {
                              _theaterController.pause();
                            } else {
                              _theaterController.play();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
