import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatBubble extends StatelessWidget {
  final bool isMine;
  final String? photoUrl;
  final String message;

  final double _iconSize = 24.0;

  const ChatBubble({
    required this.isMine,
    required this.photoUrl,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Widget> widgets = [];

    // user avatar
    widgets.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_iconSize),
          child: isMine
              ? photoUrl == null
                  ? const _DefaultPersonWidget()
                  : CachedNetworkImage(
                      imageUrl: photoUrl!,
                      width: _iconSize,
                      height: _iconSize,
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) =>
                          const _DefaultPersonWidget(),
                      placeholder: (context, url) =>
                          const _DefaultPersonWidget(),
                    )
              : SvgPicture.asset(
                  'assets/google_gemini.svg',
                  width: _iconSize,
                  height: _iconSize,
                ),
        ),
      ),
    );

    // message bubble
    widgets.add(
      Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: isMine
              ? theme.colorScheme.onSecondary
              : theme.colorScheme.onSurface.withOpacity(0.1),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 14.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        child: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isMine ? widgets.reversed.toList() : widgets,
      ),
    );
  }
}

class _DefaultPersonWidget extends StatelessWidget {
  const _DefaultPersonWidget();

  @override
  Widget build(BuildContext context) => Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.primary,
        size: 24.0,
      );
}
