import 'package:flutter/material.dart';

class MockDocument {
  final String id;
  final String name;
  final String category;
  final String issue;
  final String expiry;
  final String updated;
  final String filename;
  final String fileType;
  final String tone;
  final IconData icon;

  const MockDocument({
    required this.id,
    required this.name,
    required this.category,
    required this.issue,
    required this.expiry,
    required this.updated,
    required this.filename,
    required this.fileType,
    required this.tone,
    required this.icon,
  });
}

final List<MockDocument> initialMockDocuments = [
  const MockDocument(
    id: 'passport',
    name: 'National Passport',
    category: 'ID & Passports',
    issue: 'Sep 24, 2016',
    expiry: 'Sep 24, 2026',
    updated: '2 hours ago',
    filename: 'national-passport.pdf',
    fileType: 'PDF',
    icon: Icons.badge_outlined,
    tone: 'blue',
  ),
  const MockDocument(
    id: 'health-insurance',
    name: 'Health Insurance Card',
    category: 'Medical',
    issue: 'Jan 01, 2025',
    expiry: 'Dec 31, 2025',
    updated: 'Yesterday',
    filename: 'health-insurance-card.png',
    fileType: 'PNG',
    icon: Icons.medical_services_outlined,
    tone: 'mint',
  ),
  const MockDocument(
    id: 'home-insurance',
    name: 'Home Insurance Policy',
    category: 'Finance',
    issue: 'Jun 15, 2025',
    expiry: 'Jun 15, 2026',
    updated: 'May 18, 2025',
    filename: 'home-insurance-policy.pdf',
    fileType: 'PDF',
    icon: Icons.account_balance_outlined,
    tone: 'amber',
  ),
  const MockDocument(
    id: 'diploma',
    name: 'University Diploma',
    category: 'Education',
    issue: 'May 18, 2021',
    expiry: 'No expiry',
    updated: 'May 12, 2025',
    filename: 'university-diploma.pdf',
    fileType: 'PDF',
    icon: Icons.school_outlined,
    tone: 'purple',
  ),
  const MockDocument(
    id: 'drivers-license',
    name: "Driver's License",
    category: 'ID & Passports',
    issue: 'Jun 08, 2020',
    expiry: 'Jun 08, 2025',
    updated: 'Apr 28, 2025',
    filename: 'drivers-license.jpg',
    fileType: 'JPG',
    icon: Icons.badge_outlined,
    tone: 'blue',
  ),
];

