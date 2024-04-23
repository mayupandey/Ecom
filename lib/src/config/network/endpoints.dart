class Endpoints {
  // static const baseUrl = String.fromEnvironment("API");
  static const baseUrl = "https://dummyjson.com";

  /// NEEDS TO BE REVIEWED
  static const connectionTimeout = 40;
  static const receiveTimeout = 40;

  /// Product Endpoints
  static const fetchProductsEndpoint = "/products";
  static const fetchCategoriesEndpoint = "/products/categories";
  static const fetchProductsByCategoryEndpoint = "/products/category";
}
