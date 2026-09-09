import 'package:flutter/material.dart';
class GroupDemo extends StatelessWidget {
  const GroupDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thông tin nhóm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Thông tin nhóm",
            style: TextStyle(
              color: Color.fromARGB(255, 201, 229, 16),
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.blue[900],
          leading: IconButton(icon: const Icon(Icons.home), onPressed: () {}),
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "THÔNG TIN NHÓM",
                      style: TextStyle(
                        color: Color.fromARGB(255, 235, 19, 19),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mã nhóm: N01",
                    style: TextStyle(
                      color: Color.fromARGB(255, 54, 63, 244),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Tên nhóm: Nhóm Công nghệ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 54, 63, 244),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Số lượng thành viên: 3",
                    style: TextStyle(
                      color: Color.fromARGB(255, 54, 63, 244),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                const SizedBox(height: 15),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "THÀNH VIÊN 1",
                    style: TextStyle(
                      color: Color.fromARGB(255, 169, 13, 248),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mã sinh viên: 2001240019",
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
                    "Tên sinh viên: Trần Bảo Anh",
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
                    "Vai trò: Nhóm trưởng",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "THÀNH VIÊN 2",
                    style: TextStyle(
                      color: Color.fromARGB(255, 169, 13, 248),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mã sinh viên: 2001240030",
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
                    "Tên sinh viên: Lê Quang Bảo",
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
                    "Vai trò: Thành viên",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "THÀNH VIÊN 3",
                    style: TextStyle(
                      color: Color.fromARGB(255, 169, 13, 248),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Mã sinh viên: 2001240040",
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
                    "Tên sinh viên: Trần Gia Bảo",
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
                    "Vai trò: Thành viên",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: SizedBox(
                    height: 45,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Trở về",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
