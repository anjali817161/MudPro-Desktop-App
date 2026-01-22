import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mudpro_desktop_app/api_endpoint/api_endpoint.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/service_model.dart';

class ServiceController {
  final String baseUrl = ApiEndpoint.baseUrl;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ============ PACKAGE APIs ============
  
  // Add single or bulk packages
  Future<Map<String, dynamic>> addPackages(List<PackageItem> packages) async {
    try {
      // If single package
      if (packages.length == 1) {
        final response = await http.post(
          Uri.parse('$baseUrl${ApiEndpoint.addPackages}'),
          headers: _headers,
          body: jsonEncode(packages.first.toJson()),
        );

        final responseData = jsonDecode(response.body);
        print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");
        
        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'message': 'Package added successfully',
            'data': responseData['data'],
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Failed to add package',
          };
        }
      } 
      // Bulk packages
      else {
        final response = await http.post(
          Uri.parse('$baseUrl${ApiEndpoint.addBulkPackages}'),
          headers: _headers,
          body: jsonEncode(packages.map((e) => e.toJson()).toList()),
        );

        final responseData = jsonDecode(response.body);
        print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");

        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'message': '${packages.length} packages added successfully',
            'saved': packages.length,
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Failed to add packages',
          };
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  Future<List<PackageItem>> getPackages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiEndpoint.getPackages}'),
        headers: _headers,
      );
      print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final List items = data['data'] ?? [];
        return items.map((e) => PackageItem.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load packages');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ============ SERVICE APIs ============
  
  Future<Map<String, dynamic>> addServices(List<ServiceItem> services) async {
    try {
      // If single service
      if (services.length == 1) {
        final response = await http.post(
          Uri.parse('$baseUrl${ApiEndpoint.addServices}'),
          headers: _headers,
          body: jsonEncode(services.first.toJson()),
        );

        final responseData = jsonDecode(response.body);
        print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");
        
        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'message': 'Service added successfully',
            'data': responseData['data'],
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Failed to add service',
          };
        }
      } 
      // Bulk services
      else {
        final response = await http.post(
          Uri.parse('$baseUrl${ApiEndpoint.addBulkServices}'),
          headers: _headers,
          body: jsonEncode(services.map((e) => e.toJson()).toList()),
        );

        final responseData = jsonDecode(response.body);
        print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");

        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'message': '${services.length} services added successfully',
            'saved': services.length,
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Failed to add services',
          };
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  Future<List<ServiceItem>> getServices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiEndpoint.getServices}'),
        headers: _headers,
      );

print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");

        
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final List items = data['data'] ?? [];
        return items.map((e) => ServiceItem.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ============ ENGINEERING APIs ============
  
  Future<Map<String, dynamic>> addEngineering(List<EngineeringItem> engineering) async {
    try {
      // If single engineering
      if (engineering.length == 1) {
        final response = await http.post(
          Uri.parse('$baseUrl${ApiEndpoint.addEngineering}'),
          headers: _headers,
          body: jsonEncode(engineering.first.toJson()),
        );

        final responseData = jsonDecode(response.body);
        print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");

        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'message': 'Engineering item added successfully',
            'data': responseData['data'],
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Failed to add engineering',
          };
        }
      } 
      // Bulk engineering
      else {
        final response = await http.post(
          Uri.parse('$baseUrl${ApiEndpoint.addBulkEngineering}'),
          headers: _headers,
          body: jsonEncode(engineering.map((e) => e.toJson()).toList()),
        );

        final responseData = jsonDecode(response.body);
        print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");

        if (response.statusCode == 201 || response.statusCode == 200) {
          return {
            'success': true,
            'message': '${engineering.length} engineering items added successfully',
            'saved': engineering.length,
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Failed to add engineering',
          };
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  Future<List<EngineeringItem>> getEngineering() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiEndpoint.getEngineering}'),
        headers: _headers,
      );

      print("responsebody: ${response.body}");
        print("statusCode: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final List items = data['data'] ?? [];
        return items.map((e) => EngineeringItem.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load engineering');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}