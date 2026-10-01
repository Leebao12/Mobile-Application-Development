import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts_service/flutter_contacts_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const Bai5App());
}

// APP
class Bai5App extends StatelessWidget {
  const Bai5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài 5 - Quản lý danh bạ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ContactsListScreen(),
    );
  }
}

// MÀN HÌNH DANH SÁCH DANH BẠ
class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  List<ContactInfo> _contacts = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  // XIN QUYỀN VÀ ĐỌC DANH BẠ
  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final PermissionStatus status = await Permission.contacts.request();

      if (!status.isGranted) {
        setState(() {
          _isLoading = false;
        });

        _showMessage('Vui lòng cấp quyền truy cập danh bạ.');
        return;
      }

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

  // MỞ MÀN HÌNH THÊM CONTACT
  Future<void> _openAddContact() async {
    final ContactInfo? newContact = await Navigator.push<ContactInfo>(
      context,
      MaterialPageRoute(builder: (context) => const AddContactScreen()),
    );

    if (newContact != null && mounted) {
      setState(() {
        _contacts.add(newContact);
      });
    }
  }

  // THÔNG BÁO
  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // GIAO DIỆN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh bạ'),
        actions: [
          IconButton(onPressed: _loadContacts, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _openAddContact, icon: const Icon(Icons.add)),
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
          : RefreshIndicator(
              onRefresh: _loadContacts,
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final ContactInfo contact = _contacts[index];

                  final List<ValueItem> phones = contact.phones ?? [];

                  final List<ValueItem> emails = contact.emails ?? [];

                  final String phone = phones.isNotEmpty
                      ? phones.first.value ?? 'Không có số'
                      : 'Không có số';

                  final String email = emails.isNotEmpty
                      ? emails.first.value ?? 'Không có email'
                      : 'Không có email';

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      // Avatar
                      leading: contact.avatar != null
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar!),
                            )
                          : const CircleAvatar(child: Icon(Icons.person)),

                      // Tên
                      title: Text(contact.displayName ?? 'Không có tên'),

                      // Số + email
                      subtitle: Text('$phone\n$email'),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

// MÀN HÌNH THÊM DANH BẠ
class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  File? _avatar;

  final ImagePicker _picker = ImagePicker();

  // CHỌN ẢNH TỪ GALLERY
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _avatar = File(pickedFile.path);
    });
  }

  // CHỤP ẢNH TỪ CAMERA
  Future<void> _takePhoto() async {
    final PermissionStatus status = await Permission.camera.request();

    if (!status.isGranted) {
      _showMessage('Vui lòng cấp quyền sử dụng camera.');
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _avatar = File(pickedFile.path);
    });
  }

  // CHỌN NGUỒN ẢNH
  Future<void> _chooseAvatarSource() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Chọn ảnh từ Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Chụp ảnh từ Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // LƯU CONTACT
  Future<void> _saveContact() async {
    final String name = _nameController.text.trim();

    final String phone = _phoneController.text.trim();

    final String email = _emailController.text.trim();

    // Kiểm tra dữ liệu bắt buộc
    if (name.isEmpty || phone.isEmpty) {
      _showMessage('Tên và số điện thoại không được để trống!');
      return;
    }

    // Xin quyền danh bạ
    final PermissionStatus status = await Permission.contacts.request();

    if (!status.isGranted) {
      _showMessage('Vui lòng cấp quyền truy cập danh bạ.');
      return;
    }

    try {
      // Tạo contact
      final ContactInfo contact = ContactInfo(
        displayName: name,

        phones: [ValueItem(label: 'mobile', value: phone)],

        emails: email.isNotEmpty
            ? [ValueItem(label: 'email', value: email)]
            : [],

        avatar: _avatar != null ? await _avatar!.readAsBytes() : null,
      );

      // Lưu vào danh bạ điện thoại
      await FlutterContactsService.addContact(contact);

      _showMessage('Danh bạ đã được lưu thành công!');

      if (!mounted) return;

      Navigator.pop(context, contact);
    } catch (e) {
      _showMessage('Lỗi khi lưu danh bạ: $e');
    }
  }

  // THÔNG BÁO
  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // GIẢI PHÓNG CONTROLLER
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // GIAO DIỆN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm danh bạ')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // AVATAR
            GestureDetector(
              onTap: _chooseAvatarSource,
              child: CircleAvatar(
                radius: 55,

                backgroundImage: _avatar != null ? FileImage(_avatar!) : null,

                child: _avatar == null
                    ? const Icon(Icons.camera_alt, size: 50)
                    : null,
              ),
            ),

            const SizedBox(height: 10),

            const Text('Nhấn vào ảnh để chọn Gallery hoặc Camera'),

            const SizedBox(height: 25),

            // TÊN
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Tên',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            // SỐ ĐIỆN THOẠI
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 15),

            // EMAIL
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 25),

            // NÚT LƯU
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveContact,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Lưu danh bạ',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
