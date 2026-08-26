import 'dart:io';

bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void main() {
  print("========== BÀI TẬP 3: XỬ LÝ LIST SỐ NGUYÊN ==========");
  List<int> ds = [];

  stdout.write("Bạn muốn nhập bao nhiêu phần tử? ");
  int n = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  for (int i = 0; i < n; i++) {
    stdout.write("Nhập phần tử thứ ${i + 1}: ");
    int val = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    ds.add(val);
  }

  print("\na. Danh sách vừa nhập: $ds");

  int tong = ds.fold(0, (sum, element) => sum + element);
  print("b. Tổng các phần tử: $tong");

  var dsNguyenTo = ds.where((element) => isPrime(element)).toList();
  print("c. Các số nguyên tố trong danh sách: $dsNguyenTo");

  stdout.write("\nd. Nhập một giá trị bất kỳ để tìm kiếm: ");
  int x = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  if (ds.contains(x)) {
    List<int> viTri = [];
    for (int i = 0; i < ds.length; i++) {
      if (ds[i] == x) viTri.add(i);
    }
    print("-> Giá trị $x có trong danh sách tại các vị trí (index): $viTri");
  } else {
    ds.insert(0, x);
    print("-> Không tìm thấy! Đã thêm $x vào đầu danh sách.");
    print("-> Danh sách mới: $ds");
  }
}
