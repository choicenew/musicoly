import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_music/features/home_feed/providers/home_feed_provider.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'widgets/home_header.dart';
import 'widgets/home_section_renderer.dart';

/// Generic Dynamic HomePage Renderer driven by HomeFeedState & Plugin Container
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final homeFeedState = ref.watch(homeFeedNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(homeFeedNotifierProvider.notifier).loadHomeFeed();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(l10n.home),
                floating: true,
                snap: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => context.go('/search'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => context.go('/settings'),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      const SizedBox(height: 24),
                      ..._buildFeedContent(context, ref, homeFeedState),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFeedContent(
    BuildContext context,
    WidgetRef ref,
    HomeFeedState state,
  ) {
    switch (state) {
      case HomeFeedLoading():
        return [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ];

      case HomeFeedEmpty():
        return [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48.0),
              child: Text('No plugin content available.'),
            ),
          ),
        ];

      case HomeFeedError(message: final msg):
        return [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('Failed to load feed: $msg'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(homeFeedNotifierProvider.notifier)
                        .loadHomeFeed(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ];

      case HomeFeedSuccess(sections: final sections):
        return sections.map((section) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: HomeSectionRenderer(section: section),
          );
        }).toList();
    }
  }
}
