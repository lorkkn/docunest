import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_logo.dart';

class AuthShowcaseLayout extends StatelessWidget {
  final Widget child;

  const AuthShowcaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;

          if (!isWide) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    children: [
                      const AppLogo(),
                      const SizedBox(height: 28),
                      child,
                    ],
                  ),
                ),
              ),
            );
          }

          return Row(
            children: [
              // Left Showcase Panel
              Expanded(
                flex: 5,
                child: Container(
                  color: AppColors.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppLogo(),
                      const Spacer(),
                      const Text(
                        'YOUR PRIVATE DOCUMENT SPACE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.6,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Everything important,\nsafely in one place.',
                        style: TextStyle(
                          fontSize: 28,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.0,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Keep personal records organized, find what you need quickly, and stay ahead of important expiry dates.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Mock Document Preview Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Recent documents',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ink,
                                  ),
                                ),
                                Text(
                                  'Secure vault',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildDocRow(
                              icon: Icons.badge_outlined,
                              iconBg: AppColors.blueSoft,
                              iconColor: AppColors.blue,
                              title: 'National Passport',
                              category: 'ID & Passports',
                              status: 'Updated today',
                            ),
                            const SizedBox(height: 8),
                            _buildDocRow(
                              icon: Icons.medical_services_outlined,
                              iconBg: AppColors.mintSoft,
                              iconColor: AppColors.mint,
                              title: 'Health Insurance',
                              category: 'Medical',
                              status: 'Expires Dec 2025',
                            ),
                            const SizedBox(height: 8),
                            _buildDocRow(
                              icon: Icons.account_balance_outlined,
                              iconBg: AppColors.amberSoft,
                              iconColor: AppColors.amber,
                              title: 'Home Insurance',
                              category: 'Finance',
                              status: 'Updated May 18',
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'DocuNest · Personal Document Manager',
                        style: TextStyle(fontSize: 11, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
              ),
              // Right Form Pane
              Expanded(
                flex: 6,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget _buildDocRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String category,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: const TextStyle(fontSize: 10, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

