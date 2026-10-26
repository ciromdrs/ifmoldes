import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Link extends StatelessWidget {
  final String text;
  final String destination;

  const new({super.key, required this.text, required this.destination});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        _launchUrl(Uri.parse(destination));
      },
      child: Wrap(
        children: [
          Text(text, style: TextStyle(color: theme.colorScheme.primary)),
          Icon(Icons.arrow_outward, size: 12),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
