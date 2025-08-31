import 'dart:convert';
import 'package:evide_assignment/screens/stop_detail.dart';
import 'package:evide_assignment/services/prefernces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/stop.dart';
import '../widgets/stop_card.dart';

class StopListScreen extends StatefulWidget {
  const StopListScreen({super.key});

  @override
  State<StopListScreen> createState() => _StopListScreenState();
}

class _StopListScreenState extends State<StopListScreen> {
  List<Stop> _stops = [];
  List<int> _favorites = [];
  String _query = '';
  final _prefs = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadStops();
    _loadFavorites();
  }

  Future<void> _loadStops() async {
    final data = await rootBundle.loadString('assets/mock/data.json');
    final jsonResult = json.decode(data) as List;
    setState(() {
      _stops = jsonResult.map((e) => Stop.fromJson(e)).toList();
    });
  }

  Future<void> _loadFavorites() async {
    final favs = await _prefs.getFavorites();
    setState(() {
      _favorites = favs;
    });
  }

  void _toggleFavorite(int stopId) async {
    await _prefs.toggleFavorite(stopId);
    _loadFavorites();
  }

  void _openDetail(Stop s) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => StopDetailScreen(
          stop: s,
          isFavorite: _favorites.contains(s.id),
          onFavoriteToggle: () => _toggleFavorite(s.id),
        ),
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _stops
        .where((s) => s.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Smart Bus Stops')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 20 : 8,
              vertical: 8,
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search Stop",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              style: TextStyle(fontSize: isTablet ? 18 : 14),
              onChanged: (val) => setState(() => _query = val),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Decide if we use grid or list
                final isWide = constraints.maxWidth > 600;

                if (isWide) {
                  // responsive columns (auto-adjust with screen width)
                  final crossAxisCount =
                      (constraints.maxWidth ~/ 300).clamp(2, 6); // min 2, max 6
                  return GridView.builder(
                    padding: EdgeInsets.all(isTablet ? 16 : 8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final s = filtered[index];
                      return _animatedCard(
                        index,
                        StopCard(
                          stop: s,
                          isFavorite: _favorites.contains(s.id),
                          onTap: () => _openDetail(s),
                        ),
                      );
                    },
                  );
                } else {
                  // Mobile → ListView
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final s = filtered[index];
                      return _animatedCard(
                        index,
                        StopCard(
                          stop: s,
                          isFavorite: _favorites.contains(s.id),
                          onTap: () => _openDetail(s),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Animation wrapper for cards
  Widget _animatedCard(int index, Widget child) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero),
      duration: Duration(milliseconds: 500 + (index * 80)),
      curve: Curves.easeOut,
      builder: (_, Offset offset, __) {
        return Transform.translate(
          offset: offset * 40,
          child: Opacity(
            opacity: offset == Offset.zero ? 1 : 0,
            child: child,
          ),
        );
      },
    );
  }
}
