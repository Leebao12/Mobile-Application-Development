import 'package:bai_tap_tu_lam_1/PhongThue.dart';
import 'package:bai_tap_tu_lam_1/PhongA.dart';
import 'package:bai_tap_tu_lam_1/PhongB.dart';
import 'dart:io';
Future<List<PhongThue>> readFile(String fileName) async {
  List<PhongThue> danhSachPhong = [];
  try {
    List<String> lines = await File(fileName).readAsLines();

    for (String line in lines) {
      if (line.trim().isEmpty) continue; 

      List<String> parts = line.split('#');
      String maPhong = parts[0].trim();
      int soNguoi = int.parse(parts[1].trim());
      double soDien = double.parse(parts[2].trim());
      double soNuoc = double.parse(parts[3].trim());

      if (maPhong.startsWith('A') && parts.length == 5) {
        int soNguoiThan = int.parse(parts[4].trim());
        danhSachPhong.add(
          PhongLoaiA.fullPara(maPhong, soNguoi, soDien, soNuoc, soNguoiThan),
        );
      } else if (maPhong.startsWith('B') && parts.length == 6) {
        double giatUi = double.parse(parts[4].trim());
        int soMay = int.parse(parts[5].trim());
        danhSachPhong.add(
          PhongLoaiB.fullPara(maPhong, soNguoi, soDien, soNuoc, giatUi, soMay),
        );
      }
    }
  } catch (e) {
    print('Lỗi khi đọc file: $e');
  }
  return danhSachPhong;
}

void main() async {
  List<PhongThue> dsPhong = await readFile('lib/phongthue.txt');

  if (dsPhong.isEmpty) {
    print("Danh sách trống hoặc không đọc được file!");
    return;
  }

  print("========== 1. DANH SÁCH TẤT CẢ PHÒNG THUÊ ==========");
  for (var phong in dsPhong) {
    phong.showInfo();
  }

  print("\n========== 2. PHÒNG CÓ SỐ NGƯỜI THUÊ LỚN HƠN 2 ==========");
  var dsHon2Nguoi = dsPhong.where((phong) => phong.soNguoi > 2).toList();
  for (var phong in dsHon2Nguoi) {
    phong.showInfo();
  }

  print("\n========== 3. TỔNG DOANH THU ==========");
  double tongTien = dsPhong.fold(0,(sum, phong) => sum + phong.tinhTienPhong(),
  );
  print("Tổng tiền phòng thu được: $tongTien");

  print("\n========== 4. DANH SÁCH SẮP XẾP GIẢM DẦN THEO SỐ ĐIỆN ==========");
  dsPhong.sort((a, b) => b.soDien.compareTo(a.soDien));
  for (var phong in dsPhong) {
    phong.showInfo();
  }

  print("\n========== 5. DANH SÁCH CÁC PHÒNG LOẠI A ==========");
  var dsPhongLoaiA = dsPhong.where((phong) => phong is PhongLoaiA).toList();
  for (var phong in dsPhongLoaiA) {
    phong.showInfo();
  }
}
