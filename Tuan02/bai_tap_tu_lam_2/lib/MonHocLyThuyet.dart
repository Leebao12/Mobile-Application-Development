import 'package:bai_tap_tu_lam_2/MonHoc.dart';
class MonHocLyThuyet extends MonHoc {
  double _diemTieuLuan=0;
  double _diemCK=0;

  MonHocLyThuyet() : super(){
    _diemTieuLuan = 0;
    _diemCK = 0;
  }

  MonHocLyThuyet.fullPara(String maMH, String tenMon, int soTinChi, double diemTieuLuan, double diemCK) 
      : super.fullPara(maMH, tenMon, soTinChi) {
    _diemTieuLuan = diemTieuLuan;
    _diemCK = diemCK;
  }
  double get diemTieuLuan => _diemTieuLuan;
  set diemTieuLuan(double value) {
    if (value >= 0 && value <= 10) _diemTieuLuan = value;
  }

  double get diemCuoiKy => _diemCK;
  set diemCuoiKy(double value) {
    if (value >= 0 && value <= 10) _diemCK = value;
  }

  @override
  double tinhDTB() {
    return (_diemTieuLuan * 0.3) + (_diemCK * 0.7);
  }

  @override
  String toString() {
    return "[Lý Thuyết]".padRight(16) + super.toString();
  }
}

