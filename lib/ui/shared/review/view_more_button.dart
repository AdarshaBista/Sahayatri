import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';

class ViewMoreButton extends StatefulWidget {
  final bool hasMore;
  final Future<bool> Function() onLoadMore;

  const ViewMoreButton({
    @required this.hasMore,
    @required this.onLoadMore,
  })  : assert(hasMore != null),
        assert(onLoadMore != null);

  @override
  _ViewMoreButtonState createState() => _ViewMoreButtonState();
}

class _ViewMoreButtonState extends State<ViewMoreButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.hasMore) return _buildFinished();
    if (isLoading) return _buildLoading();
    return _buildViewMore();
  }

  Widget _buildFinished() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "That's it for now.",
          style: AppTextStyles.extraSmall.primaryDark,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Container(
        width: 32.0,
        height: 32.0,
        margin: const EdgeInsets.all(12.0),
        child: LoadingIndicator(
          color: AppColors.primary,
          indicatorType: Indicator.ballSpinFadeLoader,
        ),
      ),
    );
  }

  Widget _buildViewMore() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomButton(
        label: 'View More',
        color: AppColors.primaryDark,
        backgroundColor: AppColors.primaryLight,
        iconData: Icons.arrow_right_alt_outlined,
        onTap: _loadMore,
      ),
    );
  }

  Future<void> _loadMore() async {
    setState(() => isLoading = true);
    final bool success = await widget.onLoadMore();
    if (!success) context.openSnackBar('Failed to load more reviews!');
    setState(() => isLoading = false);
  }
}
