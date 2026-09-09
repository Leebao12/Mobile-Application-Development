import 'package:flutter/material.dart';

class ProjectInfoScreen extends StatelessWidget {
  const ProjectInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Thông tin đề tài đồ án',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'THÔNG TIN ĐỀ TÀI ĐỒ ÁN',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Mã đề tài đồ án:',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text('DA001', style: TextStyle(fontSize: 19)),

              const SizedBox(height: 20),

              const Text(
                'Tên đề tài:',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Xây dựng ứng dụng hỗ trợ tuyển dụng và tìm việc làm.',
                style: TextStyle(fontSize: 19),
              ),

              const SizedBox(height: 20),

              const Text(
                'Số lượng sinh viên tối đa:',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text('5 sinh viên', style: TextStyle(fontSize: 19)),

              const SizedBox(height: 20),

              const Text(
                'Chuyên ngành:',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Công nghệ phần mềm',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Giảng viên hướng dẫn:',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Đỗ Gia Bảo',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Yêu cầu đề tài:',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Xây dựng hệ thống cho phép người dùng xem '
                'thông tin phim, lựa chọn suất chiếu, chọn ghế '
                'và đặt vé trực tuyến. Hệ thống có giao diện '
                'thân thiện, dễ sử dụng và quản lý thông tin '
                'phim, suất chiếu, người dùng và vé.',
                style: TextStyle(fontSize: 19),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 35),

              Center(
                child: SizedBox(
                  width: 160,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.deepPurple,
                      elevation: 2,
                    ),
                    child: const Text('Trở về', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
