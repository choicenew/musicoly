import 'package:flutter/material.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/greeting_section.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/playback_section.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/region_section.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/support_section.dart';

/// Getting started/onboarding page
class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getting Started'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingSection(),
            SizedBox(height: 24),
            PlaybackSection(),
            SizedBox(height: 24),
            RegionSection(),
            SizedBox(height: 24),
            SupportSection(),
          ],
        ),
      ),
    );
  }
}
