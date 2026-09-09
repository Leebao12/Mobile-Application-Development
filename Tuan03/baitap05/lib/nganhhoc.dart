import 'package:flutter/material.dart';
class NganhHocDemo extends StatelessWidget {
  const NganhHocDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giới thiệu ngành học',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          leading: IconButton(icon: const Icon(Icons.home), onPressed: () {}),
          title: const Text(
            'Giới thiệu ngành học',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'KHOA CÔNG NGHỆ THÔNG TIN',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'TRƯỜNG ĐẠI HỌC CÔNG THƯƠNG\n'
                    'THÀNH PHỐ HỒ CHÍ MINH',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ================= NGÀNH CNTT =================
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blue[50]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        '1. CÔNG NGHỆ THÔNG TIN',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Center(
                      child: Image.asset(
                        'assets/images/cntt.jpg',
                        width: 300,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Mã ngành: 7480201',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Công nghệ Thông tin là ngành học cung cấp '
                        'kiến thức về máy tính, phần mềm, dữ liệu và '
                        'các hệ thống công nghệ thông tin.',
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sinh viên được học lập trình, cơ sở dữ liệu, '
                        'phát triển phần mềm, mạng máy tính và hệ thống '
                        'thông tin.',
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cơ hội nghề nghiệp:',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Lập trình viên, kỹ sư phần mềm, kiểm thử phần mềm, '
                        'phân tích hệ thống, quản trị cơ sở dữ liệu...',
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= NGÀNH ATTT =================
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green[50]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        '2. AN TOÀN THÔNG TIN',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Center(
                      child: Image.asset(
                        'assets/images/attt.jpg',
                        width: 300,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Mã ngành: 7480202',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'An toàn Thông tin là ngành học tập trung vào việc '
                        'bảo vệ dữ liệu, mạng máy tính và hệ thống thông tin '
                        'trước các nguy cơ mất an toàn.',
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sinh viên được học về bảo mật mạng, mã hóa, '
                        'an ninh hệ thống, phát hiện và phòng chống '
                        'các cuộc tấn công mạng.',
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cơ hội nghề nghiệp:',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Chuyên viên an ninh mạng, chuyên viên bảo mật '
                        'hệ thống, quản trị an toàn thông tin, kiểm thử '
                        'bảo mật và phân tích sự cố...',
                        style: TextStyle(fontSize: 18, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Center(
                child: SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Trở về', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
