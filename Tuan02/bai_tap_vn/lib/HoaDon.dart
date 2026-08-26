import 'dart:io';
import 'dart:convert';
abstract class HoaDon {
  String _maKH='';
  String _tenKH='';
  int _soLuong=0;
  double _giaBan=0;

  HoaDon(){
    _maKH='KH000';
    _tenKH='Chưa có tên';
    _soLuong=1;
    _giaBan=0;
  }

  HoaDon.fullPara(String maKH, String tenKH, int soLuong, double giaBan){
    _maKH=maKH;
    _tenKH=tenKH;
    _soLuong=soLuong;
    _giaBan=giaBan;
  }

  String get maKH => _maKH;
  set maKH(String value) {
    RegExp regex = RegExp(r'^KH\d{4}$');
    if (regex.hasMatch(value.trim())) {
      _maKH = value.trim();
    }
  }

  String get tenKH => _tenKH;
  set tenKH(String value) {
    if (value.trim().isNotEmpty) {
      _tenKH = value.trim();
    }
  }

  int get soLuong => _soLuong;
  set soLuong(int value) {
    if (value > 0) {
      _soLuong = value;
    }
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value > 0) {
      _giaBan = value;
    }
  }

  double tinhTienHang() {
    return _soLuong * _giaBan;
  }

  double tinhTienVAT() {
    return tinhTienHang() * 0.1;
  }
  double tinhChietKhau();
  double tinhTroGia() => 0;

  double tinhThanhTien() {
    return tinhTienHang() - tinhChietKhau() + tinhTienVAT();
  }

  void NhapThongTin() {
    print('Nhập mã khách hàng:');
    maKH = stdin.readLineSync()!;
    print('Nhập tên khách hàng:');
    tenKH = stdin.readLineSync()!;
    print('Nhập số lượng:');
    soLuong = int.parse(stdin.readLineSync()!);
    print('Nhập giá bán:');
    giaBan = double.parse(stdin.readLineSync()!);
  }

  void nhapThongTin() {
    while (true) {
      stdout.write("Nhập mã khách hàng (KHxxxx): ");
      String ma = stdin.readLineSync()?.trim() ?? "";
      if (RegExp(r'^KH\d{4}$').hasMatch(ma)) {
        _maKH = ma;
        break;
      } else {
        print(
          "Lỗi: Mã khách hàng phải có 6 kí tự, bắt đầu bằng 'KH' và 4 chữ số (VD: KH0002)!",
        );
      }
    }

    while (true) {
      stdout.write("Nhập tên khách hàng: ");
      String ten = stdin.readLineSync(encoding: utf8)?.trim() ?? "";
      if (ten.isNotEmpty) {
        _tenKH = ten;
        break;
      } else {
        print("Lỗi: Tên khách hàng không được để trống!");
      }
    }

    while (true) {
      stdout.write("Nhập số lượng: ");
      int sl = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
      if (sl > 0) {
        _soLuong = sl;
        break;
      } else {
        print("Lỗi: Số lượng phải > 0!");
      }
    }

    while (true) {
      stdout.write("Nhập giá bán: ");
      double gia =
          double.tryParse(stdin.readLineSync() ?? "") ?? 0;
      if (gia > 0) {
        _giaBan = gia;
        break;
      } else {
        print("Lỗi: Giá bán phải > 0!");
      }
    }
  }

  @override
  String toString() {
    return 'Mã KH: $_maKH, Tên: $_tenKH, SL: $_soLuong, Đơn giá: $_giaBan, Tiền hàng: ${tinhTienHang()}, Chiết khấu: ${tinhChietKhau()}, VAT: ${tinhTienVAT()}, Trợ giá: ${tinhTroGia()}, Thành tiền: ${tinhThanhTien()}';
  }

}
