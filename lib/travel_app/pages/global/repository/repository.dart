mixin GlobalRepository{
    Future<dynamic> fetchData();
    Future<void> createBooking({required dynamic booking});
}