// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get guest => 'Guest';

  @override
  String get browse => 'Browse';

  @override
  String get search => 'Search';

  @override
  String get library => 'Library';

  @override
  String get lyrics => 'Lyrics';

  @override
  String get settings => 'Settings';

  @override
  String get genre_categories_filter => 'Filter categories or genres...';

  @override
  String get genre => 'Genre';

  @override
  String get personalized => 'Personalized';

  @override
  String get featured => 'Featured';

  @override
  String get new_releases => 'New Releases';

  @override
  String get songs => 'Songs';

  @override
  String playing_track(Object track) {
    return 'Playing $track';
  }

  @override
  String queue_clear_alert(Object track_length) {
    return 'This will clear the current queue. $track_length tracks will be removed\nDo you want to continue?';
  }

  @override
  String get load_more => 'Load more';

  @override
  String get playlists => 'Playlists';

  @override
  String get artists => 'Artists';

  @override
  String get albums => 'Albums';

  @override
  String get tracks => 'Tracks';

  @override
  String get downloads => 'Downloads';

  @override
  String get filter_playlists => 'Filter your playlists...';

  @override
  String get liked_tracks => 'Liked Tracks';

  @override
  String get liked_tracks_description => 'All your liked tracks';

  @override
  String get create_playlist => 'Create Playlist';

  @override
  String get create_a_playlist => 'Create a playlist';

  @override
  String get update_playlist => 'Update playlist';

  @override
  String get create => 'Create';

  @override
  String get cancel => 'Cancel';

  @override
  String get update => 'Update';

  @override
  String get playlist_name => 'Playlist Name';

  @override
  String get name_of_playlist => 'Name of the playlist';

  @override
  String get description => 'Description';

  @override
  String get public => 'Public';

  @override
  String get collaborative => 'Collaborative';

  @override
  String get search_local_tracks => 'Search local tracks...';

  @override
  String get play => 'Play';

  @override
  String get delete => 'Delete';

  @override
  String get none => 'None';

  @override
  String get sort_a_z => 'Sort by A-Z';

  @override
  String get sort_z_a => 'Sort by Z-A';

  @override
  String get sort_artist => 'Sort by Artist';

  @override
  String get sort_album => 'Sort by Album';

  @override
  String get sort_duration => 'Sort by Duration';

  @override
  String get sort_tracks => 'Sort Tracks';

  @override
  String currently_downloading(Object tracks_length) {
    return 'Currently Downloading ($tracks_length)';
  }

  @override
  String get cancel_all => 'Cancel All';

  @override
  String get filter_artist => 'Filter artists...';

  @override
  String followers(Object followers) {
    return '$followers Followers';
  }

  @override
  String get add_artist_to_blacklist => 'Add artist to blacklist';

  @override
  String get top_tracks => 'Top Tracks';

  @override
  String get fans_also_like => 'Fans Also Like';

  @override
  String get loading => 'Loading...';

  @override
  String get loading_album => 'Loading album...';

  @override
  String get loading_artist => 'Loading artist...';

  @override
  String get album_not_found => 'Album not found';

  @override
  String get album_not_found_hint =>
      'The album you are looking for could not be found';

  @override
  String get artist_not_found => 'Artist not found';

  @override
  String get artist_not_found_hint =>
      'The artist you are looking for could not be found';

  @override
  String get unknown_release_date => 'Unknown release date';

  @override
  String get label => 'Label';

  @override
  String get album_details => 'Album Details';

  @override
  String get no_tracks_available => 'No tracks available';

  @override
  String get no_albums_available => 'No albums available';

  @override
  String get no_related_artists_found => 'No related artists found';

  @override
  String get popular_tracks => 'Popular Tracks';

  @override
  String get see_all_tracks => 'See All Tracks';

  @override
  String get all_tracks => 'All Tracks';

  @override
  String songs_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count songs',
      one: '1 song',
    );
    return '$_temp0';
  }

  @override
  String get artist => 'Artist';

  @override
  String get blacklisted => 'Blacklisted';

  @override
  String get following => 'Following';

  @override
  String get follow => 'Follow';

  @override
  String get artist_url_copied => 'Artist URL copied to clipboard';

  @override
  String added_to_queue(Object tracks) {
    return 'Added $tracks tracks to queue';
  }

  @override
  String get filter_albums => 'Filter albums...';

  @override
  String get synced => 'Synced';

  @override
  String get plain => 'Plain';

  @override
  String get shuffle => 'Shuffle';

  @override
  String get search_tracks => 'Search tracks...';

  @override
  String get released => 'Released';

  @override
  String error(Object error) {
    return 'Error $error';
  }

  @override
  String get title => 'Title';

  @override
  String get time => 'Time';

  @override
  String get more_actions => 'More actions';

  @override
  String download_count(Object count) {
    return 'Download ($count)';
  }

  @override
  String add_count_to_playlist(Object count) {
    return 'Add ($count) to Playlist';
  }

  @override
  String add_count_to_queue(Object count) {
    return 'Add ($count) to Queue';
  }

  @override
  String play_count_next(Object count) {
    return 'Play ($count) next';
  }

  @override
  String get album => 'Album';

  @override
  String copied_to_clipboard(Object data) {
    return 'Copied $data to clipboard';
  }

  @override
  String add_to_following_playlists(Object track) {
    return 'Add $track to following Playlists';
  }

  @override
  String get add => 'Add';

  @override
  String added_track_to_queue(Object track) {
    return 'Added $track to queue';
  }

  @override
  String get add_to_queue => 'Add to queue';

  @override
  String track_will_play_next(Object track) {
    return '$track will play next';
  }

  @override
  String get play_next => 'Play next';

  @override
  String removed_track_from_queue(Object track) {
    return 'Removed $track from queue';
  }

  @override
  String get remove_from_queue => 'Remove from queue';

  @override
  String get remove_from_favorites => 'Remove from favorites';

  @override
  String get save_as_favorite => 'Save as favorite';

  @override
  String get add_to_playlist => 'Add to playlist';

  @override
  String get remove_from_playlist => 'Remove from playlist';

  @override
  String get add_to_blacklist => 'Add to blacklist';

  @override
  String get remove_from_blacklist => 'Remove from blacklist';

  @override
  String get share => 'Share';

  @override
  String get mini_player => 'Mini Player';

  @override
  String get slide_to_seek => 'Slide to seek forward or backward';

  @override
  String get shuffle_playlist => 'Shuffle playlist';

  @override
  String get unshuffle_playlist => 'Unshuffle playlist';

  @override
  String get previous_track => 'Previous track';

  @override
  String get next_track => 'Next track';

  @override
  String get pause_playback => 'Pause Playback';

  @override
  String get resume_playback => 'Resume Playback';

  @override
  String get loop_track => 'Loop track';

  @override
  String get repeat_playlist => 'Repeat playlist';

  @override
  String get queue => 'Queue';

  @override
  String get alternative_track_sources => 'Alternative track sources';

  @override
  String get download_track => 'Download track';

  @override
  String tracks_in_queue(Object tracks) {
    return '$tracks tracks in queue';
  }

  @override
  String get clear_all => 'Clear all';

  @override
  String get show_hide_ui_on_hover => 'Show/Hide UI on hover';

  @override
  String get always_on_top => 'Always on top';

  @override
  String get exit_mini_player => 'Exit Mini player';

  @override
  String get download_location => 'Download location';

  @override
  String get local_library => 'Local library';

  @override
  String get add_library_location => 'Add to library';

  @override
  String get remove_library_location => 'Remove from library';

  @override
  String get account => 'Account';

  @override
  String get login_with_spotify => 'Login with your Spotify account';

  @override
  String get connect_with_spotify => 'Connect with Spotify';

  @override
  String get connect_with_youtube => 'Connect with Youtube';

  @override
  String get logout => 'Logout';

  @override
  String get logout_of_this_account => 'Logout of this account';

  @override
  String get language_region => 'Language and Region';

  @override
  String get language => 'Language';

  @override
  String get language_settings => 'Language Settings';

  @override
  String get save => 'Save';

  @override
  String get current_language => 'Current Language';

  @override
  String get select_language => 'Select Language';

  @override
  String get failed_to_load_language_settings =>
      'Failed to load language settings';

  @override
  String get system_default => 'System Default';

  @override
  String get market_place_region => 'Marketplace Region';

  @override
  String get recommendation_country => 'Recommendation Country';

  @override
  String get appearance => 'Appearance';

  @override
  String get layout_mode => 'Layout Mode';

  @override
  String get override_layout_settings =>
      'Override responsive layout mode settings';

  @override
  String get adaptive => 'Adaptive';

  @override
  String get compact => 'Compact';

  @override
  String get extended => 'Extended';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get system => 'System';

  @override
  String get accent_color => 'Accent Color';

  @override
  String get sync_album_color => 'Sync Album Color';

  @override
  String get sync_album_color_description =>
      'Sync UI color based on album artwork';

  @override
  String get playback => 'Playback';

  @override
  String get audio_quality => 'Audio Quality';

  @override
  String get select_audio_quality => 'Select audio playback quality';

  @override
  String get low_quality => 'Low';

  @override
  String get medium_quality => 'Medium';

  @override
  String get high_quality => 'High';

  @override
  String get crossfade => 'Crossfade';

  @override
  String get crossfade_description => 'Set transition effect between songs';

  @override
  String get off => 'Off';

  @override
  String seconds(Object count) {
    return '$count seconds';
  }

  @override
  String get download_path => 'Download Path';

  @override
  String get download_format => 'Download Format';

  @override
  String get download_lyrics => 'Download Lyrics';

  @override
  String get download_lyrics_description =>
      'Download lyric files along with songs';

  @override
  String get download_cover => 'Download Cover';

  @override
  String get download_cover_description =>
      'Download cover images along with songs';

  @override
  String get file_naming_format => 'File Naming Format';

  @override
  String get file_naming_format_description =>
      'Set naming rules for downloaded files';

  @override
  String get song_title => 'Song Title';

  @override
  String get artist_song_title => 'Artist - Song Title';

  @override
  String get song_title_artist => 'Song Title - Artist';

  @override
  String get album_track_song_title => 'Album - Track - Song Title';

  @override
  String get desktop => 'Desktop';

  @override
  String get auto_start => 'Auto-start on boot';

  @override
  String get auto_start_description =>
      'Run app automatically when system starts';

  @override
  String get minimize_to_tray => 'Minimize to tray';

  @override
  String get minimize_to_tray_description =>
      'Minimize to system tray instead of exiting when closing window';

  @override
  String get media_key_control => 'Media Key Control';

  @override
  String get media_key_control_description =>
      'Control playback using keyboard media keys';

  @override
  String get system_notifications => 'System Notifications';

  @override
  String get system_notifications_description =>
      'Show system notifications for track changes etc.';

  @override
  String get shortcut_settings => 'Shortcut Settings';

  @override
  String get shortcut_settings_description => 'Customize global shortcuts';

  @override
  String get set => 'Set';

  @override
  String get high => 'High';

  @override
  String get low => 'Low';

  @override
  String get pre_download_play => 'Pre-download and play';

  @override
  String get pre_download_play_description =>
      'Instead of streaming audio, download bytes and play instead (Recommended for higher bandwidth users)';

  @override
  String get skip_non_music => 'Skip non-music segments (SponsorBlock)';

  @override
  String get blacklist_description => 'Blacklisted tracks and artists';

  @override
  String get wait_for_download_to_finish =>
      'Please wait for the current download to finish';

  @override
  String get close_behavior => 'Close Behavior';

  @override
  String get close => 'Close';

  @override
  String get show_tray_icon => 'Show System tray icon';

  @override
  String get about => 'About';

  @override
  String get u_love_pyro_music => 'We know you love Pyro Music';

  @override
  String get version_info => 'Version Info';

  @override
  String get failed_to_check_for_updates => 'Failed to check for updates';

  @override
  String get import_cookie => 'Import Cookie';

  @override
  String get import_cookie_description => 'Import authentication from file';

  @override
  String get import => 'Import';

  @override
  String get export_cookie => 'Export Cookie';

  @override
  String get export_cookie_description => 'Export authentication to file';

  @override
  String get export => 'Export';

  @override
  String get clear_cookie => 'Clear Cookie';

  @override
  String get clear_cookie_description => 'Clear all authentication';

  @override
  String get show_plain_lyrics => 'Show plain lyrics';

  @override
  String get show_synced_lyrics => 'Show synced lyrics';

  @override
  String get exit_edit_mode => 'Exit edit mode';

  @override
  String get enter_edit_mode => 'Enter edit mode';

  @override
  String get export_lyrics => 'Export lyrics';

  @override
  String get import_lyrics => 'Import lyrics';

  @override
  String get search_lyrics => 'Search lyrics';

  @override
  String get lyrics_settings => 'Lyrics settings';

  @override
  String get no_track_playing => 'No track playing';

  @override
  String get login_error => 'Login Error';

  @override
  String failed_to_get_auth_service(Object platform) {
    return 'Failed to get auth service for $platform';
  }

  @override
  String login_failed(Object error) {
    return 'Login failed: $error';
  }

  @override
  String get welcome_to_pyro_music => 'Welcome to Pyro Music';

  @override
  String get let_us_configure_first =>
      'Before we start, let\'s configure some basic settings';

  @override
  String get check_for_updates => 'Check for updates';

  @override
  String get about_pyro_music => 'About Pyro Music';

  @override
  String get repository => 'Repository';

  @override
  String get bug_issues => 'Bug+Issues';

  @override
  String get license => 'License';

  @override
  String get pyro_music_description =>
      'Pyro Music, a lightweight, cross-platform, free-for-all spotify client';

  @override
  String get blacklist => 'Blacklist';

  @override
  String get please_sponsor => 'Please Sponsor/Donate';

  @override
  String get version => 'Version';

  @override
  String get build_number => 'Build Number';

  @override
  String get founder => 'Founder';

  @override
  String get made_with => 'Made with ❤️ in Bangladesh🇧🇩';

  @override
  String get kingkor_roy_tirtho => 'Kingkor Roy Tirtho';

  @override
  String copyright(Object current_year) {
    return '© 2021-$current_year Kingkor Roy Tirtho';
  }

  @override
  String get add_spotify_credentials =>
      'Add your spotify credentials to get started';

  @override
  String get credentials_will_not_be_shared_disclaimer =>
      'Don\'t worry, any of your credentials won\'t be collected or shared with anyone';

  @override
  String get know_how_to_login => 'Don\'t know how to do this?';

  @override
  String get follow_step_by_step_guide => 'Follow along the Step by Step guide';

  @override
  String spotify_cookie(Object name) {
    return 'Spotify $name Cookie';
  }

  @override
  String cookie_name_cookie(Object name) {
    return '$name Cookie';
  }

  @override
  String get fill_in_all_fields => 'Please fill in all the fields';

  @override
  String get submit => 'Submit';

  @override
  String get exit => 'Exit';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get done => 'Done';

  @override
  String get step_1 => 'Step 1';

  @override
  String get first_go_to => 'First, Go to';

  @override
  String get login_if_not_logged_in =>
      'and Login/Signup if you are not logged in';

  @override
  String get step_2 => 'Step 2';

  @override
  String get step_2_steps =>
      '1. Once you\'re logged in, press F12 or Mouse Right Click > Inspect to Open the Browser devtools.\n2. Then go the \"Application\" Tab (Chrome, Edge, Brave etc..) or \"Storage\" Tab (Firefox, Palemoon etc..)\n3. Go to the \"Cookies\" section then the \"https://accounts.spotify.com\" subsection';

  @override
  String get step_3 => 'Step 3';

  @override
  String get step_3_steps => 'Copy the value of \"sp_dc\" Cookie';

  @override
  String get success_emoji => 'Success🥳';

  @override
  String get success_message =>
      'Now you\'ve successfully Logged in with your Spotify account. Good Job, mate!';

  @override
  String get step_4 => 'Step 4';

  @override
  String get step_4_steps => 'Paste the copied \"sp_dc\" value';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get developers_settings => 'Developers Settings';

  @override
  String get debug_mode => 'Debug Mode';

  @override
  String get debug_mode_description =>
      'Enable developer tools and verbose logging';

  @override
  String get verbose_logging => 'Verbose Logging';

  @override
  String get verbose_logging_description =>
      'Record more detailed application logs';

  @override
  String get api_endpoint_config => 'API Endpoint Configuration';

  @override
  String get use_default_server => 'Use default server';

  @override
  String get configure => 'Configure';

  @override
  String get api_server_address => 'API Server Address';

  @override
  String get cache_management => 'Cache Management';

  @override
  String get cache_management_description =>
      'Clear application temporary cache data';

  @override
  String get clear => 'Clear';

  @override
  String get export_logs => 'Export Logs';

  @override
  String get export_logs_description => 'Export application log files';

  @override
  String get cache_cleared => 'Cache clearing completed';

  @override
  String clearing_failed(Object error) {
    return 'Clearing failed: $error';
  }

  @override
  String get no_logs_to_export => 'No logs available to export';

  @override
  String get logs_exported => 'Logs exported successfully';

  @override
  String export_failed(Object error) {
    return 'Export failed: $error';
  }

  @override
  String get piped_instance => 'Piped Server Instance';

  @override
  String get piped_description =>
      'The Piped server instance to use for track matching';

  @override
  String get piped_warning =>
      'Some of them might not work well. So use at your own risk';

  @override
  String get invidious_instance => 'Invidious Server Instance';

  @override
  String get invidious_description =>
      'The Invidious server instance to use for track matching';

  @override
  String get invidious_warning =>
      'Some of them might not work well. So use at your own risk';

  @override
  String get generate_playlist => 'Generate Playlist';

  @override
  String track_exists(Object track) {
    return 'Track $track already exists';
  }

  @override
  String get replace_downloaded_tracks => 'Replace all downloaded tracks';

  @override
  String get skip_download_tracks => 'Skip downloading all downloaded tracks';

  @override
  String get do_you_want_to_replace =>
      'Do you want to replace the existing track??';

  @override
  String get replace => 'Replace';

  @override
  String get skip => 'Skip';

  @override
  String select_up_to_count_type(Object count, Object type) {
    return 'Select up to $count $type';
  }

  @override
  String get select_genres => 'Select Genres';

  @override
  String get add_genres => 'Add Genres';

  @override
  String get country => 'Country';

  @override
  String get number_of_tracks_generate => 'Number of tracks to generate';

  @override
  String get acousticness => 'Acousticness';

  @override
  String get danceability => 'Danceability';

  @override
  String get energy => 'Energy';

  @override
  String get instrumentalness => 'Instrumentalness';

  @override
  String get liveness => 'Liveness';

  @override
  String get loudness => 'Loudness';

  @override
  String get speechiness => 'Speechiness';

  @override
  String get valence => 'Valence';

  @override
  String get popularity => 'Popularity';

  @override
  String get key => 'Key';

  @override
  String get duration => 'Duration (s)';

  @override
  String get tempo => 'Tempo (BPM)';

  @override
  String get mode => 'Mode';

  @override
  String get time_signature => 'Time Signature';

  @override
  String get short => 'Short';

  @override
  String get medium => 'Medium';

  @override
  String get long => 'Long';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get target => 'Target';

  @override
  String get moderate => 'Moderate';

  @override
  String get deselect_all => 'Deselect All';

  @override
  String get select_all => 'Select All';

  @override
  String get are_you_sure => 'Are you sure?';

  @override
  String get generating_playlist => 'Generating your custom playlist...';

  @override
  String selected_count_tracks(Object count) {
    return 'Selected $count tracks';
  }

  @override
  String get download_warning =>
      'If you download all Tracks at bulk you\'re clearly pirating Music & causing damage to the creative society of Music. I hope you are aware of this. Always, try respecting & supporting Artist\'s hard work';

  @override
  String get download_ip_ban_warning =>
      'BTW, your IP can get blocked on YouTube due excessive download requests than usual. IP block means you can\'t use YouTube (even if you\'re logged in) for at least 2-3 months from that IP device. And Pyro Music doesn\'t hold any responsibility if this ever happens';

  @override
  String get by_clicking_accept_terms =>
      'By clicking \'accept\' you agree to following terms:';

  @override
  String get download_agreement_1 => 'I know I\'m pirating Music. I\'m bad';

  @override
  String get download_agreement_2 =>
      'I\'ll support the Artist wherever I can and I\'m only doing this because I don\'t have money to buy their art';

  @override
  String get download_agreement_3 =>
      'I\'m completely aware that my IP can get blocked on YouTube & I don\'t hold Pyro Music or his owners/contributors responsible for any accidents caused by my current action';

  @override
  String get decline => 'Decline';

  @override
  String get accept => 'Accept';

  @override
  String get details => 'Details';

  @override
  String get youtube => 'YouTube';

  @override
  String get channel => 'Channel';

  @override
  String get likes => 'Likes';

  @override
  String get dislikes => 'Dislikes';

  @override
  String get views => 'Views';

  @override
  String get streamUrl => 'Stream URL';

  @override
  String get stop => 'Stop';

  @override
  String get sort_newest => 'Sort by newest added';

  @override
  String get sort_oldest => 'Sort by oldest added';

  @override
  String get sleep_timer => 'Sleep Timer';

  @override
  String mins(Object minutes) {
    return '$minutes Minutes';
  }

  @override
  String hours(Object hours) {
    return '$hours Hours';
  }

  @override
  String hour(Object hours) {
    return '$hours Hour';
  }

  @override
  String get custom_hours => 'Custom Hours';

  @override
  String get logs => 'Logs';

  @override
  String get developers => 'Developers';

  @override
  String get not_logged_in => 'Not logged in';

  @override
  String get search_mode => 'Search Mode';

  @override
  String get audio_source => 'Audio Source';

  @override
  String get ok => 'Ok';

  @override
  String get failed_to_encrypt => 'Failed to encrypt';

  @override
  String get encryption_failed_warning =>
      'Pyro Music uses encryption to securely store your data. But failed to do so. So it\'ll fallback to insecure storage\nIf you\'re using linux, please make sure you\'ve any secret-service (gnome-keyring, kde-wallet, keepassxc etc) installed';

  @override
  String get querying_info => 'Querying info...';

  @override
  String get piped_api_down => 'Piped API is down';

  @override
  String piped_down_error_instructions(Object pipedInstance) {
    return 'The Piped instance $pipedInstance is currently down\n\nEither change the instance or change the \'API type\' to official YouTube API\n\nMake sure to restart the app after change';
  }

  @override
  String get you_are_offline => 'You are currently offline';

  @override
  String get connection_restored => 'Your internet connection was restored';

  @override
  String get use_system_title_bar => 'Use system title bar';

  @override
  String get crunching_results => 'Crunching results...';

  @override
  String get search_to_get_results => 'Search to get results';

  @override
  String get use_amoled_mode => 'Pitch black dark theme';

  @override
  String get pitch_dark_theme => 'AMOLED Mode';

  @override
  String get normalize_audio => 'Normalize audio';

  @override
  String get change_cover => 'Change cover';

  @override
  String get add_cover => 'Add cover';

  @override
  String get restore_defaults => 'Restore defaults';

  @override
  String get download_music_codec => 'Download music codec';

  @override
  String get streaming_music_codec => 'Streaming music codec';

  @override
  String get login_with_lastfm => 'Login with Last.fm';

  @override
  String get connect => 'Connect';

  @override
  String get disconnect_lastfm => 'Disconnect Last.fm';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get login_with_your_lastfm => 'Login with your Last.fm account';

  @override
  String get scrobble_to_lastfm => 'Scrobble to Last.fm';

  @override
  String get go_to_album => 'Go to Album';

  @override
  String get discord_rich_presence => 'Discord Rich Presence';

  @override
  String get browse_all => 'Browse All';

  @override
  String get genres => 'Genres';

  @override
  String get explore_genres => 'Explore Genres';

  @override
  String get friends => 'Friends';

  @override
  String get no_lyrics_available => 'Sorry, unable find lyrics for this track';

  @override
  String get start_a_radio => 'Start a Radio';

  @override
  String get how_to_start_radio => 'How do you want to start the radio?';

  @override
  String get replace_queue_question =>
      'Do you want to replace the current queue or append to it?';

  @override
  String get endless_playback => 'Endless Playback';

  @override
  String get delete_playlist => 'Delete Playlist';

  @override
  String get delete_playlist_confirmation =>
      'Are you sure you want to delete this playlist?';

  @override
  String get local_tracks => 'Local Tracks';

  @override
  String get local_tab => 'Local';

  @override
  String get song_link => 'Song Link';

  @override
  String get skip_this_nonsense => 'Skip this nonsense';

  @override
  String get freedom_of_music => '“Freedom of Music”';

  @override
  String get freedom_of_music_palm =>
      '“Freedom of Music in the palm of your hand”';

  @override
  String get get_started => 'Let\'s get started';

  @override
  String get youtube_source_description => 'Recommended and works best.';

  @override
  String get piped_source_description =>
      'Feeling free? Same as YouTube but a lot free.';

  @override
  String get jiosaavn_source_description => 'Best for South Asian region.';

  @override
  String get invidious_source_description =>
      'Similar to Piped but with higher availability.';

  @override
  String get soundcloud_source_description =>
      'Stream and listen to music online.';

  @override
  String highest_quality(Object quality) {
    return 'Highest Quality: $quality';
  }

  @override
  String get select_audio_source => 'Select Audio Source';

  @override
  String get endless_playback_description =>
      'Automatically append new songs\nto the end of the queue';

  @override
  String get choose_your_region => 'Choose your region';

  @override
  String get choose_your_region_description =>
      'This will help Pyro Music show you the right content\nfor your location.';

  @override
  String get choose_your_language => 'Choose your language';

  @override
  String get help_project_grow => 'Help this project grow';

  @override
  String get help_project_grow_description =>
      'Pyro Music is an open-source project. You can help this project grow by contributing to the project, reporting bugs, or suggesting new features.';

  @override
  String get contribute_on_github => 'Contribute on GitHub';

  @override
  String get donate_on_open_collective => 'Donate on Open Collective';

  @override
  String get browse_anonymously => 'Browse Anonymously';

  @override
  String get enable_connect => 'Enable Connect';

  @override
  String get enable_connect_description =>
      'Control Pyro Music from other devices';

  @override
  String get devices => 'Devices';

  @override
  String get select => 'Select';

  @override
  String connect_client_alert(Object client) {
    return 'You\'re being controlled by $client';
  }

  @override
  String get this_device => 'This Device';

  @override
  String get remote => 'Remote';

  @override
  String get stats => 'Stats';

  @override
  String and_n_more(Object count) {
    return 'and $count more';
  }

  @override
  String get recently_played => 'Recently Played';

  @override
  String get browse_more => 'Browse More';

  @override
  String get no_title => 'No Title';

  @override
  String get not_playing => 'Not playing';

  @override
  String get epic_failure => 'Epic failure!';

  @override
  String added_num_tracks_to_queue(Object tracks_length) {
    return 'Added $tracks_length tracks to queue';
  }

  @override
  String get pyro_music_has_an_update => 'Pyro Music has an update';

  @override
  String get download_now => 'Download Now';

  @override
  String nightly_version(Object nightlyBuildNum) {
    return 'Pyro Music Nightly $nightlyBuildNum has been released';
  }

  @override
  String release_version(Object version) {
    return 'Pyro Music v$version has been released';
  }

  @override
  String get read_the_latest => 'Read the latest ';

  @override
  String get release_notes => 'release notes';

  @override
  String get pick_color_scheme => 'Pick color scheme';

  @override
  String get choose_the_device => 'Choose the device:';

  @override
  String get multiple_device_connected =>
      'There are multiple device connected.\nChoose the device you want this action to take place';

  @override
  String get nothing_found => 'Nothing found';

  @override
  String get the_box_is_empty => 'The box is empty';

  @override
  String get top_artists => 'Top Artists';

  @override
  String get top_albums => 'Top Albums';

  @override
  String get this_week => 'This week';

  @override
  String get this_month => 'This month';

  @override
  String get last_6_months => 'Last 6 months';

  @override
  String get this_year => 'This year';

  @override
  String get last_2_years => 'Last 2 years';

  @override
  String get all_time => 'All time';

  @override
  String powered_by_provider(Object providerName) {
    return 'Powered by $providerName';
  }

  @override
  String get email => 'Email';

  @override
  String get profile_followers => 'Followers';

  @override
  String get birthday => 'Birthday';

  @override
  String get subscription => 'Subscription';

  @override
  String get not_born => 'Not born';

  @override
  String get hacker => 'Hacker';

  @override
  String get profile => 'Profile';

  @override
  String get no_name => 'No Name';

  @override
  String get edit => 'Edit';

  @override
  String get user_profile => 'User Profile';

  @override
  String count_plays(Object count) {
    return '$count plays';
  }

  @override
  String get streaming_fees_hypothetical => 'Streaming fees (hypothetical)';

  @override
  String get minutes_listened => 'Minutes listened';

  @override
  String get streamed_songs => 'Streamed songs';

  @override
  String count_streams(Object count) {
    return '$count streams';
  }

  @override
  String get owned_by_you => 'Owned by you';

  @override
  String copied_shareurl_to_clipboard(Object shareUrl) {
    return 'Copied $shareUrl to clipboard';
  }

  @override
  String get spotify_hipotetical_calculation =>
      '*This is calculated based on Spotify\'s per stream\npayout of \$0.003 to \$0.005. This is a hypothetical\ncalculation to give user insight about how much they\nwould have paid to the artists if they were to listen\ntheir song in Spotify.';

  @override
  String count_mins(Object minutes) {
    return '$minutes mins';
  }

  @override
  String get summary_minutes => 'minutes';

  @override
  String get summary_listened_to_music => 'Listened to music';

  @override
  String get summary_songs => 'songs';

  @override
  String get summary_streamed_overall => 'Streamed overall';

  @override
  String get summary_owed_to_artists => 'Owed to artists\nthis month';

  @override
  String get summary_artists => 'artist\'s';

  @override
  String get summary_music_reached_you => 'Music reached you';

  @override
  String get summary_full_albums => 'full albums';

  @override
  String get summary_got_your_love => 'Got your love';

  @override
  String get summary_playlists => 'playlists';

  @override
  String get summary_were_on_repeat => 'Were on repeat';

  @override
  String total_money(Object money) {
    return 'Total $money';
  }

  @override
  String get webview_not_found => 'Webview not found';

  @override
  String get webview_not_found_description =>
      'No webview runtime is installed in your device.\nIf it\'s installed make sure it\'s in the Environment PATH\n\nAfter installing, restart the app';

  @override
  String get unsupported_platform => 'Unsupported platform';

  @override
  String get cache_music => 'Cache music';

  @override
  String get open => 'Open';

  @override
  String get cache_folder => 'Cache folder';

  @override
  String get open_cache_folder => 'Open Cache folder';

  @override
  String get clear_cache => 'Clear cache';

  @override
  String get clear_cache_confirmation => 'Do you want to clear the cache?';

  @override
  String get export_cache_files => 'Export Cached Files';

  @override
  String found_n_files(Object count) {
    return 'Found $count files';
  }

  @override
  String get export_cache_confirmation =>
      'Do you want to export these files to';

  @override
  String exported_n_out_of_m_files(Object files, Object filesExported) {
    return 'Exported $filesExported out of $files files';
  }

  @override
  String get undo => 'Undo';

  @override
  String get download_all => 'Download all';

  @override
  String get add_all_to_playlist => 'Add all to playlist';

  @override
  String get add_all_to_queue => 'Add all to queue';

  @override
  String get play_all_next => 'Play all next';

  @override
  String get pause => 'Pause';

  @override
  String get view_all => 'View all';

  @override
  String get no_tracks_added_yet =>
      'Looks like you haven\'t added any tracks yet';

  @override
  String get no_tracks => 'Looks like there are no tracks here';

  @override
  String get no_tracks_listened_yet =>
      'Looks like you haven\'t listened to anything yet';

  @override
  String get not_following_artists => 'You\'re not following any artists';

  @override
  String get no_favorite_albums_yet =>
      'Looks like you haven\'t added any albums to your favorites yet';

  @override
  String get no_logs_found => 'No logs found';

  @override
  String get youtube_engine => 'YouTube Engine';

  @override
  String youtube_engine_not_installed_title(Object engine) {
    return '$engine is not installed';
  }

  @override
  String youtube_engine_not_installed_message(Object engine) {
    return '$engine is not installed in your system.';
  }

  @override
  String youtube_engine_set_path(Object engine) {
    return 'Make sure it\'s available in the PATH variable or\nset the absolute path to the $engine executable below';
  }

  @override
  String get youtube_engine_unix_issue_message =>
      'In macOS/Linux/unix like OS\'s, setting path on .zshrc/.bashrc/.bash_profile etc. won\'t work.\nYou need to set the path in the shell configuration file';

  @override
  String get download => 'Download';

  @override
  String get file_not_found => 'File not found';

  @override
  String get custom => 'Custom';

  @override
  String get add_custom_url => 'Add custom URL';

  @override
  String get remove => 'Remove';

  @override
  String get clear_queue => 'Clear Queue';

  @override
  String get generate => 'Generate';

  @override
  String get timeZone => 'Time Zone';

  @override
  String get timeFormat => 'Time Format';

  @override
  String get use24HourFormat => 'Use 24-hour format';

  @override
  String get chinese => 'Chinese';

  @override
  String get english => 'English';

  @override
  String get japanese => 'Japanese';

  @override
  String get cookie_import_success => 'Cookie imported successfully';

  @override
  String import_failed(Object error) {
    return 'Import failed: $error';
  }

  @override
  String get cookie_export_success => 'Cookie exported successfully';

  @override
  String get cookie_cleared => 'Cookie cleared';

  @override
  String clear_failed(Object error) {
    return 'Clear failed: $error';
  }

  @override
  String get audio_quality_description => 'Select audio playback quality';

  @override
  String get accounts => 'Accounts';

  @override
  String get developers_options => 'Developer Options';

  @override
  String get cookie_management => 'Cookie Management';

  @override
  String get account_management => 'Account Management';

  @override
  String logged_out(Object platform) {
    return '$platform logged out';
  }

  @override
  String logout_failed(Object error) {
    return 'Logout failed: $error';
  }

  @override
  String logged_in(Object user) {
    return 'Logged in: $user';
  }

  @override
  String get choose_theme_mode => 'Choose application theme mode';

  @override
  String get follow_system => 'Follow System';

  @override
  String get light_mode => 'Light';

  @override
  String get dark_mode => 'Dark';

  @override
  String get amoled_mode => 'AMOLED Mode';

  @override
  String get amoled_mode_description =>
      'Use pure black background for dark theme';

  @override
  String get choose_accent_color => 'Choose application accent color scheme';

  @override
  String get paste_lrc_here => 'Paste LRC format lyrics here...';

  @override
  String get lyrics_content_cannot_be_empty => 'Lyrics content cannot be empty';

  @override
  String get import_success => 'Imported successfully';

  @override
  String get input_search_keywords => 'Input search keywords...';

  @override
  String get search_keywords_cannot_be_empty =>
      'Search keywords cannot be empty';

  @override
  String get no_lyrics_found => 'No matching lyrics found';

  @override
  String get search_results => 'Search Results';

  @override
  String get lyrics_applied_successfully => 'Lyrics applied successfully';

  @override
  String get auto_scroll => 'Auto Scroll';

  @override
  String get highlight_current_line => 'Highlight Current Line';

  @override
  String get show_translation => 'Show Translation';

  @override
  String get font_size => 'Font Size';

  @override
  String get line_spacing => 'Line Spacing';

  @override
  String cookie_import_failed(Object error) {
    return 'Cookie import failed: $error';
  }

  @override
  String cookie_export_failed(Object error) {
    return 'Cookie export failed: $error';
  }

  @override
  String get home => 'Home';

  @override
  String get good_morning => 'Good morning';

  @override
  String get good_afternoon => 'Good afternoon';

  @override
  String get good_evening => 'Good evening';

  @override
  String welcome_back(Object username) {
    return 'Welcome back, $username';
  }

  @override
  String get search_for_music => 'Search for music';

  @override
  String get search_hint =>
      'Find your favorite songs, artists, albums, and playlists';

  @override
  String get all => 'All';

  @override
  String get featured_playlists => 'Featured Playlists';

  @override
  String get see_all => 'See All';

  @override
  String get loading_playlists => 'Loading playlists...';

  @override
  String get no_featured_playlists => 'No featured playlists available';

  @override
  String get recent_tracks => 'Recent Tracks';

  @override
  String get loading_tracks => 'Loading tracks...';

  @override
  String get no_recent_tracks => 'No recent tracks found';

  @override
  String get recommended_artists => 'Recommended Artists';

  @override
  String get loading_artists => 'Loading artists...';

  @override
  String get no_recommended_artists => 'No recommended artists available';

  @override
  String get start_listening_hint => 'Start listening to see your history here';

  @override
  String no_results_found(Object query) {
    return 'No results found for \"$query\"';
  }

  @override
  String search_failed(Object error) {
    return 'Search failed: $error';
  }

  @override
  String by_author(Object author) {
    return 'By $author';
  }

  @override
  String get queue_is_empty => 'Queue is empty';

  @override
  String get add_tracks_to_get_started => 'Add some tracks to get started';

  @override
  String queue_count(Object count) {
    return '$count tracks';
  }

  @override
  String get playlist => 'Playlist';

  @override
  String get loading_playlist => 'Loading playlist...';

  @override
  String get playlist_not_found => 'Playlist not found';

  @override
  String tracks_count(Object count) {
    return '$count tracks';
  }

  @override
  String duration_total(Object duration) {
    return 'Total duration: $duration';
  }

  @override
  String get shuffle_play => 'Shuffle Play';

  @override
  String get play_all => 'Play All';

  @override
  String get repeat => 'Repeat';

  @override
  String get go_back => 'Go Back';

  @override
  String get release_date => 'Release Date';

  @override
  String followers_count(Object count) {
    return '$count followers';
  }
}
