import 'package:bai_tap_vn/HoaDon.dart';
import 'package:bai_tap_vn/KhachHangCaNhan.dart';
import 'package:bai_tap_vn/DaiLyCap1.dart';
import 'package:bai_tap_vn/KhachHangCongTy.dart';
import 'package:bai_tap_vn/QuanLyHoaDon.dart';
import 'dart:io';
void main() {
  QuanLyHoaDon ql = QuanLyHoaDon();

  ql.dsHoaDon.add(KhachHangCaNhan.fullPara("KH0001", "Nguyen Van A", 4, 1000000, 5));
  ql.dsHoaDon.add(DaiLyCap1.fullPara("KH0002", "Dai Ly B", 10, 1000000, 7));
  ql.dsHoaDon.add(KhachHangCongTy.fullPara("KH0003", "Cong Ty C", 10, 1000000, 6000));

  while (true) {
    print("\n=============== MENU QUẢN LÝ ABC ===============");
    print("1. Nhập danh sách hóa đơn");
    print("2. Xuất danh sách hóa đơn");
    print("3. Tính tổng thành tiền tất cả hóa đơn");
    print("4. Tính tổng tiền trợ giá");
    print("5. Khách hàng có số lượng mua nhiều nhất");
    print("6. Tổng tiền chiết khấu của khách hàng công ty");
    print("7. Sắp xếp danh sách");
    print("8. Tìm kiếm hóa đơn theo Mã KH");
    print("0. Thoát chương trình");
    stdout.write("Nhập lựa chọn: ");
    String chon = stdin.readLineSync()?.trim() ?? "";

    switch (chon) {
      case '1':
        ql.nhapDanhSach();
        break;
      case '2':
        ql.xuatDanhSach();
        break;
      case '3':
        print(
          '=> Tổng thành tiền tất cả hóa đơn: ${ql.tinhTongThanhTien()} VNĐ',
        );
        break;
      case '4':
        print(
          '=> Tổng tiền trợ giá: ${ql.tinhTongTroGia()} VNĐ',
        );
        break;
      case '5':
        List<HoaDon> dsMax = ql.timKhachHangMuaNhieuNhat();
        if (dsMax.isEmpty) {
          print('Danh sách đang rỗng!');
        } else {
          print(
            '=> Danh sách hóa đơn có số lượng mua nhiều nhất (${dsMax.first.soLuong} máy):',
          );
          for (HoaDon hd in dsMax) {
            print(hd);
          }
        }
        break;
      case '6':
        print(
          '=> Tổng tiền chiết khấu của khách hàng công ty: ${ql.tinhTongChietKhauCongTy()} VNĐ',
        );
        break;
      case '7':
        ql.sapXepDanhSach();
        print(
          '=> Đã sắp xếp danh sách (Tăng dần số lượng, nếu bằng nhau thì Giảm dần thành tiền):',
        );
        ql.xuatDanhSach(); 
        break;
      case '8':
        stdout.write("Nhập mã KH cần tìm (KHxxxx): ");
        String ma = stdin.readLineSync()?.trim() ?? "";
        List<HoaDon> kq = ql.timKiemTheoMaKH(ma);
        if (kq.isEmpty) {
          print('Khách hàng lạ');
        } else {
          print('=> Tìm thấy ${kq.length} hóa đơn của mã $ma:');
          for (HoaDon hd in kq) {
            print(hd);
          }
        }
        break;
      case '0':
        print("Tạm biệt!");
        return;
      default:
        print("Lựa chọn không hợp lệ, vui lòng nhập lại!");
    }
  }
}