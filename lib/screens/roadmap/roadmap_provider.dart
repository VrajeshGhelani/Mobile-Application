import 'package:flutter/material.dart';
import '../../models/career_domain_model.dart';
import '../../models/career_domain_data.dart';

class RoadmapProvider extends ChangeNotifier {
  List<CareerDomain> _allDomains = [];
  CareerDomain? _selectedDomain;
  bool _isLoading = false;

  List<CareerDomain> get allDomains => _allDomains;
  CareerDomain? get selectedDomain => _selectedDomain;
  bool get isLoading => _isLoading;

  Future<void> loadAllDomains() async {
    if (_allDomains.isNotEmpty) return;
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    _allDomains = CareerDomainData.getAllDomains();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadDomain(String id) async {
    await loadAllDomains();
    try {
      _selectedDomain = _allDomains.firstWhere((d) => d.id == id);
    } catch (_) {
      _selectedDomain = _allDomains.first;
    }
    notifyListeners();
  }

  void toggleStep(String domainId, int stepIndex) {
    final domainIndex = _allDomains.indexWhere((d) => d.id == domainId);
    if (domainIndex != -1) {
      _allDomains[domainIndex].steps[stepIndex].isCompleted =
          !_allDomains[domainIndex].steps[stepIndex].isCompleted;
      notifyListeners();
    }
  }

  // Progress calculations for the Tracking Screen
  int get totalCompletedSteps {
    int count = 0;
    for (var d in _allDomains) {
      count += d.steps.where((s) => s.isCompleted).length;
    }
    return count;
  }

  int get totalPendingSteps {
    int count = 0;
    for (var d in _allDomains) {
      count += d.steps.where((s) => !s.isCompleted).length;
    }
    return count;
  }

  double get overallProgress {
    int total = 0;
    for (var d in _allDomains) {
      total += d.steps.length;
    }
    if (total == 0) return 0.0;
    return totalCompletedSteps / total;
  }
}

/**
 * FUTURE-READY: AI RECOMMENDATION PLUG-IN
 * ---------------------------------------
 * Add a method here: `Future<void> generateAiPath(String domainId) async { ... }`
 * This would call an OpenAI/Gemini service to override `_selectedDomain.steps` 
 * with a JSON-generated list of specialized steps based on user's current progress.
 */
