import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const SmsAnalyzerApp());
}

// APP
class SmsAnalyzerApp extends StatelessWidget {
  const SmsAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS Analyzer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SmsAnalyzerHome(),
    );
  }
}

// MÀN HÌNH CHÍNH
class SmsAnalyzerHome extends StatefulWidget {
  const SmsAnalyzerHome({super.key});

  @override
  State<SmsAnalyzerHome> createState() => _SmsAnalyzerHomeState();
}

class _SmsAnalyzerHomeState extends State<SmsAnalyzerHome> {
  final SmsQuery _query = SmsQuery();

  List<SmsMessage> _messages = [];

  bool _isLoading = true;

  // Từ khóa lọc số điện thoại
  final TextEditingController _phoneController = TextEditingController();

  String _phoneFilter = '';

  // Chế độ hiển thị
  String _filter = 'all';

  // INIT
  @override
  void initState() {
    super.initState();
    _loadSms();
  }

  // XIN QUYỀN + ĐỌC SMS
  Future<void> _loadSms() async {
    setState(() {
      _isLoading = true;
    });

    final PermissionStatus status = await Permission.sms.request();

    if (!status.isGranted) {
      setState(() {
        _isLoading = false;
      });

      _showMessage('Vui lòng cấp quyền đọc tin nhắn SMS.');
      return;
    }

    try {
      // Lấy cả SMS nhận và gửi
      final List<SmsMessage> messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
        sort: true,
        count: 1000,
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

  // XÁC ĐỊNH SMS QUẢNG CÁO
  bool _isAdvertising(SmsMessage message) {
    final String body = (message.body ?? '').trim();

    return body.toUpperCase().startsWith('[QC]');
  }

  // XÁC ĐỊNH SMS OTP
  bool _isOtp(SmsMessage message) {
    final String body = (message.body ?? '').trim();

    final RegExp regex = RegExp(r'\[OTP\].*?(\d{6})', caseSensitive: false);

    return regex.hasMatch(body);
  }

  // LẤY CHUỖI OTP 6 SỐ
  String? _extractOtp(SmsMessage message) {
    final String body = message.body ?? '';

    final RegExp regex = RegExp(r'\[OTP\].*?(\d{6})', caseSensitive: false);

    final Match? match = regex.firstMatch(body);

    return match?.group(1);
  }

  // TIN NHẮN NHẬN ĐƯỢC
  bool _isReceived(SmsMessage message) {
    return message.kind == SmsMessageKind.received;
  }

  // LỌC THEO SỐ ĐIỆN THOẠI
  bool _matchPhone(SmsMessage message) {
    if (_phoneFilter.isEmpty) {
      return true;
    }

    final String address = message.address ?? '';

    return address.contains(_phoneFilter);
  }

  // LỌC THEO NHÓM
  bool _matchCategory(SmsMessage message) {
    switch (_filter) {
      case 'qc':
        return _isAdvertising(message);

      case 'otp':
        return _isOtp(message);

      case 'received':
        return _isReceived(message);

      default:
        return true;
    }
  }

  // DANH SÁCH SAU KHI LỌC
  List<SmsMessage> get _filteredMessages {
    return _messages.where((message) {
      return _matchPhone(message) && _matchCategory(message);
    }).toList();
  }

  // TỔNG SMS NHẬN ĐƯỢC
  int get _receivedCount {
    return _messages.where(_isReceived).length;
  }

  // THỐNG KÊ THEO NGÀY
  Map<String, int> _getDailyStatistics() {
    final Map<String, int> result = {};

    for (final SmsMessage message in _messages) {
      if (!_isReceived(message)) {
        continue;
      }

      final DateTime? date = message.date;

      if (date == null) {
        continue;
      }

      final String key =
          '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';

      result[key] = (result[key] ?? 0) + 1;
    }

    return result;
  }

  // THỐNG KÊ THEO THÁNG
  Map<String, int> _getMonthlyStatistics() {
    final Map<String, int> result = {};

    for (final SmsMessage message in _messages) {
      if (!_isReceived(message)) {
        continue;
      }

      final DateTime? date = message.date;

      if (date == null) {
        continue;
      }

      final String key =
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';

      result[key] = (result[key] ?? 0) + 1;
    }

    return result;
  }

  // FORMAT NGÀY
  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Không rõ thời gian';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  // HIỂN THỊ OTP
  void _showOtp(SmsMessage message) {
    final String? otp = _extractOtp(message);

    if (otp == null) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mã OTP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Mã OTP được tìm thấy:'),
              const SizedBox(height: 15),
              Text(
                otp,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  // THỐNG KÊ
  void _showStatistics() {
    final Map<String, int> daily = _getDailyStatistics();

    final Map<String, int> monthly = _getMonthlyStatistics();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thống kê SMS',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // Tổng nhận
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.sms)),
                      title: const Text('Tổng số tin nhắn nhận được'),
                      trailing: Text(
                        '$_receivedCount',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Theo ngày',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...daily.entries.map((entry) {
                    return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(entry.key),
                      trailing: Text('${entry.value}'),
                    );
                  }),

                  const SizedBox(height: 20),

                  const Text(
                    'Theo tháng',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...monthly.entries.map((entry) {
                    return ListTile(
                      leading: const Icon(Icons.calendar_month),
                      title: Text(entry.key),
                      trailing: Text('${entry.value}'),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // THÔNG BÁO
  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // DISPOSE
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // UI
  @override
  Widget build(BuildContext context) {
    final List<SmsMessage> messages = _filteredMessages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Analyzer'),
        actions: [
          IconButton(
            tooltip: 'Thống kê',
            onPressed: _showStatistics,
            icon: const Icon(Icons.bar_chart),
          ),
          IconButton(
            tooltip: 'Tải lại',
            onPressed: _loadSms,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [

                // THỐNG KÊ NHANH
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const Icon(Icons.sms, size: 30),
                                const SizedBox(height: 5),
                                const Text('SMS nhận'),
                                Text(
                                  '$_receivedCount',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const Icon(Icons.list, size: 30),
                                const SizedBox(height: 5),
                                const Text('Đang hiển thị'),
                                Text(
                                  '${messages.length}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // LỌC SỐ ĐIỆN THOẠI
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Lọc theo số điện thoại',
                      hintText: 'Nhập số cần tìm',
                      prefixIcon: const Icon(Icons.phone),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _phoneFilter = _phoneController.text.trim();
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _phoneFilter = value.trim();
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // BỘ LỌC NHÓM
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      _filterChip(title: 'Tất cả', value: 'all'),

                      _filterChip(title: 'Đã nhận', value: 'received'),

                      _filterChip(title: '[QC] Quảng cáo', value: 'qc'),

                      _filterChip(title: '[OTP] Mã OTP', value: 'otp'),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                // DANH SÁCH
                Expanded(
                  child: messages.isEmpty
                      ? const Center(
                          child: Text(
                            'Không có tin nhắn phù hợp.',
                            style: TextStyle(fontSize: 17),
                          ),
                        )
                      : ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final SmsMessage message = messages[index];

                            final bool isQc = _isAdvertising(message);

                            final bool isOtp = _isOtp(message);

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              child: ListTile(
                                onTap: isOtp
                                    ? () {
                                        _showOtp(message);
                                      }
                                    : null,

                                leading: CircleAvatar(
                                  child: Icon(
                                    isOtp
                                        ? Icons.key
                                        : isQc
                                        ? Icons.campaign
                                        : Icons.sms,
                                  ),
                                ),

                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        message.address ?? 'Không rõ số',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    if (isOtp) const Chip(label: Text('OTP')),

                                    if (isQc) const Chip(label: Text('QC')),
                                  ],
                                ),

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),

                                    Text(
                                      message.body ?? 'Không có nội dung',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      _formatDate(message.date),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),

                                    if (isOtp)
                                      const Text(
                                        'Nhấn để lấy mã OTP',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  // FILTER CHIP
  Widget _filterChip({required String title, required String value}) {
    final bool selected = _filter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(title),
        selected: selected,
        onSelected: (_) {
          setState(() {
            _filter = value;
          });
        },
      ),
    );
  }
}
