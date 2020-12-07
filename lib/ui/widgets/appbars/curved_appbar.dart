import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class CurvedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final double elevation;
  final List<Widget> actions;

  const CurvedAppbar({
    @required this.title,
    this.leading,
    this.actions,
    this.elevation = 8.0,
  })  : assert(title != null),
        assert(elevation != null);

  @override
  Size get preferredSize => const Size.fromHeight(40.0);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvePainter(
        elevation: elevation,
        color: context.c.background,
      ),
      child: _buildAppbar(context),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      leading: leading,
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: actions == null
          ? null
          : [
              ...actions,
              const SizedBox(width: 8.0),
            ],
      title: SlideAnimator(
        begin: const Offset(0.0, -0.2),
        child: FadeAnimator(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.t.headline4.serif,
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

    canvas.drawShadow(curve, AppColors.darkFaded, elevation, false);
    canvas.drawPath(curve, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
