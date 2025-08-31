import 'package:flutter/material.dart';
import '../models/stop.dart';

class StopDetailScreen extends StatelessWidget {
  final Stop stop;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const StopDetailScreen({
    super.key,
    required this.stop,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // get screen size
    final isTablet = size.width > 600; // check if tablet
    final padding = isTablet ? 24.0 : 16.0; // dynamic padding
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: isTablet ? 20 : 16,
          fontWeight: FontWeight.w600,
        );
    final subtitleStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: isTablet ? 18 : 14);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          stop.name,
          style: TextStyle(fontSize: isTablet ? 22 : 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.orangeAccent : Colors.white,
              size: isTablet ? 30 : 24,
            ),
            onPressed: onFavoriteToggle,
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCard(
                      icon: Icons.info,
                      iconColor: Colors.blue,
                      title: "Description",
                      subtitle: stop.description,
                      titleStyle: titleStyle,
                      subtitleStyle: subtitleStyle,
                    ),
                    SizedBox(height: padding / 2),
                    _buildCard(
                      icon: Icons.location_on,
                      iconColor: Colors.red,
                      title: "Latitude",
                      subtitle: stop.lat.toString(),
                      titleStyle: titleStyle,
                      subtitleStyle: subtitleStyle,
                    ),
                    SizedBox(height: padding / 2),
                    _buildCard(
                      icon: Icons.location_searching,
                      iconColor: Colors.green,
                      title: "Longitude",
                      subtitle: stop.lng.toString(),
                      titleStyle: titleStyle,
                      subtitleStyle: subtitleStyle,
                    ),
                    SizedBox(height: padding / 2),
                    _buildCard(
                      icon: Icons.access_time,
                      iconColor: Colors.orange,
                      title: "ETA",
                      subtitle: "~10 mins",
                      titleStyle: titleStyle,
                      subtitleStyle: subtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required TextStyle? titleStyle,
    required TextStyle? subtitleStyle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: iconColor, size: 28),
        title: Text(title, style: titleStyle),
        subtitle: Text(subtitle, style: subtitleStyle),
      ),
    );
  }
}
