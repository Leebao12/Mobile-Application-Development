abstract class MonHoc {
  String _maMH='';
  String _tenMon='';
  int _soTinChi=0;

  MonHoc() {
    _maMH = 'MH000';
    _tenMon = 'Chưa xác định';
    _soTinChi = 1;
  }

  MonHoc.fullPara(String maMH, String tenMon, int soTinChi) {
    _maMH = maMH;
    _tenMon = tenMon;
    _soTinChi = soTinChi;
  }

  String get maMH => _maMH;
  set maMH(String value) {
    if (value.trim().isNotEmpty) _maMH = value.trim();
  }

  String get tenMon => _tenMon;
  set tenMon(String value) {
    if (value.trim().isNotEmpty) _tenMon = value.trim();
  }

  int get soTinChi => _soTinChi;
  set soTinChi(int value) {
    if (value > 0) _soTinChi = value; 
  }
  
  double tinhDTB();

  String quyDoiDiemChu(){
    double dtb = tinhDTB();
    if(dtb >=8.5) return 'A';
    else if(dtb >=7.0) return 'B';
    else if(dtb >=5.5) return 'C';
    else if(dtb >=4.0) return 'D';
    else return 'F';
  }
  @override
  String toString() {
    String ma = _maMH.padRight(10);
    String ten = _tenMon.padRight(25);
    String tc = _soTinChi.toString().padRight(10);
    String dtb = tinhDTB().toStringAsFixed(2).padRight(10);

    return "$ma$ten$tc$dtb${quyDoiDiemChu()}";
  }
}

