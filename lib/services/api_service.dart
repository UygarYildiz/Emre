import 'package:dio/dio.dart';
import '../models/character.dart';

class ApiService {
  static const String baseUrl = 'https://hp-api.onrender.com/api';
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // İsteğe yönelik log interceptor ekleyelim
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print(obj),
    ));
  }

  Future<List<Character>> getAllCharacters() async {
    try {
      final response = await _dio.get('/characters');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        throw ApiException('Karakterler yüklenemedi: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Beklenmeyen bir hata oluştu: $e');
    }
  }

  Future<List<Character>> getCharactersByHouse(String house) async {
    try {
      final response = await _dio.get('/characters/house/$house');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        throw ApiException('Ev karakterleri yüklenemedi: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Beklenmeyen bir hata oluştu: $e');
    }
  }

  Future<List<Character>> getStudents() async {
    try {
      final response = await _dio.get('/characters/students');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        throw ApiException('Öğrenciler yüklenemedi: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Beklenmeyen bir hata oluştu: $e');
    }
  }

  Future<List<Character>> getStaff() async {
    try {
      final response = await _dio.get('/characters/staff');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        throw ApiException('Personel yüklenemedi: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Beklenmeyen bir hata oluştu: $e');
    }
  }

  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException('Bağlantı zaman aşımına uğradı');
      case DioExceptionType.sendTimeout:
        return ApiException('İstek gönderme zaman aşımına uğradı');
      case DioExceptionType.receiveTimeout:
        return ApiException('Yanıt alma zaman aşımına uğradı');
      case DioExceptionType.badResponse:
        return ApiException('Sunucu hatası: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return ApiException('İstek iptal edildi');
      case DioExceptionType.connectionError:
        return ApiException('İnternet bağlantınızı kontrol edin');
      default:
        return ApiException('Bilinmeyen hata: ${error.message}');
    }
  }
}

class ApiException implements Exception {
  final String message;
  
  ApiException(this.message);
  
  @override
  String toString() => 'ApiException: $message';
} 