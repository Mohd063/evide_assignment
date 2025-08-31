import 'package:flutter/material.dart';
import '../models/stop.dart';

class StopCard extends StatelessWidget {
  final Stop stop;
  final bool isFavorite;
  final VoidCallback onTap;

  const StopCard({
    super.key,
    required this.stop,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1000;

    // Dynamic sizes
    final avatarRadius = isDesktop ? 32.0 : isTablet ? 28.0 : 24.0;
    final titleFont = isDesktop ? 20.0 : isTablet ? 18.0 : 16.0;
    final subtitleFont = isDesktop ? 16.0 : isTablet ? 15.0 : 13.0;
    final margin = isTablet ? 16.0 : 12.0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: margin),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? 12 : 8,
          horizontal: isTablet ? 16 : 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.directions_bus,
                  color: Colors.blue, size: avatarRadius),
            ),
            const SizedBox(width: 12),

            // Expanded content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stop.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFont,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stop.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: subtitleFont,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Favorite Icon
            Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.orangeAccent : Colors.grey,
              size: isTablet ? 28 : 24,
            ),
          ],
        ),
      ),
    ).buildInkWell(onTap);
  }
}

//  Extension to make Card tappable with ripple effect
extension on Widget {
  Widget buildInkWell(VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: this,
    );
  }
}
