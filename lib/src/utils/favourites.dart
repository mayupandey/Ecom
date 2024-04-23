import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:hive/hive.dart';

class Favourites {
  final Box<Products>? box;
  Favourites._(this.box);
  static Future<Favourites> getInstance() async {
    final box = await Hive.openBox<Products>('favourites');

    return Favourites._(box);
  }

  void addFavourite(Products item) async {
    box!.put(item.id, item);
  }

  void removeFavourite(int itemId) async {
    box!.delete(itemId);
  }

  void clear() {
    box!.clear();
  }
}
