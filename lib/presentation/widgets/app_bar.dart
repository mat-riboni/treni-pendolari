import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    super.key,
    this.title,
    required this.showLeading,
    this.onPressed,
    this.height = 80.0, // Altezza di default personalizzata
  });

  final Widget? title;
  final bool showLeading;
  final double height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        color: AppColors.primary,
        child: Stack(
          children: [
            if (showLeading)
              Positioned(
                left: 0,
                bottom: 10,
                child: IconButton(
                  onPressed: onPressed ??
                      () {
                        Navigator.pop(context);
                      },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: title ?? const Text(""),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
