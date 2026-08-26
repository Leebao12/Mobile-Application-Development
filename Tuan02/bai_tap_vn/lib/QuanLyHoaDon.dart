import 'package:bai_tap_vn/HoaDon.dart';
import 'package:bai_tap_vn/KhachHangCaNhan.dart';
import 'package:bai_tap_vn/DaiLyCap1.dart';
import 'package:bai_tap_vn/KhachHangCongTy.dart';
import 'dart:io';

class QuanLyHoaDon {
  List<HoaDon> dsHoaDon = [];

  void nhapDanhSach() {
    while (true) {
      print("\n--- CHỌN LOẠI KHÁCH HÀNG ĐỂ NHẬP ---");
      print("1. Khách hàng Cá nhân");
      print("2. Đại lý Cấp 1");
      print("3. Khách hàng Công ty");
      print("0. Dừng nhập");
      stdout.write("Chọn: ");
      String chon = stdin.readLineSync()?.trim() ?? "";

      if (chon == '0') break;

      HoaDon? hd;
      if (chon == '1') hd = KhachHangCaNhan();
      else if (chon == '2') hd = DaiLyCap1();
      else if (chon == '3') hd = KhachHangCongTy();
      else {
        print("Lựa chọn không hợp lệ!");
        continue;
      }

      hd.nhapThongTin();
      dsHoaDon.add(hd);
      print("Đã thêm hóa đơn thành công!");
    }
  }

  void xuatDanhSach() {
    if (dsHoaDon.isEmpty) {
      print('Danh sách hóa đơn đang rỗng!');
      return;
    }
    print('\n--- DANH SÁCH TẤT CẢ HÓA ĐƠN ---');
    for (HoaDon hd in dsHoaDon) {
      print(hd);
    }
  }

  double tinhTongThanhTien() {
    double tong = 0;
    for (HoaDon hd in dsHoaDon) {
      tong = tong + hd.tinhThanhTien();
    }
    return tong;
  }

  double tinhTongTroGia() {
    double tong = 0;
    for (HoaDon hd in dsHoaDon) {
      tong = tong + hd.tinhTroGia();
    }
    return tong;
  }

  List<HoaDon> timKhachHangMuaNhieuNhat() {
    List<HoaDon> ketQua = [];
    if (dsHoaDon.isEmpty) {
      return ketQua;
    }

    int maxSL = dsHoaDon[0].soLuong;
    for (HoaDon hd in dsHoaDon) {
      if (hd.soLuong > maxSL) {
        maxSL = hd.soLuong;
      }
    }

    for (HoaDon hd in dsHoaDon) {
      if (hd.soLuong == maxSL) {
        ketQua.add(hd);
      }
    }
    return ketQua;
  }

  double tinhTongChietKhauCongTy() {
    double tong = 0;
    for (HoaDon hd in dsHoaDon) {
      if (hd is KhachHangCongTy) {
        tong = tong + hd.tinhChietKhau();
      }
    }
    return tong;
  }

  void sapXepDanhSach() {
    dsHoaDon.sort((a, b) {
      if (a.soLuong != b.soLuong) {
        return a.soLuong.compareTo(b.soLuong);
      } else {
        return b.tinhThanhTien().compareTo(a.tinhThanhTien());
      }
    });
  }

  List<HoaDon> timKiemTheoMaKH(String ma) {
    List<HoaDon> ketQua = [];
    for (HoaDon hd in dsHoaDon) {
      if (hd.maKH.toLowerCase() == ma.trim().toLowerCase()) {
        ketQua.add(hd);
      }
    }
    return ketQua;
  }

}