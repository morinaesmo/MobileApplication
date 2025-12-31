import 'package:flutter/material.dart';

void main() {
  runApp(BachelorApp());
}

class BachelorApp extends StatelessWidget {
  const BachelorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bachelorhilfe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TopicHomeScreen(),
    );
  }
}

// ------------------------------------------------------------
// HOME SCREEN – Topic hinzufügen
// ------------------------------------------------------------
class TopicHomeScreen extends StatefulWidget {
  const TopicHomeScreen({super.key});

  @override
  _TopicHomeScreenState createState() => _TopicHomeScreenState();
}

class _TopicHomeScreenState extends State<TopicHomeScreen> {
  List<String> topics = [];
  final TextEditingController controller = TextEditingController();

  void addTopic() {
    if (controller.text.trim().isEmpty) return;
    setState(() {
      topics.add(controller.text.trim());
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bachelorhilfe")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Topic hinzufügen", style: TextStyle(fontSize: 22)),
            SizedBox(height: 16),

            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Topic eingeben",
              ),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: addTopic,
              child: Text("Hinzufügen"),
            ),

            SizedBox(height: 30),
            Text("Deine Topics:", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(topics[index]),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TopicDetailScreen(topic: topics[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// DETAIL SCREEN – Topic
// ------------------------------------------------------------
class TopicDetailScreen extends StatelessWidget {
  final String topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topic)),
      body: Center(
        child: Text(
          "Noch leer – Inhalte kommen später!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
