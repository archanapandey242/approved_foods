class FoodDetailsBO{
  List<CategoryResponse> categoryResponse;

  FoodDetailsBO({this.categoryResponse});
  factory FoodDetailsBO.fromJson(Map<String, dynamic> json) {
    var categoryList = json['categories'] as List;
    List<CategoryResponse> categoryDetails =
    categoryList.map((i) => CategoryResponse.fromJson(i)).toList();
    return FoodDetailsBO(
      categoryResponse: categoryDetails,
    );
  }
}

class CategoryResponse {
  Category category;

  CategoryResponse({this.category});
  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      category: Category.fromJson(json['category']),
    );
  }

}

class Category {
  List<SubCategory> subCategory;
  String categoryName,strColors;

  Category({this.subCategory,this.categoryName,this.strColors});
  factory Category.fromJson(Map<String, dynamic> json) {
    var subcategoriesList = json['subcategories'] as List;
    List<SubCategory> subcategoriesDetails =
    subcategoriesList.map((i) => SubCategory.fromJson(i)).toList();
    return Category(
     subCategory:subcategoriesDetails,
      categoryName: json['categoryName'],
      strColors: json['colorCode']
    );
  }
}

class SubCategory {
  List<dynamic> items;
  String subCategoryName;

  SubCategory({this.items,this.subCategoryName});
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
        items:json['items'],
        subCategoryName:json['subCategoryname']
    );
  }
}