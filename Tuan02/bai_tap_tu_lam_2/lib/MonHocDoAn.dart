import 'package:bai_tap_tu_lam_2/MonHoc.dart';
class MonHocDoAn extends MonHoc {
  double _diemGVHD=0;
  double _diemGVPB=0;

  MonHocDoAn() : super(){
    _diemGVHD = 0;
    _diemGVPB = 0;
  }

  MonHocDoAn.fullPara(String maMH, String tenMon, int soTinChi, double diemGVHD, double diemGVPB) 
      : super.fullPara(maMH, tenMon, soTinChi) {
    _diemGVHD = diemGVHD;
    _diemGVPB = diemGVPB;
  }

  double get diemGVHD => _diemGVHD;
  set diemGVHD(double value) {
    if (value >= 0 && value <= 10) _diemGVHD = value;
  }

  double get diemGVPB => _diemGVPB;
  set diemGVPB(double value) {
    if (value >= 0 && value <= 10) _diemGVPB = value;
  }

  @override
  double tinhDTB() {
    return (_diemGVHD + _diemGVPB) / 2;
  }

  @override
  String toString() {
    return "[Đồ Án]".padRight(16) + super.toString();
  }
}
