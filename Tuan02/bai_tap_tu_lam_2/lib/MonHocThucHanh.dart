import 'package:bai_tap_tu_lam_2/MonHoc.dart';
class MonHocThucHanh extends MonHoc {
  double _kt1=0;
  double _kt2=0;
  double _kt3=0;

  MonHocThucHanh() : super(){
    _kt1 = 0;
    _kt2 = 0;
    _kt3 = 0;
  }
  MonHocThucHanh.fullPara(String maMH, String tenMon, int soTinChi, double kt1, double kt2, double kt3) 
      : super.fullPara(maMH, tenMon, soTinChi) {
    _kt1 = kt1;
    _kt2 = kt2;
    _kt3 = kt3;
  }
  double get kt1 => _kt1;
  set kt1(double v) {
    if (v >= 0 && v <= 10) _kt1 = v;
  }

  double get kt2 => _kt2;
  set kt2(double v) {
    if (v >= 0 && v <= 10) _kt2 = v;
  }

  double get kt3 => _kt3;
  set kt3(double v) {
    if (v >= 0 && v <= 10) _kt3 = v;
  }
  @override
  double tinhDTB() {
    return (_kt1 + _kt2 + _kt3) / 3;
  }

  @override
  String toString() {
    return "[Thực Hành]".padRight(16) + super.toString();
  }
}