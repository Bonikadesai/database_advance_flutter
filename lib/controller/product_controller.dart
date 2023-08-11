import 'package:get/get.dart';
import 'package:hotel_booking_app/models/product_model.dart';

class ProductController extends GetxController {
  RxList CartProduct = [].obs;

  get TotalItem => CartProduct.length;

  void AddProduct({required ProductModel product}) {
    CartProduct.add(product);
  }

  void RemoveProduct({required ProductModel product}) {
    CartProduct.remove(product);
  }
}
