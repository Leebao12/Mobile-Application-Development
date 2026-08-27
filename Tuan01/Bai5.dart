import 'dart:io';
import 'dart:convert';

void main() {

  stdout.write("Nhập vào một chuỗi: ");
  String s = stdin.readLineSync(encoding: utf8)?.trim() ?? "";

  print("a. Chuỗi vừa nhập: $s");

  if (s.isEmpty) {
    print("Chuỗi rỗng, không thể xử lý tiếp.");
    return;
  }

  int demNguyenAm = 0;
  String nguyenAm =
      "aeiouAEIOUáàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữự";
  for (int i = 0; i < s.length; i++) {
    if (nguyenAm.contains(s[i])) {
      demNguyenAm++;
    }
  }
  print("b. Số ký tự là nguyên âm (tính cả Tiếng Việt): $demNguyenAm");

  List<String> danhSachTu = s.split(RegExp(r'\s+'));
  print("c. Chuỗi có ${danhSachTu.length} từ.");

  String sKhongKhoangTrang = s.replaceAll(RegExp(r'\s+'), '').toLowerCase();
  String sDaoNguocKytu = sKhongKhoangTrang.split('').reversed.join('');
  bool isDoiXung = (sKhongKhoangTrang == sDaoNguocKytu);
  print("d. Chuỗi ${isDoiXung ? "LÀ" : "KHÔNG PHẢI"} chuỗi đối xứng.");

  String chuoiDaoNguocTu = danhSachTu.reversed.join(' ');
  print("e. Đảo ngược từ trong chuỗi: $chuoiDaoNguocTu");
}
