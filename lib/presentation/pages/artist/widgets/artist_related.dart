import 'package:flutter/material.dart';
import 'package:pyro_music/core/base/models/artist_model.dart';
import 'package:pyro_music/generated/app_localizations.dart';
import 'package:pyro_music/presentation/widgets/common/artist_card.dart';

/// Widget that displays artists related to the current artist
class ArtistRelated extends StatelessWidget {
  /// The current artist
  final ArtistModel artist;

  /// Creates a new related artists widget
  const ArtistRelated({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // In a real implementation, these related artists would come from a provider
    // This is just a placeholder for demonstration
    final List<ArtistModel> relatedArtists = [];
    // const bool isLoading = false; // Remove this line

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          l10n.fans_also_like,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Related artists grid
        // Remove the isLoading conditional block
        if (relatedArtists.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 48,
                    color: Color.lerp(
                      theme.colorScheme.onSurface.withAlpha(0),
                      theme.colorScheme.onSurface,
                      0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.no_related_artists_found,
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: relatedArtists.length,
              itemBuilder: (context, index) {
                final relatedArtist = relatedArtists[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 120,
                    child: ArtistCard(
                      artist: relatedArtist,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/artist/${relatedArtist.id}',
                          arguments: relatedArtist.id,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
