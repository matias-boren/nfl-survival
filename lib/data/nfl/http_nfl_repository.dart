import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// part 'http_nfl_repository.g.dart'; // To be added when endpoints are defined

@RestApi()
abstract class HttpNflApi {
  // TODO: add methods and generate implementation with retrofit
}

// Adapter stub
class HttpNflDataRepository {
  final Dio dio;
  // late final HttpNflApi api;
  HttpNflDataRepository(this.dio);
  // TODO: map API models to domain models
}
