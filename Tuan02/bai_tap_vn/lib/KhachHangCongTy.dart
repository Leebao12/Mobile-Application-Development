import 'package:bai_tap_vn/HoaDon.dart';
import 'dart:io';

class KhachHangCongTy extends HoaDon{
  int _soNhanVien=0;

  KhachHangCongTy() : super(){
    _soNhanVien=0;
  }
  KhachHangCongTy.fullPara(String ma, String ten, int sl, double gia, int soNhanVien)
      : super.fullPara(ma, ten, sl, gia){
        _soNhanVien = soNhanVien;
      }
  
  int get soNhanVien => _soNhanVien;
  set soNhanVien(int value) {
    if (value > 0) {
      _soNhanVien = value;
    }
  }

  @override
  double tinhChietKhau() {
    double phanTram = 0.0;
    if (_soNhanVien > 5000) {
      phanTram = 0.07;
    } else if (_soNhanVien > 1000) {
      phanTram = 0.05;
    } else {
      phanTram = 0.0;
    }
    return phanTram * giaBan * soLuong;
  }

  @override
  double tinhTroGia() {
    return soLuong * 120000.0;
  }

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write("Nhập số lượng nhân viên: ");
    soNhanVien = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  }

  @override
  String toString() {
    return '${super.toString()}, Số NV: $_soNhanVien (Công ty)';
  }

}