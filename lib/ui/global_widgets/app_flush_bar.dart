import 'package:flutter/material.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:jenosize/ui/styles/app_text_style.dart';

class AppFlushBar {
  AppFlushBar._();

  static OverlayEntry? _currentEntry;

  static void success(
    BuildContext context, {
    required String message,
  }) => _show(
    context,
    message: message,
    color: context.appColors.success,
    icon: Icons.check_circle,
  );

  static void failed(
    BuildContext context, {
    required String message,
  }) => _show(
    context,
    message: message,
    color: context.appColors.failed,
    icon: Icons.cancel,
  );

  static void warning(
    BuildContext context, {
    required String message,
  }) => _show(
    context,
    message: message,
    color: context.appColors.warning,
    icon: Icons.warning_amber_rounded,
  );

  static void info(
    BuildContext context, {
    required String message,
  }) => _show(
    context,
    message: message,
    color: context.appColors.info,
    icon: Icons.info,
  );

  static void _show(
    BuildContext context, {
    required String message,
    required Color color,
    required IconData icon,
  }) {
    if (_currentEntry != null) return;

    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    final animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 250),
    );

    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: animationController,
              child: _buildToast(
                message: message,
                color: color,
                icon: icon,
              ),
            ),
          ),
        );
      },
    );

    _currentEntry = entry;
    overlay.insert(entry);

    animationController.forward();

    Future.delayed(const Duration(milliseconds: 1750)).then((_) async {
      await animationController.reverse();
      entry.remove();
      _currentEntry = null;
      animationController.dispose();
    });
  }

  static Widget _buildToast({
    required String message,
    required Color color,
    required IconData icon,
  }) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          spacing: 10,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Expanded(
              child: Text(
                message,
                style: AppTextStyle.w400(16).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
