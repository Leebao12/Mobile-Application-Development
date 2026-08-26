import 'package:quan_li_nhan_vien/NhanVien.dart';
class CanBo extends Nhanvien {
  String _chucVu = '';
  double _hsChucVu = 0;
  CanBo() : super() {
    _chucVu = "Unknow";
    _hsChucVu = 0;
  }
  CanBo.fullPara(String manv, String tennv, double hsl,String pb,double songaylv, String chucvu, double hscv): super.fullPara(manv, tennv, hsl, pb, songaylv)
  {
    _chucVu = chucvu;
    _hsChucVu = hscv;
  }
  @override
  String toString() {
    return super.toString() + "\t$_chucVu\t$_hsChucVu";
  }
  @override
  double tinhLuong(){
    return super.tinhLuong() + _hsChucVu *1100;
  }
}