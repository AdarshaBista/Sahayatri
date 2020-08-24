import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/completed_page/widgets/downloaded_list.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            DownloadedList(),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
