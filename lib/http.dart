import 'package:dio/dio.dart';
import 'models/location.dart';
import 'models/accommodation.dart';
import 'models/reservation.dart';

class HTTPInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err);
    return super.onError(err, handler);
  }
}

class HTTP {
  late Dio client;
  HTTP() {
    client = Dio(BaseOptions(
      baseUrl: 'https://62a17fb4cd2e8da9b0f28a7a.mockapi.io/api/staycation/',
      receiveDataWhenStatusError: true,
      contentType: 'application/json',
      validateStatus: (status) => status! < 400,
    ));
    client.interceptors.add(
      HTTPInterceptor(),
    );
  }

  Future<List<Location>> getPopularLocations() async {
    Response response = await client.get(
      'locations',
    );
    return response.data
        .map<Location>((json) => Location.fromJson(json))
        .toList();
  }

  Future<List<Accommodation>> getPopularHomes() async {
    Response response = await client.get(
      'homes',
    );
    return response.data
        .map<Accommodation>((json) => Accommodation.fromJson(json))
        .toList();
  }

  Future<List<Location>> getAllLocations() async {
    Response response = await client.get(
      'locations-all',
    );
    return response.data
        .map<Location>((json) => Location.fromJson(json))
        .toList();
  }

  Future<List<Accommodation>> getAllHomes() async {
    Response response = await client.get(
      'homes-all',
    );
    return response.data
        .map<Accommodation>((json) => Accommodation.fromJson(json))
        .toList();
  }

  Future<List<Reservation>> getReservations() async {
    Response response = await client.get(
      'homes-all/1/reservation',
    );
    return response.data
        .map<Reservation>((json) => Reservation.fromJson(json))
        .toList();
  }

  Future<List<Accommodation>> getMyPlaces() async {
    Response response = await client.get(
      'myplaces',
    );
    return response.data
        .map<Accommodation>((json) => Accommodation.fromJson(json))
        .toList();
  }

  Future<Response> addNewPlace(Map<String, dynamic> map) {
    return client.post(
      'myplaces',
      data: map,
    );
  }

  Future<Response> editPlace(int id, Map<String, dynamic> map) {
    return client.put(
      'myplaces/$id',
      data: map,
    );
  }

  Future<Response> deletePlace(int id) async {
    Response response = await client.delete(
      'myplaces/$id',
    );
    return response;
  }

  Future<Response> bookPlace(Map<String, dynamic> map) {
    return client.post(
      'homes-all/1/reservation',
      data: map,
    );
  }
}

final http = HTTP();
