import 'package:cosmetics/core/common/widgets/app_images.dart';
import 'package:cosmetics/core/common/widgets/app_input.dart';
import 'package:cosmetics/core/helpers/extensions.dart';
import 'package:cosmetics/core/network/dio_helper.dart';
import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:cosmetics/core/theme/app_texts/app_text_styles.dart';
import 'package:cosmetics/core/utils/common_imports.dart';
import 'package:cosmetics/views/home/widgets/top_rated_product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> topRatedProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTopRatedProducts();
  }

  Future<void> fetchTopRatedProducts() async {
    try {
      final response = await DioHelper.get("/api/Products");
      final List data = response.data;
      setState(() {
        topRatedProducts = data
            .map((e) => Product.fromJson(e))
            .take(6)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error loading products")));
    }
  }

  Future<void> addToCart(int productId) async {
    try {
      final response = await DioHelper.post(
        "/api/Cart/add",
        queryParameters: {"productId": productId, "quantity": 1},
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.data["message"])));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to add to cart")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.h.ph,
            AppInput(
              labelText: 'Search',
              suffixIcon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Center(child: AppImages(imagePath: '/search.svg')),
              ),
            ),
            12.h.ph,
            AppImages(imagePath: '/poster.png'),
            12.h.ph,
            Text(
              'Top rated products',
              style: AppTextStyles.font16Bold.copyWith(
                color: LightAppColors.primary800,
              ),
            ),
            14.h.ph,
            if (isLoading)
              SizedBox(
                height: 300.h,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (topRatedProducts.isEmpty)
              Center(child: Text('No products available'))
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topRatedProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = topRatedProducts[index];
                  return TopRatedProductCard(
                    onPressed: () {
                      addToCart(product.id);
                    },
                    imageUrl: product.imageUrl,
                    title: product.name,
                    price: "\$${product.price}",
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String imageUrl;
  final int? categoryId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
    this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"] ?? "",
      price: (json["price"] as num).toDouble(),
      stock: json["stock"],
      imageUrl: json["imageUrl"],
      categoryId: json["categoryId"],
    );
  }
}
