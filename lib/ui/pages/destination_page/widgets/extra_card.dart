import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/destination_page/widgets/best_months_chips.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/permit_card.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class ExtraCard extends StatelessWidget {
  const ExtraCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PermitCard(),
          Divider(height: 16.0),
          BestMonthsChips(),
        ],
      ),
    );
  }
}
