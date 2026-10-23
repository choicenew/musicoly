import 'package:flutter/material.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/greeting_section.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/playback_section.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/region_section.dart';
import 'package:pyro_music/features/getting_started/presentation/widgets/support_section.dart';

import 'package:pyro_music/generated/app_localizations.dart';

/// Getting started/onboarding page
class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.getting_started),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
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
