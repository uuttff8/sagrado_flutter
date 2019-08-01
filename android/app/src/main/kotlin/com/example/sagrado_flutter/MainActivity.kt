package com.example.sagrado_flutter

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import com.yandex.mapkit.MapKitFactory;

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    MapKitFactory.setApiKey("d1698ebd-67fd-4b72-b552-ae646583a389"); 
    GeneratedPluginRegistrant.registerWith(this)
  }
}
