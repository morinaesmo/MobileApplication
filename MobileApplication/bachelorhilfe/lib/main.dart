import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});
}

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
// LoginScreen
// ------------------------------------------------------------


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
// TopicDetailScreen
// ------------------------------------------------------------

class TopicDetailScreen extends StatelessWidget {
  final String topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topic)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Quellen für $topic',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => const BibliothekScreen(),
                   ),
                );
              },
              icon: Icon(Icons.book),
              label: Text("Bücher"),
            ),

            SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => const PDFScreen(),
                   ),
                );
              },
              icon: Icon(Icons.picture_as_pdf),
              label: Text("PDFs"),
            ),
            
            SizedBox(height: 6),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => const WebScreen(),
                  ),
                );
              },
              icon: Icon(Icons.web),
              label: Text("Webseite"),
            ),
          ],
        ),
      ),
    );
  }
}


// ------------------------------------------------------------
// BibliothekScreen
// ------------------------------------------------------------

class BibliothekScreen extends StatefulWidget {
  const BibliothekScreen({super.key});

  @override
  State<BibliothekScreen> createState() => _BibliothekScreenState();
}

class _BibliothekScreenState extends State<BibliothekScreen> {
  // Liste der Bücher
  final List<Book> _books = [];

  // Controller für Textfelder
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void _addBook() {
    if (_titleController.text.trim().isEmpty ||
        _authorController.text.trim().isEmpty) 
      return;

    setState(() {
      _books.add(
        Book(
          title: _titleController.text.trim(),
          author: _authorController.text.trim(),
        ),
      );
    });

    _titleController.clear();
    _authorController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bücher"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Eingabe: Titel
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Buchtitel",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            // Eingabe: Autor
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: "Autor",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            // Button: Buch hinzufügen
            ElevatedButton.icon(
              onPressed: _addBook,
              icon: const Icon(Icons.add),
              label: const Text("Buch hinzufügen"),
            ),
            const SizedBox(height: 16),
            // Liste der Bücher
            Expanded(
              child: _books.isEmpty
                  ? const Center(
                      child: Text("Noch keine Bücher hinzugefügt"),
                    )
                  : ListView.builder(
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        final book = _books[index];
                        return ListTile(
                          leading: const Icon(Icons.book),
                          title: Text(book.title),
                          subtitle: Text(book.author),
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
// WEBScreen
// ------------------------------------------------------------

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web"),
      ),
      body: Center(
        child: Text(
          "Hier kommen später alle Web rein",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// PdfScreen
// ------------------------------------------------------------

class PDFScreen extends StatelessWidget {
  const PDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),
      ),
      body: Center(
        child: Text(
          "Hier kommen später alle PDF rein",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// BuchDetailScreen
// ------------------------------------------------------------

// ------------------------------------------------------------
// KapitelAnalyseScreen
// ------------------------------------------------------------

// ------------------------------------------------------------
// ZitatScreen
// ------------------------------------------------------------

// ------------------------------------------------------------
// TimerScreen
// ------------------------------------------------------------

// ------------------------------------------------------------
// ProfilScreen
//Scaffold,AppBar,Column,Card,ListTile,SwitchListTile
//
// ------------------------------------------------------------

