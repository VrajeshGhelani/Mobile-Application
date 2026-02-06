import 'package:flutter/material.dart';

class RoadmapStep {
  final String title;
  final String description;
  final String? certification;
  bool isCompleted;

  RoadmapStep({
    required this.title,
    required this.description,
    this.certification,
    this.isCompleted = false,
  });
}

class CareerDomain {
  final String id;
  final String name;
  final String field; // Medical, Commerce, Tech, etc.
  final String description;
  final IconData icon;
  final Color color;
  final List<RoadmapStep> steps;

  CareerDomain({
    required this.id,
    required this.name,
    required this.field,
    required this.description,
    required this.icon,
    required this.color,
    required this.steps,
  });
}
