import 'package:bai_tap_vn/HoaDon.dart';
import 'dart:io';
class KhachHangCaNhan extends HoaDon {
  double _khoangCach = 0;

  KhachHangCaNhan() : super(){
    _khoangCach = 0;
  }
  KhachHangCaNhan.fullPara(String ma, String ten, int sl, double gia, double khoangCach)
      : super.fullPara(ma, ten, sl, gia){
        _khoangCach = khoangCach;
      }
  double get khoangCach => _khoangCach;
  set khoangCach(double value) {
    if (value > 0) {
      _khoangCach = value;
    }
  }

  @override
  double tinhTroGia() {
    double troGiaSP = 0.02 * giaBan * soLuong;
    double troGiaThem = 0;
    if (soLuong > 2) {
      troGiaThem = 100000;
    }
    return troGiaSP + troGiaThem;
  }

  @override
  double tinhChietKhau() {
    double ckCoBan = 0;
    if (soLuong >= 3) {
      ckCoBan = 0.05 * giaBan * soLuong;
    }

    double ckVanChuyen = 0;
    if (_khoangCach < 10) {
      ckVanChuyen = 50000.0 * soLuong;
    }

    return ckCoBan + ckVanChuyen;
  }

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write("Nhập khoảng cách giao hàng (km): ");
    khoangCach =
        double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  }

  @override
  String toString() {
    return '${super.toString()}, Khoảng cách: $_khoangCach km (Cá nhân)';
  }

}  