import 'package:get/get.dart';
import 'package:mudpro_desktop_app/auth_repo/auth_repo.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/products_model.dart';
import 'package:mudpro_desktop_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProductsController extends GetxController {
  final AuthRepository repository = AuthRepository();
  
  ProductsController();

  // Observable list of products (UI only, not from API)
  RxList<ProductModel> products = <ProductModel>[].obs;
  
  // Loading states
  RxBool isSaving = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with one empty row
    addProduct();
  }

  // Add new empty product row
  void addProduct() {
    products.add(ProductModel());
  }

  // Update product at index
  void updateProduct(int index, ProductModel product) {
    if (index < products.length) {
      products[index] = product;
    }
  }

  // Save products (bulk or single based on data)
  Future<void> saveProducts() async {
    // Filter products with data
    final productsWithData = products.where((p) => p.hasData()).toList();
    
    if (productsWithData.isEmpty) {
      Get.snackbar(
        'No Data',
        'Please fill at least one product to save',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
      return;
    }

    // Check for valid products
    final validProducts = productsWithData.where((p) => p.isValid()).toList();
    final invalidProducts = productsWithData.where((p) => !p.isValid()).toList();

    if (validProducts.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields (Product, Code, SG, Unit Num, Unit Class, Group)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 4),
      );
      return;
    }

    // Show warning if some products are invalid
    if (invalidProducts.isNotEmpty) {
      Get.snackbar(
        'Warning',
        '${invalidProducts.length} incomplete products will be skipped',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
    }

    isSaving.value = true;

    try {
      Map<String, dynamic> result;

      // If only one valid product, use single API
      if (validProducts.length == 1) {
        result = await repository.addProduct(validProducts.first);
      } else {
        // Use bulk API for multiple products
        result = await repository.bulkAddProducts(validProducts);
      }

      isSaving.value = false;

      if (result['success']) {
        Get.snackbar(
          'Success',
          result['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppTheme.successColor,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );

        // Clear all fields after successful save
        clearAllProducts();
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      isSaving.value = false;
      Get.snackbar(
        'Error',
        'Failed to save products: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
    }
  }

  // Clear all products and reset to one empty row
  void clearAllProducts() {
    products.clear();
    addProduct();
  }

  // Upload Excel file
  Future<void> uploadExcel(String filePath) async {
    isLoading.value = true;

    try {
      final result = await repository.uploadExcel(filePath);
      
      isLoading.value = false;

      if (result['success']) {
        Get.snackbar(
          'Success',
          result['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppTheme.successColor,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );

        // Show errors if any
        if (result['errors'] != null && result['errors'].isNotEmpty) {
          Get.defaultDialog(
            title: 'Import Errors',
            middleText: 'Some rows had errors:\n${result['errors'].join('\n')}',
            textConfirm: 'OK',
            onConfirm: () => Get.back(),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to upload Excel: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
      );
    }
  }

  @override
  void onClose() {
    products.clear();
    super.onClose();
  }
}