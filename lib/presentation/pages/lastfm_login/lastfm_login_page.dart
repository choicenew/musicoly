import 'package:flutter/material.dart';
import 'package:pyro_music/generated/app_localizations.dart';

/// LastFM登录页面
class LastFMLoginPage extends StatefulWidget {
  /// 构造函数
  const LastFMLoginPage({super.key});

  @override
  State<LastFMLoginPage> createState() => _LastFMLoginPageState();
}

class _LastFMLoginPageState extends State<LastFMLoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: 实现LastFM登录逻辑
      await Future.delayed(const Duration(seconds: 2)); // 模拟登录过程
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.login_failed(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.login_with_lastfm),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/lastfm-logo.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: l10n.username,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: l10n.password,
                prefixIcon: const Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(l10n.login),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
