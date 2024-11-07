import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Test App'),
          backgroundColor: Colors.grey[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  // Request Location Permission Logic
                },
                child: const Text('Request Location Permission'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  // Request Notification Permission Logic
                },
                child: const Text('Request Notification Permission'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  // Start Location Update Logic
                },
                child: const Text('Start Location Update'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  // Stop Location Update Logic
                },
                child: const Text('Stop Location Update'),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // Number of location requests
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[200],
                      child: ListTile(
                        title: Text('Request${index + 1}'),
                        subtitle: const Row(
                          children: [
                            Text('Lat: 1.234'),
                            SizedBox(width: 10),
                            Text('Lng: 4.321'),
                            SizedBox(width: 10),
                            Text('Speed: 45m'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
