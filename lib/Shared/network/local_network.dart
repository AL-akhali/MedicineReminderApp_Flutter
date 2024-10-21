import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork{
  static late SharedPreferences sharedPref;
  static Future cacheInit() async
  {
    sharedPref = await SharedPreferences.getInstance();
  }
  static Future<bool>InsertToCache({required String key,required dynamic value})
  async
  {
    if(value is String) return await sharedPref.setString(key, value);
    if(value is int) return await sharedPref.setInt(key, value);
    if(value is bool) return await sharedPref.setBool(key, value);
    return await sharedPref.setDouble(key, value);

  }
  static String GetCacheDate({required String key})
  {
    return  sharedPref.getString(key) ?? "";
  }
  static Future<bool> DeleteCacheItem({required String key})
  async
  {
    return await sharedPref.remove(key);
  }

}