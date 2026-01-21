// lib/repositories/service_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mudpro_desktop_app/api_endpoint/api_endpoint.dart';
import 'package:mudpro_desktop_app/modules/company_setup/model/service_model.dart';

class ServiceController {
  // Update this with your backend URL


  // ============ PACKAGE APIs ============
  Future<Map<String, dynamic>> addPackages(List<PackageItem> packages) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.addPackages),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(packages.map((e) => e.toJson()).toList()),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add packages');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<PackageItem>> getPackages() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.getPackages),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['data'];
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
      final response = await http.post(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.addServices),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(services.map((e) => e.toJson()).toList()),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add services');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<ServiceItem>> getServices() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.getServices),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['data'];
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
      final response = await http.post(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.addEngineering),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(engineering.map((e) => e.toJson()).toList()),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add engineering');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<EngineeringItem>> getEngineering() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.getEngineering),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['data'];
        return items.map((e) => EngineeringItem.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load engineering');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}