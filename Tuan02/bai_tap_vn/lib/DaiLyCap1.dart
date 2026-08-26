import 'package:bai_tap_vn/HoaDon.dart';
import 'dart:io';
class DaiLyCap1 extends HoaDon{
  int _thoiGianHopTac=0;

  DaiLyCap1() : super(){
    _thoiGianHopTac=0;
  } 
  
  DaiLyCap1.fullPara(String ma, String ten, int sl, double gia, int thoiGianHopTac)
      : super.fullPara(ma, ten, sl, gia){
        _thoiGianHopTac = thoiGianHopTac;
      }
  
  int get thoiGianHopTac => _thoiGianHopTac;
  set thoiGianHopTac(int value) {
    if (value > 0) {
      _thoiGianHopTac = value;
    }
  }

  @override
  double tinhChietKhau() {
    double phanTram = 0.30;
    if (_thoiGianHopTac > 5) {
      int namVuot = _thoiGianHopTac - 5;
      phanTram = phanTram + namVuot * 0.01;
    }
    if (phanTram > 0.35) {
      phanTram = 0.35;
    }
    return phanTram * giaBan * soLuong;
  }

  @override
  double tinhTroGia() {
    return 0.0;
  }

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write("Nhập thời gian hợp tác (năm): ");
    thoiGianHopTac = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
  }

  @override
  String toString() {
    return '${super.toString()}, Hợp tác: $_thoiGianHopTac năm (Đại lý cấp 1)';
  }

}