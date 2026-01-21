// lib/repositories/engineer_repository.dart

import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mudpro_desktop_app/api_endpoint/api_endpoint.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/company_model.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/engineers_model.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/service_model.dart';

class AuthRepository {
  final String baseUrl = ApiEndpoint.baseUrl;

  // Add Engineer
  Future<Map<String, dynamic>> addEngineer(Engineer engineer) async {
    try {
      final url = Uri.parse('$baseUrl${ApiEndpoint.addEngineersData}');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(engineer.toJson()),
      );

      final data = jsonDecode(response.body);
      print( "statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': data['data'] != null ? Engineer.fromJson(data['data']) : null,
          'message': data['message'] ?? 'Engineer added successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add engineer',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  // Get All Engineers
  Future<Map<String, dynamic>> getEngineers() async {
    try {
      final url = Uri.parse('$baseUrl${ApiEndpoint.getEngineersData}');
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 200) {
        List<Engineer> engineers = [];
        if (data['data'] != null) {
          engineers = (data['data'] as List)
              .map((item) => Engineer.fromJson(item))
              .toList();
        }

        return {
          'success': true,
          'data': engineers,
          'message': data['message'] ?? 'Engineers fetched successfully',
        };
      } else {
        return {
          'success': false,
          'data': <Engineer>[],
          'message': data['message'] ?? 'Failed to fetch engineers',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'data': <Engineer>[],
        'message': 'Error: ${e.toString()}',
      };
    }
  }


   // Add Company Details with Image
  Future<Map<String, dynamic>> addCompanyDetails(Map<String, dynamic> payload) async {
    try {
      final url = Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.addCompanyDetails);
      print('🔄 API Call: addCompanyDetails');
      print('🌐 URL: $url');
      print('📝 Fields: $payload');

      var request = http.MultipartRequest('POST', url);

      // Add text fields from payload
      payload.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      print('📤 Sending multipart request...');

      // Send request with timeout
      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('⏰ Request timed out after 30 seconds');
          throw Exception('Request timed out');
        },
      );

      print('📥 Received streamed response');

      var response = await http.Response.fromStream(streamedResponse);
      print('📄 Status Code: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Request successful');
        return {
          'success': true,
          'data': data['data'] != null ? Company.fromJson(data['data']) : null,
          'message': data['message'] ?? 'Company details saved successfully',
        };
      } else {
        print('❌ Request failed with status ${response.statusCode}');
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to save company details',
        };
      }
    } catch (e) {
      print('❌ Error in addCompanyDetails: ${e.toString()}');
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  // Update Company Details with Image
  Future<Map<String, dynamic>> updateCompanyDetails(Map<String, dynamic> payload) async {
    try {
      final url = Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.updateCompanyDetails);

      var request = http.MultipartRequest('PUT', url);

      // Add text fields from payload
      payload.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);

            print("statuscode------${response.statusCode}");
            print("response body------${response.body}");

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': data['data'] != null ? Company.fromJson(data['data']) : null,
          'message': data['message'] ?? 'Company details updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update company details',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  // Get Company Details
  Future<Map<String, dynamic>> getCompanyDetails() async {
    try {
      final url = Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.getCompanyDetails);
      
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);
      
      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 200) {
        Company? company;
        if (data['data'] != null) {
          company = Company.fromJson(data['data']);
        }

        return {
          'success': true,
          'data': company,
          'message': data['message'] ?? 'Company details fetched successfully',
        };
      } else {
        return {
          'success': false,
          'data': null,
          'message': data['message'] ?? 'Failed to fetch company details',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'data': null,
        'message': 'Error: ${e.toString()}',
      };
    }
  }



/// ===============================
  /// GET OPERATORS
  /// ===============================
  Future<Map<String, dynamic>> getOperators() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.getOperators),
        headers: {"Content-Type": "application/json"},
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  /// ===============================
  /// SAVE OPERATORS (BULK)
  /// ===============================
  Future<Map<String, dynamic>> saveOperators(
      List<Map<String, dynamic>> body) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.saveOperators),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
 
  
}