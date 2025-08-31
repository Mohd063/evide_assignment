import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _favoritesKey = 'favoriteStops';

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey)?.map(int.parse).toList() ?? [];
  }

  Future<void> toggleFavorite(int stopId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (favorites.contains(stopId)) {
      favorites.remove(stopId);
    } else {
      favorites.add(stopId);
    }
    prefs.setStringList(
        _favoritesKey, favorites.map((e) => e.toString()).toList());
  }
}