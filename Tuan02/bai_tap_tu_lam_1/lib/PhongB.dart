import 'package:bai_tap_tu_lam_1/PhongThue.dart';
class PhongLoaiB extends PhongThue {
  double _giatUi=0;
  int _soMay=0;

  PhongLoaiB() : super() {
    _giatUi = 0;
    _soMay = 0;
  }

  PhongLoaiB.fullPara(String maPhong,int soNguoi,double soDien,double soNuoc,double giatUi,int soMay
  ) : super.fullPara(maPhong, soNguoi, soDien, soNuoc) {
    _giatUi = giatUi;
    _soMay = soMay;
  }
  
  double get giatUi => _giatUi;
  set giatUi(double value) {
    if (value >= 0) {
      _giatUi = value;
    }
  }

  int get soMay => _soMay;
  set soMay(int value) {
    if (value >= 0) {
      _soMay = value;
    }
  }
  @override
  double tinhTienPhong() {
    return 2000 + (2 * soDien) + (8 * soNuoc) + (_giatUi * 5) + (_soMay * 100);
  }

  @override
  void showInfo() {
    print(
      "[Loại B] Mã: $maPhong | Người: $soNguoi | Điện: $soDien | Nước: $soNuoc | Giặt ủi: $_giatUi | Máy tính: $_soMay | Tiền phòng: ${tinhTienPhong()}",
    );
  }
}
