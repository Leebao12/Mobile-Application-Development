import 'package:bai_tap_tu_lam_2/MonHoc.dart';
import 'dart:io';
import 'dart:convert';
import 'package:bai_tap_tu_lam_2/MonHocLyThuyet.dart';
import 'package:bai_tap_tu_lam_2/MonHocThucHanh.dart';
import 'package:bai_tap_tu_lam_2/MonHocDoAn.dart';
MonHoc? nhap1MonHoc(String? tenMacDinh) {
  print("\n--- Nhập thông tin môn học mới ---");
  stdout.write("Nhập loại môn học (1: Lý thuyết, 2: Thực hành, 3: Đồ án): ");
  String? loai = stdin.readLineSync();

  if (loai != '1' && loai != '2' && loai != '3') {
    print("Loại môn học không hợp lệ!");
    return null;
  }

  stdout.write("Nhập mã môn học: ");
  String maMH = stdin.readLineSync() ?? "";

  String tenMH = tenMacDinh ?? "";
  if (tenMH.isEmpty) {
    stdout.write("Nhập tên môn học: ");
    tenMH = stdin.readLineSync(encoding: utf8) ?? "";
  } else {
    print("Tên môn học: $tenMH");
  }

  stdout.write("Nhập số tín chỉ: ");
  int soTC = int.parse(stdin.readLineSync() ?? "0");

  if (loai == '1') {
    stdout.write("Nhập điểm tiểu luận: ");
    double dtl = double.parse(stdin.readLineSync() ?? "0");
    stdout.write("Nhập điểm cuối kỳ: ");
    double dck = double.parse(stdin.readLineSync() ?? "0");
    return MonHocLyThuyet.fullPara(maMH, tenMH, soTC, dtl, dck);
  } else if (loai == '2') {
    stdout.write("Nhập điểm KT1: ");
    double kt1 = double.parse(stdin.readLineSync() ?? "0");
    stdout.write("Nhập điểm KT2: ");
    double kt2 = double.parse(stdin.readLineSync() ?? "0");
    stdout.write("Nhập điểm KT3: ");
    double kt3 = double.parse(stdin.readLineSync() ?? "0");
    return MonHocThucHanh.fullPara(maMH, tenMH, soTC, kt1, kt2, kt3);
  } else {
    stdout.write("Nhập điểm GVHD: ");
    double hd = double.parse(stdin.readLineSync() ?? "0");
    stdout.write("Nhập điểm GVPB: ");
    double pb = double.parse(stdin.readLineSync() ?? "0");
    return MonHocDoAn.fullPara(maMH, tenMH, soTC, hd, pb);
  }
}

Future<List<MonHoc>> docFile(String fileName) async {
  List<MonHoc> danhSach = [];
  try {
    List<String> lines = await File(fileName).readAsLines();
    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      List<String> p = line.split('#');

      String loai = p[0].trim();
      String maMH = p[1].trim();
      String tenMH = p[2].trim();
      int soTC = int.parse(p[3].trim());

      if (loai == 'LT' && p.length == 6) {
        danhSach.add(
          MonHocLyThuyet.fullPara(maMH,tenMH,soTC,
            double.parse(p[4]),double.parse(p[5]),
          ),
        );
      } else if (loai == 'TH' && p.length == 7) {
        danhSach.add(
          MonHocThucHanh.fullPara(maMH,tenMH,soTC,
            double.parse(p[4]),double.parse(p[5]),double.parse(p[6]),
          ),
        );
      } else if (loai == 'DA' && p.length == 6) {
        danhSach.add(
          MonHocDoAn.fullPara(maMH, tenMH, soTC, double.parse(p[4]), double.parse(p[5])),
        );
      }
    }
  } catch (e) {
    print('Lỗi đọc file: $e');
  }
  return danhSach;
}

void main() async {
  List<MonHoc> dsMonHoc = [];

  print("Đang đọc dữ liệu từ file monhoc.txt...");
  dsMonHoc = await docFile('lib/monhoc.txt');

  stdout.write("Bạn có muốn nhập thêm môn học từ bàn phím không? (y/n): ");
  String? choice = stdin.readLineSync();
  while (choice?.toLowerCase() == 'y') {
    MonHoc? mh = nhap1MonHoc(null);
    if (mh != null) dsMonHoc.add(mh);
    stdout.write("Tiếp tục nhập? (y/n): ");
    choice = stdin.readLineSync();
  }

  print("\n========== DANH SÁCH MÔN HỌC ==========");
  for (var mh in dsMonHoc) {
    print(mh);
  }

  bool isSortedByName = true;
  for (int i = 0; i < dsMonHoc.length - 1; i++) {
    if (dsMonHoc[i].tenMon.compareTo(dsMonHoc[i + 1].tenMon) > 0) {
      isSortedByName = false;
      break;
    }
  }
  print("\n========== KIỂM TRA SẮP XẾP ==========");
  print("Danh sách ${isSortedByName ? 'ĐÃ' : 'CHƯA'} được sắp xếp tăng dần theo tên môn học.");

  print("\n========== SAU KHI SẮP XẾP THEO SỐ TÍN CHỈ (TĂNG DẦN) ==========");
  dsMonHoc.sort((a, b) => a.soTinChi.compareTo(b.soTinChi));
  for (var mh in dsMonHoc) {
    print(mh);
  }

  print("\n========== MÔN HỌC CÓ SỐ TÍN CHỈ CAO NHẤT ==========");
  int maxTC = dsMonHoc.fold(0, (max, mh) => mh.soTinChi > max ? mh.soTinChi : max);
  var dsMaxTC = dsMonHoc.where((mh) => mh.soTinChi == maxTC);
  for (var mh in dsMaxTC) {
    print(mh);
  }

  print("\n========== TÌM KIẾM & THÊM MỚI ==========");
  stdout.write("Nhập tên môn học cần tìm: ");
  String tenTimKiem = stdin.readLineSync(encoding: utf8)?.trim() ?? "";

  var dsTimDuoc = dsMonHoc.where((mh) => mh.tenMon.toLowerCase() == tenTimKiem.toLowerCase()).toList();
  
  if (dsTimDuoc.isNotEmpty) {
    print("-> Đã tìm thấy môn học:");
    for (var mh in dsTimDuoc) {
      print(mh);
    }
  } else {
    print("-> Không tìm thấy '$tenTimKiem' trong danh sách. Vui lòng nhập thông tin để thêm vào!");
    MonHoc? mhMoi = nhap1MonHoc(tenTimKiem);
    if (mhMoi != null) {
      dsMonHoc.add(mhMoi);
      print("Đã thêm môn học thành công!");

      print("\n========== DANH SÁCH SAU KHI CẬP NHẬT ==========");
      for (var mh in dsMonHoc) {
        print(mh);
      }
    }
  }

  print("\n========== THỐNG KÊ ==========");
  if (dsMonHoc.isNotEmpty) {
    double tongTC = dsMonHoc.fold(0, (sum, mh) => sum + mh.soTinChi);
    double tcTrungBinh = tongTC / dsMonHoc.length;
    print(
      "Số tín chỉ trung bình của các môn học là: ${tcTrungBinh.toStringAsFixed(2)}",
    );
  }
}
