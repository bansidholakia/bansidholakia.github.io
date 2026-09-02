import 'package:flutter/material.dart';

class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.points,
  });

  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> points;
}

class EducationItem {
  const EducationItem({
    required this.degree,
    required this.school,
    required this.period,
    required this.details,
  });

  final String degree;
  final String school;
  final String period;
  final List<String> details;
}

class SkillGroup {
  const SkillGroup({required this.title, required this.skills});

  final String title;
  final List<String> skills;
}

class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    required this.imageAsset,
    required this.projectIcon,
    this.url,
  });

  final String title;
  final String description;
  final List<String> tags;
  final IconData icon;
  final String imageAsset;
  final String projectIcon;
  final String? url;
}
