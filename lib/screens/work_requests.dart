import 'package:flutter/material.dart';

class WorkRequest {
  final int id;
  final String date;
  final String time;
  final String description; // New field for description
  final String imageUrl; // New field for image URL

  WorkRequest({
    required this.id,
    required this.date,
    required this.time,
    required this.description,
    required this.imageUrl,
  });
}

// Sample workRequests data
final List<WorkRequest> workRequests = [
  WorkRequest(
    id: 1,
    date: '2022-04-01',
    time: '10:00 AM',
    description: 'Issue description 1', // Sample description
    imageUrl: 'https://via.placeholder.com/150', // Sample image URL
  ),
  WorkRequest(
    id: 2,
    date: '2022-04-02',
    time: '11:30 AM',
    description: 'Issue description 2',
    imageUrl: 'https://via.placeholder.com/150',
  ),
  WorkRequest(
    id: 3,
    date: '2022-04-03',
    time: '02:45 PM',
    description: 'Issue description 3',
    imageUrl: 'https://via.placeholder.com/150',
  ),
];

class WorkRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Requests'),
      ),
      body: ListView.builder(
        itemCount: workRequests.length,
        itemBuilder: (context, index) {
          final request = workRequests[index];
          return ExpansionTile(
            title: Text('Request ${request.id}'),
            children: [
              ListTile(
                title: Text('Date: ${request.date}'),
              ),
              ListTile(
                title: Text('Time: ${request.time}'),
              ),
              ListTile(
                title: Text('Description: ${request.description}'),
              ),
              ListTile(
                title: Text('Image URL: ${request.imageUrl}'), // Display image URL
              ),
              // You can load the image here using NetworkImage(request.imageUrl)
            ],
          );
        },
      ),
    );
  }
}
