import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const GitBeyApp());
}

class GitBeyApp extends StatelessWidget {
  const GitBeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'GitBey',
      home: GitHubUsernameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GitHubUsernameScreen extends StatefulWidget {
  const GitHubUsernameScreen({super.key});

  @override
  State<GitHubUsernameScreen> createState() => _GitHubUsernameScreenState();
}

class _GitHubUsernameScreenState extends State<GitHubUsernameScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;
  String? _error;
  List<dynamic>? _commits;

  Future<void> _fetchCommits() async {
    setState(() {
      _loading = true;
      _error = null;
      _commits = null;
    });
    final username = _controller.text.trim();
    if (username.isEmpty) {
      setState(() {
        _loading = false;
        _error = 'Please enter a GitHub username.';
      });
      return;
    }
    final url = Uri.parse(
      'https://api.github.com/users/$username/events/public',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final events = json.decode(response.body) as List;
        final commits = events
            .where((e) => e['type'] == 'PushEvent')
            .expand((e) => e['payload']['commits'] as List)
            .toList();
        if (commits.isEmpty) {
          setState(() {
            _error = 'No commits found.';
            _loading = false;
          });
        } else {
          setState(() {
            _commits = commits.take(50).toList();
            _loading = false;
          });
        }
      } else if (response.statusCode == 404) {
        setState(() {
          _error = 'User not found.';
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to fetch commits. Try again later.';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Network error. Please try again.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('GitBey: GitHub to Beyoncé'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your GitHub username',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              CupertinoTextField(
                controller: _controller,
                placeholder: 'GitHub username',
                onSubmitted: (_) => _fetchCommits(),
                enabled: !_loading,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: _loading ? null : _fetchCommits,
                child: _loading
                    ? const CupertinoActivityIndicator()
                    : const Text('Fetch Commits'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: const TextStyle(color: CupertinoColors.systemRed),
                ),
              ],
              if (_commits != null) ...[
                const SizedBox(height: 24),
                Text(
                  'Found ${_commits!.length} commits!',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // For now, just show the first few commit messages
                ..._commits!
                    .take(3)
                    .map(
                      (c) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          c['message'] ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
