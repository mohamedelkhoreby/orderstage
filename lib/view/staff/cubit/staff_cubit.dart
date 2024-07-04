import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../model/staff_model.dart';

part 'staff_state.dart';
// StaffCubit to manage the state of fetching users

class StaffCubit extends Cubit<StaffState> {
  StaffCubit() : super(StaffInitial());
  // Method to fetch Staff
  fetchUsers() async {
    final dio = Dio();
    // Setting request headers
    dio.options.headers['Accept-Language'] = 'ar';
    dio.options.headers['X-API-Key'] = 'demo_apikey';
    try {
      // Emitting loading state
      emit(StaffLoading());
      // Making a GET request to the API endpoint
      final response = await dio.get(
          'http://49.13.75.171:8080/orderstage_dev/api/v1/facEmp/demoUsers');
      // Checking if response is successful and has a valid status
      if (response.statusCode == 200 && response.data['status']) {
        List<dynamic> data = response.data['data'];
        // Mapping JSON data to a list of User objects
        final List<User> users =
            data.map((json) => User.fromJson(json)).toList();
        // Emitting loaded state with the list of users
        emit(StaffLoaded(users));
      }
    } catch (e) {
      emit(StaffError(e.toString()));
    }
  }
}
