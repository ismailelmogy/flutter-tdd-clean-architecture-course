import 'package:flutter/material.dart';

/// A widget that displays a message.
class MessageDisplay extends StatelessWidget {
  /// Creates an instance of [MessageDisplay] with a required [message].
  const MessageDisplay({
    required this.message,
    super.key,
  });

  /// The message to be displayed.
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
