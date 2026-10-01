import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts_service/flutter_contacts_service.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

void main() {
  runApp(const Bai3App());
}

// APP
class Bai3App extends StatelessWidget {
  const Bai3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 3 - Contacts & SMS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Bai3HomePage(),
    );
  }
}

// TRANG CHÍNH
class Bai3HomePage extends StatelessWidget {
  const Bai3HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 3 - Contacts & SMS')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone_android, size: 80),

            const SizedBox(height: 20),

            const Text(
              'Truy cập dữ liệu điện thoại',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // ---------------- SMS ----------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SmsReaderPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.sms),
                label: const Text(
                  'Đọc tin nhắn SMS',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ---------------- CONTACTS ----------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactsReaderPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.contacts),
                label: const Text(
                  'Xem danh bạ',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================= SMS ==========================
class SmsReaderPage extends StatefulWidget {
  const SmsReaderPage({super.key});

  @override
  State<SmsReaderPage> createState() => _SmsReaderPageState();
}

class _SmsReaderPageState extends State<SmsReaderPage> {
  final SmsQuery _query = SmsQuery();

  List<SmsMessage> _messages = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _requestSmsPermission();
  }

  // XIN QUYỀN SMS
  Future<void> _requestSmsPermission() async {
    final PermissionStatus status = await Permission.sms.request();

    if (status.isGranted) {
      await _loadMessages();
    } else {
      setState(() {
        _isLoading = false;
      });

      _showMessage('Vui lòng cấp quyền đọc tin nhắn SMS.');
    }
  }

  // ĐỌC SMS
  Future<void> _loadMessages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<SmsMessage> messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        sort: true,
      );

      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      _showMessage('Không thể đọc SMS: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // GIAO DIỆN SMS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách SMS'),
        actions: [
          IconButton(onPressed: _loadMessages, icon: const Icon(Icons.refresh)),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _messages.isEmpty
          ? const Center(
              child: Text(
                'Không có tin nhắn nào.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final SmsMessage message = _messages[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.sms)),
                    title: Text(message.sender ?? 'Không rõ người gửi'),
                    subtitle: Text(message.body ?? 'Không có nội dung'),
                  ),
                );
              },
            ),
    );
  }
}

// ===================== CONTACTS =======================
class ContactsReaderPage extends StatefulWidget {
  const ContactsReaderPage({super.key});

  @override
  State<ContactsReaderPage> createState() => _ContactsReaderPageState();
}

class _ContactsReaderPageState extends State<ContactsReaderPage> {
  List<ContactInfo> _contacts = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _requestContactsPermission();
  }

  // XIN QUYỀN DANH BẠ
  Future<void> _requestContactsPermission() async {
    final PermissionStatus status = await Permission.contacts.request();

    if (status.isGranted) {
      await _loadContacts();
    } else {
      setState(() {
        _isLoading = false;
      });

      _showMessage('Vui lòng cấp quyền đọc danh bạ.');
    }
  }

  // ĐỌC DANH BẠ
  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<ContactInfo> contacts =
          await FlutterContactsService.getContacts();

      setState(() {
        _contacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      _showMessage('Không thể đọc danh bạ: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // GIAO DIỆN DANH BẠ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh bạ điện thoại'),
        actions: [
          IconButton(onPressed: _loadContacts, icon: const Icon(Icons.refresh)),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _contacts.isEmpty
          ? const Center(
              child: Text(
                'Không có danh bạ nào.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final ContactInfo contact = _contacts[index];

                String phone = 'Không có số điện thoại';

                final phones = contact.phones ?? [];

                if (phones.isNotEmpty) {
                  phone = phones.first.value ?? 'Không có số điện thoại';
                }

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(contact.displayName ?? 'Không có tên'),
                    subtitle: Text(phone),
                  ),
                );
              },
            ),
    );
  }
}
