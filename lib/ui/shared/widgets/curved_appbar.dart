import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class CurvedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final String title;
  final Widget leading;
  final double elevation;
  final List<Widget> actions;

  const CurvedAppbar({
    @required this.title,
    this.leading,
    this.elevation = 8.0,
    this.color = AppColors.light,
    this.actions,
  })  : assert(color != null),
        assert(title != null),
        assert(elevation != null);

  @override
  Size get preferredSize => const Size.fromHeight(40.0);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvePainter(
        color: color,
        elevation: elevation,
      ),
      child: _buildAppbar(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      leading: leading,
      actions: actions,
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
          ? AppThemes.lightIconTheme
          : AppThemes.darkIconTheme,
      title: SlideAnimator(
        begin: const Offset(0.0, -0.2),
        child: FadeAnimator(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                ? AppTextStyles.medium.light.bold.serif
                : AppTextStyles.medium.bold.serif,
          ),
        ),
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  final Color color;
  final double elevation;

  _CurvePainter({
    @required this.color,
    @required this.elevation,
  })  : assert(color != null),
        assert(elevation != null);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final curve = Path()
      ..moveTo(0.0, height * 1.05)
      ..quadraticBezierTo(width * 0.5, height * 1.2, width, height * 1.05)
      ..lineTo(width, 0.0)
      ..lineTo(0.0, 0.0);

    canvas.drawShadow(curve, AppColors.barrier, elevation, false);
    canvas.drawPath(curve, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
