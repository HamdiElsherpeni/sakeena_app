import 'package:flutter/material.dart';
import '../data/models/health_guide_models.dart';
import '../data/health_guide_data.dart';

class HealthGuideController extends ChangeNotifier {
  String _selectedCategoryId = 'all';
  String _searchQuery = '';

  String get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;

  List<HealthCategory> get categories => HealthGuideData.categories;
  List<HealthTip> get quickTips => HealthGuideData.quickTips;

  List<HealthArticle> get filteredArticles {
    var list = HealthGuideData.articles;

    if (_selectedCategoryId != 'all') {
      list = list.where((a) => a.categoryId == _selectedCategoryId).toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list
          .where(
            (a) =>
                a.title.contains(_searchQuery) ||
                a.summary.contains(_searchQuery),
          )
          .toList();
    }

    return list;
  }

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}