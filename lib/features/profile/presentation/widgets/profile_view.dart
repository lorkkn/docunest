import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class ProfileView extends StatefulWidget {
  final VoidCallback onSignOut;

  const ProfileView({super.key, required this.onSignOut});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameController = TextEditingController(text: 'Alex Smith');
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _profileSaved = false;
  bool _passwordChanged = false;

  @override
  void dispose() {
    _nameController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSaveProfile() {
    setState(() => _profileSaved = true);
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => _profileSaved = false);
    });
  }

  void _onChangePassword() {
    setState(() => _passwordChanged = true);
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => _passwordChanged = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 850),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header matching screenshot
          const Text(
            'ACCOUNT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Profile & Settings',
            style: TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 28),

          // 1. Profile Hero Card
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD6EADD),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'AS',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Alex Smith',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Manage your personal information',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 10),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                              decoration: BoxDecoration(
                                color: AppColors.primarySoft,
                                border: Border.all(color: const Color(0xFFB9DDCC)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Upload Photo',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Divider(),
                ),
                // 2-Column Form Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMultiColumn = constraints.maxWidth > 520;
                    if (isMultiColumn) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'User Name',
                              controller: _nameController,
                            ),
                          ),
                          const SizedBox(width: 17),
                          const Expanded(
                            child: AppTextField(
                              label: 'Email Address',
                              hintText: 'alex@docunest.com',
                              prefixIcon: Icons.lock_outline,
                              readOnly: true,
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        AppTextField(
                          label: 'User Name',
                          controller: _nameController,
                        ),
                        const SizedBox(height: 16),
                        const AppTextField(
                          label: 'Email Address',
                          hintText: 'alex@docunest.com',
                          prefixIcon: Icons.lock_outline,
                          readOnly: true,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 140,
                    child: AppButton(
                      text: _profileSaved ? 'Changes Saved' : 'Save Changes',
                      onPressed: _onSaveProfile,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // 2. Security Card
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEAF8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        size: 20,
                        color: Color(0xFF66558E),
                      ),
                    ),
                    const SizedBox(width: 13),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Security',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                            color: AppColors.ink,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Update your account password',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                // 2-Column Password Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMultiColumn = constraints.maxWidth > 520;
                    if (isMultiColumn) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'New Password',
                              hintText: 'Enter new password',
                              isPassword: true,
                              controller: _newPasswordController,
                            ),
                          ),
                          const SizedBox(width: 17),
                          Expanded(
                            child: AppTextField(
                              label: 'Confirm New Password',
                              hintText: 'Repeat new password',
                              isPassword: true,
                              controller: _confirmPasswordController,
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        AppTextField(
                          label: 'New Password',
                          hintText: 'Enter new password',
                          isPassword: true,
                          controller: _newPasswordController,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'Confirm New Password',
                          hintText: 'Repeat new password',
                          isPassword: true,
                          controller: _confirmPasswordController,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Use 8+ characters with a mix of letters and numbers.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 160,
                      child: AppButton(
                        text: _passwordChanged ? 'Password Updated' : 'Change Password',
                        variant: AppButtonVariant.secondary,
                        onPressed: _onChangePassword,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // 3. Danger Card (Sign out of DocuNest) matching .danger-card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 19),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFAFA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFECD6D3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Sign out of DocuNest',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'You can securely sign in again at any time.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: AppButton(
                    text: 'Sign Out',
                    variant: AppButtonVariant.text,
                    icon: Icons.logout,
                    onPressed: widget.onSignOut,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
