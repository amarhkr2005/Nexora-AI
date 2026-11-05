import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NexoraApp());
}

class NexoraApp extends StatefulWidget {
  const NexoraApp({Key? key}) : super(key: key);

  @override
  State<NexoraApp> createState() => _NexoraAppState();
}

class _NexoraAppState extends State<NexoraApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexora AI Super App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

      // Light Minimalist Theme
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        primaryColor: Colors.black,
        cardColor: const Color(0xFFFFFFFF),
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Color(0xFF333333),
          surface: Color(0xFFF0F0F0),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9F9F9),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      // Premium Black Theme (ChatGPT Style)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF171717),
        primaryColor: Colors.white,
        cardColor: const Color(0xFF212121),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(0xFFB4B4B4),
          surface: Color(0xFF2F2F2F),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF171717),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      home: NexoraMainScreen(onToggleTheme: toggleTheme, isDarkMode: _themeMode == ThemeMode.dark),
    );
  }
}

// -----------------------------------------------------------------------------
// MODELS & SERVICES
// -----------------------------------------------------------------------------

class ChatMessage {
  final String id;
  final String sender; // 'user' or 'nexora'
  final String text;
  final String? codeSnippet;
  final String? codeLanguage;
  final List<String>? actionButtons;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    this.codeSnippet,
    this.codeLanguage,
    this.actionButtons,
    required this.timestamp,
  });
}

class AIDepartment {
  final String id;
  final String name;
  final IconData icon;
  final String description;
  final bool isAvailable;

  AIDepartment({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    this.isAvailable = true,
  });
}

// Orchestrator Engine Simulation
class OrchestrationEngine {
  static Future<ChatMessage> processMessage(String userInput) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final String lower = userInput.toLowerCase();

    // Intent 1: Result Search / Education
    if (lower.contains("result") || lower.contains("12th") || lower.contains("up board")) {
      return ChatMessage(
        id: DateTime.now().toString(),
        sender: 'nexora',
        text: 'UP Board (Class 10th/12th) Result Portal Access:\n\n'
            'मैंने आपकी आवश्यकता अनुसार आधिकारिक परिणाम पोर्टल लिंक तैयार किया है। सुरक्षा कारणों से अपना Roll Number एवं School Code प्रविष्ट करें।',
        actionButtons: ['Open upmsp.edu.in', 'Open cbse.gov.in'],
        timestamp: DateTime.now(),
      );
    }

