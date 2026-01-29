// lib/repositories/engineer_repository.dart

import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mudpro_desktop_app/api_endpoint/api_endpoint.dart';
import 'package:mudpro_desktop_app/modules/UG/model/pit_model.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/company_model.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/engineers_model.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/products_model.dart';
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


  // Add these methods to your existing AuthRepository class

// Update Engineer
Future<Map<String, dynamic>> updateEngineer(String engineerId, Engineer engineer) async {
  try {

    print('$baseUrl${ApiEndpoint.updateEngineer}/$engineerId');
    final url = Uri.parse('$baseUrl${ApiEndpoint.updateEngineer}/$engineerId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(engineer.toJson()),
    );

    final data = jsonDecode(response.body);
        print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

    if (response.statusCode == 200) {
      return {
        'success': true,
        'data': Engineer.fromJson(data['data']),
        'message': data['message'] ?? 'Engineer updated successfully',
      };
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to update engineer',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'Error: ${e.toString()}',
    };
  }
}

// Delete Engineer
Future<Map<String, dynamic>> deleteEngineer(String engineerId) async {
  try {
     print('$baseUrl${ApiEndpoint.deleteEngineer}/$engineerId');
    final url = Uri.parse('$baseUrl${ApiEndpoint.deleteEngineer}/$engineerId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final data = jsonDecode(response.body);
      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': data['message'] ?? 'Engineer deleted successfully',
      };
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to delete engineer',
      };
    }
  } catch (e) {
    return {
      'success': false,
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
 

 // Default headers
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  // UPDATE OPERATOR
Future<Map<String, dynamic>> updateOperator(
    String id, Map<String, dynamic> operatorData) async {
  try {
    final response = await http.put(
      Uri.parse('${ApiEndpoint.baseUrl}${ApiEndpoint.updateOperator}/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(operatorData),
    );

    final responseData = jsonDecode(response.body);
    print("Update operator response: ${response.body}");
    print("Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': responseData['message'] ?? 'Operator updated successfully',
        'data': responseData['data'],
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to update operator',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'Error: $e',
    };
  }
}

// DELETE OPERATOR
Future<Map<String, dynamic>> deleteOperator(String id) async {
  try {
    final response = await http.delete(
      Uri.parse('${ApiEndpoint.baseUrl}${ApiEndpoint.deleteOperator}/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final responseData = jsonDecode(response.body);
    print("Delete operator response: ${response.body}");
    print("Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': responseData['message'] ?? 'Operator deleted successfully',
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to delete operator',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'Error: $e',
    };
  }
}

  // Add single product
  Future<Map<String, dynamic>> addProduct(ProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.addProducts),
        headers: _headers,
        body: jsonEncode(product.toJson()),
      );

      final responseData = jsonDecode(response.body);
      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 201 ) {
        return {
          'success': true,
          'message': 'Product added successfully',
          'data': responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to add product',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }

  // Bulk add products
  Future<Map<String, dynamic>> bulkAddProducts(List<ProductModel> products) async {
    try {
      final validProducts = products
          .where((p) => p.isValid())
          .map((p) => p.toJson())
          .toList();

      if (validProducts.isEmpty) {
        return {
          'success': false,
          'message': 'No valid products to save',
        };
      }

      final response = await http.post(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.addBulkProducts),
        headers: _headers,
        body: jsonEncode(validProducts),
      );

      final responseData = jsonDecode(response.body);

      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 201  || response.statusCode == 200) {
        return {
          'success': true,
          'message': '${responseData['saved']} products saved successfully',
          'saved': responseData['saved'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to save products',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }

  // Upload Excel file
  Future<Map<String, dynamic>> uploadExcel(String filePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.addExcel),
      );

      // Add file
      var file = await http.MultipartFile.fromPath(
        'file',
        filePath,
        contentType: MediaType('application', 'vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
      );
      
      request.files.add(file);

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      
      final responseData = jsonDecode(response.body);
      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': '${responseData['inserted']} products imported successfully',
          'inserted': responseData['inserted'],
          'errors': responseData['errors'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to upload Excel',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }

  // Get products (pagination)
  Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int limit = 20,
    String? search,
    String? group,
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
        if (group != null && group.isNotEmpty) 'Group': group,
      };

      final uri = Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.getProducts).replace(
        queryParameters: queryParams,
      );

      final response = await http.get(uri, headers: _headers);
      final responseData = jsonDecode(response.body);

      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<ProductModel> products = (responseData['data'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();

        return {
          'success': true,
          'products': products,
          'total': responseData['total'],
          'page': responseData['page'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch products',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }

 // Add these methods to your existing AuthRepository class

// Update Product
Future<Map<String, dynamic>> updateProduct(String productId, ProductModel product) async {
  try {

     print('${baseUrl}v1/products/$productId');
    final response = await http.put(
      Uri.parse('${baseUrl}v1/products/$productId'),
      headers: _headers,
      body: jsonEncode(product.toJson()),
    );

    final responseData = jsonDecode(response.body);

     print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'success': true,
        'data': ProductModel.fromJson(responseData['data']),
        'message': responseData['message'] ?? 'Product updated successfully',
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to update product',
      };
    }
  } on SocketException {
    return {
      'success': false,
      'message': 'No internet connection',
    };
  } on FormatException {
    return {
      'success': false,
      'message': 'Invalid response format',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'An unexpected error occurred: $e',
    };
  }
}

// Delete Product
Future<Map<String, dynamic>> deleteProduct(String productId) async {
  try {

    print('${baseUrl}v1/products/$productId');

    final response = await http.delete(
      Uri.parse('${baseUrl}v1/products/$productId'),
      headers: _headers,
    );

    final responseData = jsonDecode(response.body);

     print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'success': true,
        'message': responseData['message'] ?? 'Product deleted successfully',
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to delete product',
      };
    }
  } on SocketException {
    return {
      'success': false,
      'message': 'No internet connection',
    };
  } on FormatException {
    return {
      'success': false,
      'message': 'Invalid response format',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'An unexpected error occurred: $e',
    };
  }
}

  // Restore product
  Future<Map<String, dynamic>> restoreProduct(String id) async {
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}v1/products/restore/$id'),
        headers: _headers,
      );

      final responseData = jsonDecode(response.body);

       print("statuscode------${response.statusCode}");
      print("response body------${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Product restored successfully',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to restore product',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'No internet connection',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }


  // ============= CREATE OPERATIONS =============
  
  /// Add single pit
  Future<Map<String, dynamic>> addPit({
    required String pitName,
    required double capacity,
    required bool initialActive,
    required String wellId,
    String? reportId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}pit/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'pitName': pitName,
          'capacity': capacity,
          'initialActive': initialActive,
          'wellId': wellId,
          if (reportId != null) 'reportId': reportId,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': PitModel.fromJson(data['data']),
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add pit',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Bulk add pits
  Future<Map<String, dynamic>> bulkAddPits({
    required List<Map<String, dynamic>> pits,
    required String wellId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}pit/bulk-add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'pits': pits,
          'wellId': wellId,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        final List<PitModel> insertedPits = (data['data'] as List)
            .map((pit) => PitModel.fromJson(pit))
            .toList();
        
        return {
          'success': true,
          'data': insertedPits,
          'message': data['message'],
          'skipped': data['skipped'] ?? 0,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add pits',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // ============= READ OPERATIONS =============
  
  /// Get all pits for a well
  Future<Map<String, dynamic>> getAllPits(String wellId) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}pit/well/$wellId'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);

      print("statuscode------${response.statusCode}");
      print("response body------${response.body}");
      
      if (response.statusCode == 200) {
        final List<PitModel> pits = (data['data'] as List)
            .map((pit) => PitModel.fromJson(pit))
            .toList();
        
        return {
          'success': true,
          'data': pits,
          'totalCapacity': data['totalCapacity'],
          'count': data['count'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch pits',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Get selected (active) pits
  Future<Map<String, dynamic>> getSelectedPits(String wellId) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}pit/well/$wellId/selected'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        final List<PitModel> pits = (data['data'] as List)
            .map((pit) => PitModel.fromJson(pit))
            .toList();
        
        return {
          'success': true,
          'data': pits,
          'totalCapacity': data['totalCapacity'],
          'count': data['count'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch selected pits',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Get unselected (inactive) pits
  Future<Map<String, dynamic>> getUnselectedPits(String wellId) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}pit/well/$wellId/unselected'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        final List<PitModel> pits = (data['data'] as List)
            .map((pit) => PitModel.fromJson(pit))
            .toList();
        
        return {
          'success': true,
          'data': pits,
          'totalCapacity': data['totalCapacity'],
          'count': data['count'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch unselected pits',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Get single pit by ID
  Future<Map<String, dynamic>> getPitById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}pit/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': PitModel.fromJson(data['data']),
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to fetch pit',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // ============= UPDATE OPERATIONS =============
  
  /// Update single pit
  Future<Map<String, dynamic>> updatePit({
    required String id,
    String? pitName,
    double? capacity,
    bool? initialActive,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}pit/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          if (pitName != null) 'pitName': pitName,
          if (capacity != null) 'capacity': capacity,
          if (initialActive != null) 'initialActive': initialActive,
        }),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': PitModel.fromJson(data['data']),
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update pit',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Bulk update pits
  Future<Map<String, dynamic>> bulkUpdatePits(
    List<Map<String, dynamic>> updates,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('${baseUrl}pit/bulk-update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'updates': updates}),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'modifiedCount': data['modifiedCount'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to update pits',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Toggle lock/unlock pit
  Future<Map<String, dynamic>> toggleLockPit({
    required String id,
    required bool isLocked,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('${baseUrl}pit/$id/toggle-lock'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isLocked': isLocked}),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': PitModel.fromJson(data['data']),
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to toggle lock',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // ============= DELETE OPERATIONS =============
  
  /// Delete single pit
  Future<Map<String, dynamic>> deletePit(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}pit/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to delete pit',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Bulk delete pits
  Future<Map<String, dynamic>> bulkDeletePits(List<String> ids) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}pit/bulk-delete'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'ids': ids}),
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'deletedCount': data['deletedCount'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to delete pits',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Delete all pits for a well
  Future<Map<String, dynamic>> deleteAllPitsByWell(String wellId) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}pit/well/$wellId/all'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'deletedCount': data['deletedCount'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to delete pits',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
  
}