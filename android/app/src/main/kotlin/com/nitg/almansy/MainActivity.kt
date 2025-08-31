package com.nitg.almansy

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.view.WindowManager.LayoutParams
class MainActivity: FlutterActivity() {
   override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        window.setFlags(
            LayoutParams.FLAG_SECURE,
            LayoutParams.FLAG_SECURE
        )
    }
}