    // Intent 2: Code Generation
    if (lower.contains("code") || lower.contains("website") || lower.contains("html") || lower.contains("python")) {
      return ChatMessage(
        id: DateTime.now().toString(),
        sender: 'nexora',
        text: 'यहाँ आपकी आवश्यकता अनुसार स्वच्छ और ऑप्टिमाइज़्ड कोड है:',
        codeLanguage: 'html',
        codeSnippet: '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Nexora AI Generated Page</title>
  <style>
    body { background: #171717; color: #fff; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .card { background: #212121; padding: 2rem; border-radius: 12px; border: 1px solid #333; }
  </style>
</head>
<body>
  <div class="card">
    <h1>Welcome to Nexora AI</h1>
    <p>Generated smoothly by AI Orchestrator Engine.</p>
  </div>
</body>
</html>''',
        timestamp: DateTime.now(),
      );
    }

    // Intent 3: Cyber Security / Defensive Learning
    if (lower.contains("cyber") || lower.contains("hacking") || lower.contains("security") || lower.contains("owasp")) {
      return ChatMessage(
        id: DateTime.now().toString(),
        sender: 'nexora',
        text: '🛡️ Nexora Defensive Security Guidance:\n\n'
            '1. Secure Coding (OWASP Top 10): हमेशा Input Validation करें।\n'
            '2. Password Storage: Argon2 या bcrypt Hashing का उपयोग करें।\n'
            '3. Network Defense: SSL/TLS 1.3 एन्क्रिप्शन अनिवार्य करें।\n\n'
            'नोट: Nexora केवल सुरक्षा ऑडिटिंग और रक्षात्मक शिक्षा का समर्थन करता है।',
        timestamp: DateTime.now(),
      );
    }

    // Default Intelligence
    return ChatMessage(
      id: DateTime.now().toString(),
      sender: 'nexora',
      text: 'मैं समझ गया। मैंने आपके अनुरोध "$userInput" को प्रोसेस कर लिया है। मैं और किस प्रकार सहायता कर सकता हूँ?',
      timestamp: DateTime.now(),
    );
  }
}

// -----------------------------------------------------------------------------
// MAIN UI SCREEN
// -----------------------------------------------------------------------------

class NexoraMainScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const NexoraMainScreen({Key? key, required this.onToggleTheme, required this.isDarkMode}) : super(key: key);

  @override
  State<NexoraMainScreen> createState() => _NexoraMainScreenState();
}

class _NexoraMainScreenState extends State<NexoraMainScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final List<AIDepartment> _departments = [
    AIDepartment(id: '1', name: 'AI Chat Assistant', icon: Icons.chat_bubble_outline, description: 'General Purpose Intelligence'),
    AIDepartment(id: '2', name: 'Web Search & Deep Research', icon: Icons.travel_explore, description: 'Realtime Search with Citations'),
    AIDepartment(id: '3', name: 'AI Voice Conversation', icon: Icons.graphic_eq, description: 'Realtime Voice Interactions'),
    AIDepartment(id: '4', name: 'AI Image Studio', icon: Icons.palette_outlined, description: 'Text-to-Image & Variations'),
    AIDepartment(id: '5', name: 'AI Video Studio', icon: Icons.videocam_outlined, description: 'Generative AI Video Tools'),
    AIDepartment(id: '6', name: 'Advanced Coding', icon: Icons.code, description: 'Full-stack Code & Architecture'),
    AIDepartment(id: '7', name: 'Education & Results', icon: Icons.school_outlined, description: 'UP Board, CBSE & NCERT'),
    AIDepartment(id: '8', name: 'Cybersecurity Education', icon: Icons.security, description: 'Defensive Auditing & OWASP'),
    AIDepartment(id: '9', name: 'Government Services', icon: Icons.account_balance_outlined, description: 'Parivahan, Challan & Schemes'),
    AIDepartment(id: '10', name: 'Document Analysis', icon: Icons.picture_as_pdf_outlined, description: 'PDF Parsing & Summarization'),
  ];

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        id: 'welcome',
        sender: 'nexora',
        text: 'नमस्कार! मैं Nexora AI हूँ। मैं आपकी किस प्रकार सहायता कर सकता हूँ?',
        timestamp: DateTime.now(),
      ),
    );
  }

  void _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().toString(),
      sender: 'user',
      text: text,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
      _inputController.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    final aiMsg = await OrchestrationEngine.processMessage(text);

    setState(() {
      _messages.add(aiMsg);
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _openToolsMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nexora AI Departments & Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                ),
                itemCount: _departments.length,
                itemBuilder: (context, index) {
                  final dept = _departments[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(dept.icon, size: 28, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 8),
                        Text(dept.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1),
                        const SizedBox(height: 4),
                        Text(dept.description, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.secondary), maxLines: 2),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, size: 32),
                  const SizedBox(width: 12),
                  Text('NEXORA AI', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('New Chat'),
              onTap: () {
                setState(() => _messages.clear());
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Tools & Departments'),
              onTap: () {
                Navigator.pop(context);
                _openToolsMenu();
              },
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Chat History', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  ListTile(leading: Icon(Icons.chat_bubble_outline, size: 18), title: Text('UP Board 12th Result Query')),
                  ListTile(leading: Icon(Icons.chat_bubble_outline, size: 18), title: Text('HTML Landing Page Code')),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
              onTap: widget.onToggleTheme,
            ),
            const ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('User Profile & Admin'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, size: 20),
            SizedBox(width: 8),
            Text('NEXORA AI'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: _openToolsMenu,
            tooltip: 'Open Tools Menu',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg.sender == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isUser ? Theme.of(context).colorScheme.surface : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(isUser ? Icons.person : Icons.auto_awesome, size: 16, color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 6),
                              Text(isUser ? 'You' : 'Nexora AI', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SelectableText(msg.text, style: const TextStyle(fontSize: 14, height: 1.4)),
                          if (msg.codeSnippet != null) ...[
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(msg.codeLanguage ?? 'code', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                      IconButton(
                                        icon: const Icon(Icons.copy, size: 14, color: Colors.white),
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(text: msg.codeSnippet!));
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Code copied to clipboard!')));
                                        },
                                      )
                                    ],
                                  ),
                                  SelectableText(
                                    msg.codeSnippet!,
                                    style: const TextStyle(fontFamily: 'Courier', fontSize: 12, color: Colors.greenAccent),
                                  ),
                                ],
                              ),
                            )
                          ],
                          if (msg.actionButtons != null) ...[
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              children: msg.actionButtons!
                                  .map((btn) => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        ),
                                        onPressed: () {},
                                        child: Text(btn, style: const TextStyle(fontSize: 12)),
                                      ))
                                  .toList(),
                            )
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                    SizedBox(width: 10),
                    Text('Nexora AI processing intent...', style: TextStyle(fontSize
