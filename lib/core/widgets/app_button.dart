import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum AppButtonVariant { primary, secondary, text, danger }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool fullWidth;
  final double height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.fullWidth = true,
    this.height = 44.0,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;
    List<BoxShadow> shadows = [];

    switch (widget.variant) {
      case AppButtonVariant.primary:
        backgroundColor = _isHovered ? AppColors.primaryHover : AppColors.primary;
        textColor = Colors.white;
        shadows = [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: _isHovered ? 0.25 : 0.16),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ];
        break;
      case AppButtonVariant.secondary:
        backgroundColor = _isHovered ? AppColors.surfaceAlt : AppColors.surface;
        textColor = AppColors.ink;
        borderSide = const BorderSide(color: AppColors.border);
        break;
      case AppButtonVariant.text:
        backgroundColor = _isHovered ? AppColors.surfaceAlt : Colors.transparent;
        textColor = AppColors.danger;
        break;
      case AppButtonVariant.danger:
        backgroundColor = _isHovered ? AppColors.danger.withValues(alpha: 0.9) : AppColors.danger;
        textColor = Colors.white;
        shadows = [
          BoxShadow(
            color: AppColors.danger.withValues(alpha: 0.16),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ];
        break;
    }

    Widget content = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 16, color: textColor),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ],
    );

    return MouseRegion(
      cursor: widget.onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        width: widget.fullWidth ? double.infinity : null,
        height: widget.height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: widget.onPressed != null ? shadows : null,
          ),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              disabledBackgroundColor: backgroundColor.withValues(alpha: 0.5),
              elevation: 0,
              shadowColor: Colors.transparent,
              side: borderSide,
              enabledMouseCursor: SystemMouseCursors.click,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
