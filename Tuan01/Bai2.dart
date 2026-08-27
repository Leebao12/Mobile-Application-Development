import 'dart:io';

void main() {

  stdout.write("Nhập vào một số nguyên dương (>10): ");
  int n = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  if (n <= 10) {
    print("Vui lòng nhập số > 10!");
    return;
  }

  String chuoiSo = n.toString();

  print("a. Số nhập vào có ${chuoiSo.length} chữ số.");

  int tong = 0;
  bool coSoLe = false;

  for (int i = 0; i < chuoiSo.length; i++) {
    int chuSo = int.parse(chuoiSo[i]);
    tong += chuSo;
    if (chuSo % 2 != 0) {
      coSoLe = true;
    }
  }

  print("b. Tổng các chữ số là: $tong");
  print("c. Số này ${coSoLe ? "CÓ" : "KHÔNG CÓ"} chứa chữ số lẻ.");
}
