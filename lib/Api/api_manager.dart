import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islami/models/radio_reciters_model.dart';
import 'package:islami/models/radio_response_model.dart';
import 'package:islami/models/reciters_response_model.dart';

class ApiManager {
  static Future<RadioResponseModel> getRadioData() async{
    try{
      Uri uri = Uri.parse("https://www.mp3quran.net/api/v3/radios?language=ar");
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return RadioResponseModel.fromJson(jsonResponse);
    } catch(e){
      rethrow;
    }
  }

  static Future<RecitersResponseModel> getRecitersData() async{
    try{
      Uri uri = Uri.parse("https://www.mp3quran.net/api/v3/reciters");
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return RecitersResponseModel.fromJson(jsonResponse);
    } catch(e){
      rethrow;
    }
  }

  static Future<RadioRecitersModel> getAllData() async{
    try{
      final result = await Future.wait([getRadioData(),getRecitersData()]);
      return RadioRecitersModel(radioResponseModel: result[0] as RadioResponseModel, recitersResponseModel: result[1] as RecitersResponseModel);
    } catch(e){
      rethrow;
    }
  }
}