import 'package:flutter/material.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/notification_model.dart';

class NotificationCard extends StatefulWidget {
  final String title;
  final String content;
  final bool isRead;
  final String time;
  final NotificationModel notificationModel;

  const NotificationCard({
    super.key,
    required this.title,
    required this.content,
    this.isRead = false,
    required this.time,
    required this.notificationModel,
  });

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final User? user = widget.notificationModel.task.users.isNotEmpty
        ? widget.notificationModel.task.users.first
        : null;
    final description = widget.notificationModel.task.description;
    final textPainter = TextPainter(
      text: TextSpan(
        text: description,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: mediaQuery.width - 100);
    final isLongDescription = textPainter.didExceedMaxLines;
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: mediaQuery.height / 100,
        horizontal: mediaQuery.width / 50,
      ),
      child: Padding(
        padding: EdgeInsets.all(mediaQuery.width / 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: user != null && user.image.isNotEmpty
                    ? NetworkImage(user.image) as ImageProvider
                    : null,
                backgroundColor: Colors.white,
                child: user == null || user.image.isEmpty
                    ? Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 235, 175, 98))),
                        child: Icon(
                          Icons.notifications,
                          color: const Color.fromARGB(255, 235, 175, 98),
                          size: 30,
                        ),
                      )
                    : null,
              ),
              title: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: _isExpanded ? null : 2,
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  if (isLongDescription)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded
                            ? S.of(context).read_more
                            : S.of(context).show_less,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  Text(
                    widget.time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
