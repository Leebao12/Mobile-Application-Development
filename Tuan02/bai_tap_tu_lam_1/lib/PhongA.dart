import 'package:bai_tap_tu_lam_1/PhongThue.dart';
class PhongLoaiA extends PhongThue {
  int _soNguoiThan=0;

  PhongLoaiA() : super() {
    _soNguoiThan = 0;
  }
  PhongLoaiA.fullPara(String maPhong, int soNguoi, double soDien, double soNuoc, int soNguoiThan)
      : super.fullPara(maPhong, soNguoi, soDien, soNuoc) {
    _soNguoiThan = soNguoiThan;
  }

  int get soNguoiThan => _soNguoiThan;
  set soNguoiThan(int value) {
    if (value >= 0) {
      _soNguoiThan = value;
    }
  }

  @override
  double tinhTienPhong() {
    return 1400 + (2 * soDien) + (8 * soNuoc) + (50 * _soNguoiThan);
  }

  @override
  void showInfo() {
    print(
      "[Loại A] Mã: $maPhong | Người: $soNguoi | Điện: $soDien | Nước: $soNuoc | Người thân: $_soNguoiThan | Tiền phòng: ${tinhTienPhong()}",
    );
  }
}