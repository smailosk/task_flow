import 'package:flutter/material.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/services/storage_service.dart';

class ProfilePicture extends StatefulWidget {
  final String userId;

  const ProfilePicture({super.key, required this.userId});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  late Future<String?> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlFuture =
        locator<StorageService>().getProfilePictureUrl(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _imageUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading state
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show error state
        } else if (snapshot.hasData) {
          final imageUrl = snapshot.data!;
          return Image.network(imageUrl);
        } else {
          return const Text('No image available'); // Show default state
        }
      },
    );
  }
}
