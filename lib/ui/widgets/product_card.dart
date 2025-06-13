import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:video_player/video_player.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String seller;
  final double price;
  final double rating;
  final String mediaUrl;
  final bool isVideo;
  final String? thumbnailUrl;
  final EdgeInsetsGeometry? margin;

  const ProductCard({
    super.key,
    required this.title,
    required this.seller,
    required this.price,
    required this.rating,
    required this.mediaUrl,
    this.isVideo = false,
    this.thumbnailUrl,
    this.margin,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late VideoPlayerController? _controller;
  bool _isHovered = false;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      // On web, we'll show a thumbnail with a play button instead of actual video
      if (kIsWeb) {
        _isVideoInitialized = false;
        _controller = null;
      } else {
        _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.mediaUrl),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        )..initialize().then((_) {
            if (mounted) {
              setState(() {
                _isVideoInitialized = true;
              });
            }
            _controller?.setLooping(true);
            _controller?.setVolume(0);
          }).catchError((error) {
            // If video fails to load, fall back to image
            if (mounted) {
              setState(() {
                _isVideoInitialized = false;
              });
            }
          });
      }
    } else {
      _controller = null;
    }
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(
          widget.isVideo ? Icons.videocam_off : Icons.image_not_supported,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    if (mounted) {
      setState(() {
        _isHovered = isHovered;
      });
      if (widget.isVideo && _isVideoInitialized && _controller != null) {
        if (isHovered) {
          _controller?.play();
        } else {
          _controller?.pause();
          _controller?.seekTo(Duration.zero);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: widget.margin ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(20), // Equivalent to black with 0.08 opacity
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Media (Image or Video)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Video, GIF, or Image content
                    if (widget.isVideo)
                      kIsWeb
                          ? Image.network(
                              widget.mediaUrl.endsWith('.gif')
                                  ? widget.mediaUrl
                                  : (widget.thumbnailUrl ?? widget.mediaUrl),
                              fit: BoxFit.cover,
                              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded) return child;
                                return AnimatedOpacity(
                                  opacity: frame == null ? 0 : 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                  child: child,
                                );
                              },
                              errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
                            )
                          : _isVideoInitialized && _controller != null
                              ? AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                )
                              : Image.network(
                                  widget.thumbnailUrl ?? widget.mediaUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
                                )
                    else
                      Image.network(
                        widget.mediaUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
                      ),
                    // Video indicator
                    if (widget.isVideo)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Product details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Seller and Rating
                  Row(
                    children: [
                      // Seller
                      Expanded(
                        child: Text(
                          widget.seller,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Rating
                      Row(
                        children: [
                          Icon(Icons.star_rounded, 
                            color: Colors.amber[600], 
                            size: 16
                          ),
                          const SizedBox(width: 2),
                          Text(
                            widget.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Text(
                    '\$${widget.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
