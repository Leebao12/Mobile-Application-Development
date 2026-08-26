import 'package:quan_li_san_pham/SanPham.dart';
import 'dart:io';
Future<List<SanPham>> readFile(String fileName) async {
{
  List<SanPham> arrs = [];
  try {
  List<String> lines = await File(fileName).readAsLines();
  for (String line in lines) {
  List<String> parts = line.split('#'); 
    if (parts.length == 4) {
      String masp = parts[0].trim();
      String tensp = parts[1].trim();
      double giaban = double.parse(parts[2].trim());
      double giamgia = double.parse(parts[3].trim());
      if (masp != null && tensp != null) {
        arrs.add(SanPham.fullPara(masp, tensp,giaban, giamgia));
      }
    }
  }
  } catch (e) {
  print('Lỗi khi đọc file: $e');
  }
  return arrs;
}
}
void main() async {
    SanPham sp = SanPham();
    sp.showInfo();
    SanPham sp1 = SanPham.fullPara('SP001', 'Bánh gạo Nhật', 25000, 0);
    sp1.showInfo();
    List<SanPham> lstSanPham = [];
    SanPham sp2 = SanPham.fullPara('SP002', 'Trà ô long', 75000, 0);
    SanPham sp3 = SanPham.fullPara('SP003', 'Mứt xoài sấy', 45000, 0);
    lstSanPham.add(sp1);
    lstSanPham.add(sp2);
    lstSanPham.add(sp3);
    print("Danh sách sản phẩm là: ");
    for (SanPham a in lstSanPham) {
      a.showInfo();
    }
    List<SanPham> ds = await readFile('lib/sanpham.txt');
    print("Đọc dữ liệu từ file: ");
    for (SanPham x in ds) {
      x.showInfo();
    }
}

