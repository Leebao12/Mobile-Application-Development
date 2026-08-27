import 'dart:io';
import 'dart:math';

void main() {

  Random rand = Random();
  List<int> ds = List.generate(10, (_) => rand.nextInt(96) + 5);

  print("a. Danh sách ngẫu nhiên: $ds");

  var dsLe = ds.where((x) => x % 2 != 0).toList();
  if (dsLe.isEmpty) {
    print("b. Danh sách không có số lẻ.");
  } else {
    double tbcLe = dsLe.fold(0, (sum, x) => sum + x) / dsLe.length;
    print("b. Trung bình cộng số lẻ: ${tbcLe.toStringAsFixed(2)}");
  }

  bool doiXung = true;
  for (int i = 0; i < ds.length ~/ 2; i++) {
    if (ds[i] != ds[ds.length - 1 - i]) {
      doiXung = false;
      break;
    }
  }
  print(
    "c. Danh sách này ${doiXung ? "LÀ" : "KHÔNG PHẢI"} danh sách đối xứng.",
  );

  bool tangDan = true;
  for (int i = 0; i < ds.length - 1; i++) {
    if (ds[i] > ds[i + 1]) {
      tangDan = false;
      break;
    }
  }
  print("d. Danh sách ${tangDan ? "ĐÃ ĐƯỢC" : "CHƯA ĐƯỢC"} sắp xếp tăng dần.");

  int maxVal = ds.reduce(max); 
  print("e. Phần tử lớn nhất trong danh sách: $maxVal");

  var dsChan = ds.where((x) => x % 2 == 0).toList();
  if (dsChan.isEmpty) {
    print("f. Danh sách không có số chẵn.");
  } else {
    int maxChan = dsChan.reduce(max);
    print("f. Số chẵn lớn nhất trong danh sách: $maxChan");
  }

  stdout.write("\ng. Nhập giá trị cần xóa: ");
  int x = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  if (!ds.contains(x)) {
    print("-> Không tìm thấy.");
  } else {
    ds.removeWhere((element) => element == x);
    print("-> Đã xóa tất cả các số $x. Danh sách mới: $ds");
  }
}
