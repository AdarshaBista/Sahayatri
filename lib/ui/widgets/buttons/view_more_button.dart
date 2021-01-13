import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/flushbar_extension.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

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
    if (isLoading) return const CircularBusyIndicator();
    return _buildViewMore();
  }

  Widget _buildFinished() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "That's it for now.",
          style: AppTextStyles.headline6.primaryDark,
        ),
      ),
    );
  }

  Widget _buildViewMore() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomButton(
        label: 'View More',
        icon: AppIcons.more,
        color: AppColors.primaryDark,
        backgroundColor: AppColors.primaryLight,
        onTap: _loadMore,
      ),
    );
  }

  Future<void> _loadMore() async {
    setState(() => isLoading = true);
    final bool success = await widget.onLoadMore();
    if (!success) {
      context.openFlushBar('Failed to load more reviews!', type: FlushbarType.error);
    }
    setState(() => isLoading = false);
  }
}
