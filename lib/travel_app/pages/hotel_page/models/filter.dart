class FilterModel {
  int minPrice;
  int maxPrice;
  String searchText;

  FilterModel({this.minPrice = 1, this.maxPrice = 100000000, this.searchText = ''});
}
