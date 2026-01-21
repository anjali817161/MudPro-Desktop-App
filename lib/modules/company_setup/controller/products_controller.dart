import 'package:get/get.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/products_model.dart';

class ProductsController extends GetxController {
  var products = <Product>[].obs;
  var editingIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with one empty row
    products.add(Product());
  }

  void addProduct() {
    products.add(Product());
  }

  void deleteProduct(int index) {
    if (products.length > 1) {
      products.removeAt(index);
    }
  }

  void updateProduct(int index, Product product) {
    products[index] = product;
  }
}