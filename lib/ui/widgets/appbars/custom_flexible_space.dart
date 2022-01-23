import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CustomFlexibleSpace extends StatefulWidget {
  final String title;
  final double leftPadding;
  final double? offset;
  final Widget? background;

  const CustomFlexibleSpace({
    required this.title,
    this.offset,
    this.background,
    this.leftPadding = 20.0,
  });

  @override
  _CustomFlexibleSpaceState createState() => _CustomFlexibleSpaceState();
}

class _CustomFlexibleSpaceState extends State<CustomFlexibleSpace> {
  double getTitleWidth() {
    final width = MediaQuery.of(context).size.width;

    final textStyle = context.t.headline4;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final fontSize = textStyle?.fontSize ?? 0.0 * textScaleFactor;
    final effectiveTextStyle = textStyle?.copyWith(fontSize: fontSize);

    final renderParagraph = RenderParagraph(
      TextSpan(style: effectiveTextStyle, text: widget.title),
      maxLines: 1,
      textDirection: ui.TextDirection.ltr,
    );

    renderParagraph.layout(BoxConstraints(maxWidth: width));
    return renderParagraph.getMinIntrinsicWidth(fontSize).ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

        final effectiveOffset = widget.offset ?? settings.maxExtent;
        final deltaExtent = effectiveOffset - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0)
                .toDouble();

        final List<Widget> children = [];

        if (widget.background != null) {
          final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
          const fadeEnd = 1.0;
          final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
          final height = settings.maxExtent;
          final collapsePadding =
              -(settings.maxExtent - settings.currentExtent);

          children.add(
            Positioned(
              left: 0.0,
              right: 0.0,
              top: collapsePadding,
              height: height,
              child: Opacity(
                alwaysIncludeSemantics: true,
                opacity: opacity,
                child: widget.background,
              ),
            ),
          );
        }

        final textStyle = context.t.headline4?.serif;
        Widget titleWidget = Text(
          widget.title,
          maxLines: 3,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        );

        final opacity = settings.toolbarOpacity;
        if (opacity > 0.0) {
          final width = MediaQuery.of(context).size.width;

          final startPadding = (width - getTitleWidth()) / 2.0;
          final effectiveStartPadding = math.max(startPadding, 56.0);

          final expandedPadding = EdgeInsets.only(
            left: widget.leftPadding,
            bottom: 12.0,
          );
          final collapsedPadding = EdgeInsets.only(
            left: effectiveStartPadding,
            bottom: 18.0,
          );
          final paddingTween = EdgeInsetsTween(
            begin: expandedPadding,
            end: collapsedPadding,
          );

          EdgeInsets effectivePadding = expandedPadding;
          if (settings.currentExtent < effectiveOffset) {
            effectivePadding = paddingTween.transform(t);
            titleWidget = Text(
              widget.title,
              maxLines: 1,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
            );
          }

          final double scaleValue =
              Tween<double>(begin: 1.7, end: 1.0).transform(t);
          final Matrix4 scaleTransform = Matrix4.identity()
            ..scale(scaleValue, scaleValue, 1.0);
          const Alignment titleAlignment = Alignment.bottomLeft;

          children.add(
            Padding(
              padding: effectivePadding,
              child: Transform(
                alignment: titleAlignment,
                transform: scaleTransform,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      child: titleWidget,
                      alignment: titleAlignment,
                      width: constraints.maxWidth / scaleValue,
                    );
                  },
                ),
              ),
            ),
          );
        }

        return ClipRect(
          child: Stack(children: children),
        );
      },
    );
  }
}
