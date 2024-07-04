import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// RegistrationCubit handles the state of the registration screen and manages the fetching of countries
class RegistrationCubit extends Cubit<List<String>> {
  RegistrationCubit()
      : super([]); // Constructor initializes the state with an empty list

// Method to fetch the list of countries
  fetchCountries() async {
    final dio = Dio();
    dio.options.headers['Accept-Language'] = 'ar';
    dio.options.headers['X-API-Key'] = 'demo_apikey';
    try {
      final response = await dio
          .get('http://49.13.75.171:8080/orderstage_dev/api/v1/country/all');
      if (response.statusCode == 200) {
        List<String> countries = (response.data['data'] as List)
            .map((country) => country['nameAr'].toString())
            .toList();
        emit(countries);
      }
    } catch (e) {
      List<String> error = [];
      error.add(e.toString());
    }
  }
}
