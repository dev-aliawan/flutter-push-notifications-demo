class NotificationMessage {
  final String title;
  final String body;
  final String? imageUrl;

  NotificationMessage({
    required this.title,
    required this.body,
    this.imageUrl,
  });
}
