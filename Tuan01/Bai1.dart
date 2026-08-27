import 'dart:io';

void main() {
  
  stdout.write("Nhập số lượng que kem cần mua (>0): ");
  int soLuong = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  
  if (soLuong <= 0) {
    print("Số lượng không hợp lệ!");
    return;
  }

  stdout.write("Nhập giá tiền 1 que kem: ");
  double giaTien = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  double phanTramGiam = 0;
  if (soLuong > 10) {
    phanTramGiam = 0.1; 
  } else if (soLuong >= 5 && soLuong <= 10) {
    phanTramGiam = 0.05; 
  }

  double tongTien = (soLuong * giaTien) * (1 - phanTramGiam);
  
  print("-> Bạn được giảm giá: ${(phanTramGiam * 100).toInt()}%");
  print("-> Tổng tiền phải trả: $tongTien");
}