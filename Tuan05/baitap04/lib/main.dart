import 'package:flutter/material.dart';

void main() {
  runApp(const PhoneStoreApp());
}

// MODEL SẢN PHẨM
class Product {
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

// APP
class PhoneStoreApp extends StatelessWidget {
  const PhoneStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cửa hàng điện thoại',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
      ),
      home: const IntroPage(),
    );
  }
}

// GIỎ HÀNG DÙNG CHUNG
final ValueNotifier<List<Product>> cartNotifier = ValueNotifier<List<Product>>(
  [],
);

// DANH SÁCH SẢN PHẨM
final List<Product> products = [
  Product(
    name: 'Điện thoại 01',
    description: 'Điện thoại Samsung với công nghệ hiện đại',
    price: 1200,
    image: 'assets/images/dt1.jpg',
  ),
  Product(
    name: 'Điện thoại 02',
    description: 'Điện thoại cao cấp, thiết kế sang trọng',
    price: 950,
    image: 'assets/images/dt2.jpg',
  ),
  Product(
    name: 'Điện thoại 03',
    description: 'Màn hình đẹp, pin lâu, hiệu năng tốt',
    price: 850,
    image: 'assets/images/dt3.jpg',
  ),
  Product(
    name: 'Điện thoại 04',
    description: 'Camera chất lượng cao, kiểu dáng hiện đại',
    price: 602.2,
    image: 'assets/images/dt4.jpg',
  ),
  Product(
    name: 'Điện thoại 05',
    description: 'Điện thoại phổ thông dễ sử dụng',
    price: 500,
    image: 'assets/images/dt5.jpg',
  ),
  Product(
    name: 'Điện thoại 06',
    description: 'Sản phẩm mới, hiệu suất ổn định',
    price: 780,
    image: 'assets/images/dt6.jpg',
  ),
  Product(
    name: 'Điện thoại 07',
    description: 'Mẫu điện thoại được chọn nhiều nhất',
    price: 2000,
    image: 'assets/images/dt7.jpg',
  ),
];

// TRANG GIỚI THIỆU
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 140,
                height: 140,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 3),
                ),
                child: Image.asset(
                  'assets/images/logo_truong.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                'Cửa hàng điện thoại',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Text(
                '140 Lê Trọng Tấn, Tân Phú, TP.Hồ Chí Minh',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),

              const SizedBox(height: 30),

              // Nút mũi tên
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const StorePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 12,
                  ),
                ),
                child: const Icon(Icons.arrow_forward, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TRANG CỬA HÀNG
class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // DRAWER
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text('Cửa hàng điện thoại'),

        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

        actions: [
          // Icon giỏ hàng
          ValueListenableBuilder<List<Product>>(
            valueListenable: cartNotifier,
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),

                  if (cart.isNotEmpty)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      // BODY
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'Chọn sản phẩm bạn muốn sử dụng',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          // Sản phẩm dạng cuộn ngang
          SizedBox(
            height: 330,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Sản phẩm được lựa chọn nhiều nhất',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // GridView theo mẫu bài học
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              return SmallProductCard(product: products[index]);
            },
          ),
        ],
      ),
    );
  }
}

// DRAWER
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          // HEADER
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: const Text(
              'Vũ Văn Vinh',
              style: TextStyle(fontSize: 18),
            ),
            accountEmail: const Text('vinhvv@huit.edu.vn'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/logo_truong.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // CỬA HÀNG
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.black),
            title: const Text('Cửa hàng'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // GIỎ HÀNG
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.black),
            title: const Text('Giỏ hàng'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),

          // THOÁT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Thoát'),
            onTap: () {
              Navigator.pop(context);

              cartNotifier.value = [];

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const IntroPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

// CARD SẢN PHẨM
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  // HIỂN THỊ DIALOG XÁC NHẬN
  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Xác nhận',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          content: Text('Bạn có muốn thêm ${product.name} vào giỏ hàng không?'),

          actions: [
            // Không
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),

            // Đồng ý
            TextButton(
              onPressed: () {
                cartNotifier.value = [...cartNotifier.value, product];

                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Thông báo'),
                      content: const Text('Bạn vừa thêm sản phẩm vào Giỏ hàng'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình điện thoại
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(product.image, fit: BoxFit.contain),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600]),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${product.price.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Nút +
                  FloatingActionButton.small(
                    heroTag: null,
                    backgroundColor: Colors.teal,
                    onPressed: () {
                      showAddDialog(context);
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// CARD NHỎ
class SmallProductCard extends StatelessWidget {
  final Product product;

  const SmallProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(product.name),
                content: Text(
                  'Giá: ${product.price.toStringAsFixed(1)}\n\n'
                  '${product.description}',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Đóng'),
                  ),
                ],
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                product.image,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),

              Text(
                product.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              Text(product.price.toStringAsFixed(1)),
            ],
          ),
        ),
      ),
    );
  }
}
// TRANG GIỎ HÀNG
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // XÓA SẢN PHẨM
  void removeProduct(int index) {
    final product = cartNotifier.value[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Xác nhận',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          content: Text(
            'Bạn muốn loại bỏ ${product.name} ra khỏi giỏ hàng không?',
          ),

          actions: [
            // Không
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),

            // Đồng ý
            TextButton(
              onPressed: () {
                final newCart = List<Product>.from(cartNotifier.value);

                newCart.removeAt(index);

                cartNotifier.value = newCart;

                Navigator.of(context).pop();
              },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }
  // THANH TOÁN
  void checkout() {
    if (cartNotifier.value.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: const Text('Bạn chưa có sản phẩm nào trong giỏ hàng!!!!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanh toán'),
          content: const Text('Bạn có muốn xác nhận thanh toán không?'),
          actions: [
            // Không
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Không'),
            ),

            // Đồng ý
            TextButton(
              onPressed: () {
                cartNotifier.value = [];

                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Thanh toán'),
                      content: const Text('Bạn đã thanh toán xong giỏ hàng'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng của bạn')),

      body: ValueListenableBuilder<List<Product>>(
        valueListenable: cartNotifier,
        builder: (context, cart, child) {
          // GIỎ HÀNG RỖNG
          if (cart.isEmpty) {
            return Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Bạn chưa có sản phẩm nào trong giỏ hàng!!!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                // Button thanh toán
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: checkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Thanh toán'),
                  ),
                ),
              ],
            );
          }
          // GIỎ HÀNG CÓ SẢN PHẨM
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Giỏ hàng của bạn',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final product = cart[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),

                        title: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        subtitle: Text('${product.price.toStringAsFixed(1)}'),

                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black),
                          onPressed: () {
                            removeProduct(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              // BUTTON THANH TOÁN
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: checkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text('Thanh toán'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
