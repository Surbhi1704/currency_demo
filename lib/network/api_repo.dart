import 'package:flutter_application_demo/network/api_endpoints.dart';

import 'package:http/http.dart';


class ApiRepo{


 static  Future<Response> getSupportedCode() => get(Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.apiKey+ApiEndpoints.supportedCode));
 
 static  Future<Response> getRates(base,target) => get(Uri.parse("${ApiEndpoints.baseUrl}${ApiEndpoints.apiKey}${ApiEndpoints.getBaseTargetRate}/$base/$target"));

  
}