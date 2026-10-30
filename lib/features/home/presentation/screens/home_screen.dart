import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../data/mock_documents.dart';
import '../../../profile/presentation/widgets/profile_view.dart';
import '../../../auth/presentation/screens/login_screen.dart';

enum HomeScreenTab { dashboard, profile }

class HomeScreen extends StatefulWidget {
  final HomeScreenTab initialTab;

  const HomeScreen({
    super.key,
    this.initialTab = HomeScreenTab.dashboard,
  });

  static const String _userName = 'Alex Smith';
  static const String _userEmail = 'alex@docunest.com';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenTab _currentTab;
  late final List<MockDocument> _documents;
  final String _selectedCategoryTab = 'All';

  final List<String> _categoryTabs = const [
    'All',
    'ID & Passports',
    'Medical',
    'Finance',
    'Education',
    'Personal',
    'Legal',
  ];

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
    _documents = List.from(initialMockDocuments);
  }

  Color _toneBackground(String tone) {
    switch (tone) {
      case 'blue':
        return AppColors.blueSoft;
      case 'mint':
        return AppColors.mintSoft;
      case 'amber':
        return AppColors.amberSoft;
      case 'purple':
        return AppColors.purpleSoft;
      default:
        return AppColors.surfaceAlt;
    }
  }

  Color _toneColor(String tone) {
    switch (tone) {
      case 'blue':
        return AppColors.blue;
      case 'mint':
        return AppColors.mint;
      case 'amber':
        return AppColors.amber;
      case 'purple':
        return AppColors.purple;
      default:
        return AppColors.muted;
    }
  }

  Color _expiryToneColor(String expiry) {
    if (expiry == 'No expiry') return AppColors.muted;
    if (expiry.contains('2025')) return AppColors.amber;
    return AppColors.ink;
  }

  void _onSignOut() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;

          return Row(
            children: [
              // Desktop & Tablet Sidebar matching screenshot
              if (isWide) _buildSidebar(),
              // Main Scrollable Content Area
              Expanded(
                child: Scaffold(
                  backgroundColor: AppColors.background,
                  appBar: !isWide
                      ? AppBar(
                          backgroundColor: AppColors.surface,
                          elevation: 0,
                          title: const AppLogo(compact: true),
                          actions: [
                            IconButton(
                              icon: Icon(
                                _currentTab == HomeScreenTab.dashboard
                                    ? Icons.person_outline
                                    : Icons.home_outlined,
                                color: AppColors.ink,
                              ),
                              mouseCursor: SystemMouseCursors.click,
                              onPressed: () {
                                setState(() {
                                  _currentTab = _currentTab == HomeScreenTab.dashboard
                                      ? HomeScreenTab.profile
                                      : HomeScreenTab.dashboard;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.logout, color: AppColors.danger),
                              mouseCursor: SystemMouseCursors.click,
                              onPressed: _onSignOut,
                            ),
                          ],
                        )
                      : null,
                  body: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 44 : 20,
                      vertical: 36,
                    ),
                    child: _currentTab == HomeScreenTab.profile
                        ? ProfileView(onSignOut: _onSignOut)
                        : _buildDashboardContent(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDashboardContent() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header matching App.tsx
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MONDAY, MAY 26',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.6,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Welcome back, Alex',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.9,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 150,
                child: AppButton(
                  text: 'Add Document',
                  icon: Icons.add,
                  onPressed: () {
                    // No modal popup on click
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Metric Grid Cards
          LayoutBuilder(
            builder: (context, cardConstraints) {
              if (cardConstraints.maxWidth < 650) {
                return Column(
                  children: [
                    _buildMetricCard(
                      icon: Icons.folder_outlined,
                      tone: 'blue',
                      label: 'Total Documents',
                      value: '24',
                      detail: '+3 this month',
                    ),
                    const SizedBox(height: 12),
                    _buildMetricCard(
                      icon: Icons.description_outlined,
                      tone: 'purple',
                      label: 'Recently Added',
                      value: '06',
                      detail: 'Last 30 days',
                    ),
                    const SizedBox(height: 12),
                    _buildMetricCard(
                      icon: Icons.calendar_today_outlined,
                      tone: 'amber',
                      label: 'Expiring Soon',
                      value: '03',
                      detail: 'Within 90 days',
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.folder_outlined,
                      tone: 'blue',
                      label: 'Total Documents',
                      value: '24',
                      detail: '+3 this month',
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.description_outlined,
                      tone: 'purple',
                      label: 'Recently Added',
                      value: '06',
                      detail: 'Last 30 days',
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.calendar_today_outlined,
                      tone: 'amber',
                      label: 'Expiring Soon',
                      value: '03',
                      detail: 'Within 90 days',
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),
          // Category Tabs (Chips) with hover & pointer cursor (no action on click)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categoryTabs.map((category) {
                final isSelected = category == _selectedCategoryTab;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _CategoryTabChip(
                    label: category,
                    isSelected: isSelected,
                    onTap: () {
                      // No action on click
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // Recent Documents Section
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent documents',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Your latest uploads and updates',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // No action on click
                      },
                      icon: const Icon(Icons.arrow_forward, size: 15),
                      label: const Text('View all'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        enabledMouseCursor: SystemMouseCursors.click,
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _documents.length.clamp(0, 4),
                  separatorBuilder: (_, _) => const Divider(
                    color: Color(0xFFEDF0EE),
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    final doc = _documents[index];
                    return InkWell(
                      // Clicking document does nothing as requested
                      onTap: () {},
                      mouseCursor: SystemMouseCursors.click,
                      hoverColor: AppColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: LayoutBuilder(
                          builder: (context, rowConstraints) {
                            final isWideRow = rowConstraints.maxWidth >= 550;

                            return Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _toneBackground(doc.tone),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Icon(
                                    doc.icon,
                                    size: 19,
                                    color: _toneColor(doc.tone),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc.name,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.ink,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        isWideRow
                                            ? doc.category
                                            : '${doc.category} · Exp: ${doc.expiry}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isWideRow) ...[
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Expiry date',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        doc.expiry,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: _expiryToneColor(doc.expiry),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 24),
                                  Text(
                                    doc.updated,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ],
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 13,
                                  color: AppColors.muted,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLogo(),
          const SizedBox(height: 48),
          // Home tab
          _SidebarNavTab(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: _currentTab == HomeScreenTab.dashboard,
            onTap: () {
              setState(() => _currentTab = HomeScreenTab.dashboard);
            },
          ),
          const SizedBox(height: 6),
          // Documents tab (Unclickable, hover & pointer cursor)
          _SidebarNavTab(
            icon: Icons.description_outlined,
            label: 'Documents',
            isActive: false,
            onTap: () {},
          ),
          const SizedBox(height: 6),
          // Categories tab (Unclickable, hover & pointer cursor)
          _SidebarNavTab(
            icon: Icons.grid_view_outlined,
            label: 'Categories',
            isActive: false,
            onTap: () {},
          ),
          const SizedBox(height: 6),
          // Profile tab matching screenshot
          _SidebarNavTab(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: _currentTab == HomeScreenTab.profile,
            onTap: () {
              setState(() => _currentTab = HomeScreenTab.profile);
            },
          ),
          const Spacer(),
          const Divider(),
          const SizedBox(height: 16),
          // Mini user card at bottom
          InkWell(
            onTap: () {
              setState(() => _currentTab = HomeScreenTab.profile);
            },
            mouseCursor: SystemMouseCursors.click,
            hoverColor: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primarySoft,
                    child: const Text(
                      'AS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          HomeScreen._userName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        Text(
                          HomeScreen._userEmail,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            text: 'Sign Out',
            variant: AppButtonVariant.text,
            icon: Icons.logout,
            height: 38,
            onPressed: _onSignOut,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String tone,
    required String label,
    required String value,
    required String detail,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(20, 35, 26, 0.02),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _toneBackground(tone),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, size: 22, color: _toneColor(tone)),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.0,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarNavTab extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarNavTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_SidebarNavTab> createState() => _SidebarNavTabState();
}

class _SidebarNavTabState extends State<_SidebarNavTab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isActive;

    final Color backgroundColor = isActive
        ? AppColors.primarySoft
        : (_isHovered
            ? AppColors.surfaceAlt
            : AppColors.surfaceAlt.withValues(alpha: 0));

    final Color contentColor = isActive
        ? AppColors.primary
        : (_isHovered ? AppColors.ink : const Color(0xFF5F6963));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: contentColor,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: contentColor,
                  ),
                ),
              ),
              if (isActive)
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryTabChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTabChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CategoryTabChip> createState() => _CategoryTabChipState();
}

class _CategoryTabChipState extends State<_CategoryTabChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;

    Color backgroundColor = isSelected
        ? AppColors.primarySoft
        : (_isHovered ? AppColors.surfaceAlt : AppColors.surface);
    Color borderColor = isSelected
        ? const Color(0xFFB9DDCC)
        : (_isHovered ? const Color(0xFFB8C3BC) : AppColors.border);
    Color textColor = isSelected ? AppColors.primary : AppColors.muted;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
