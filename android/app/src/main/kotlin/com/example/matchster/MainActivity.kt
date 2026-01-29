package com.matchster.matchster

import android.content.Intent
import androidx.annotation.NonNull
import com.example.matchster.PostureCameraActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "posture/camera"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startPostureCamera") {
                startPostureCameraActivity()
                result.success("Camera Activity Launched")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startPostureCameraActivity() {
        val intent = Intent(this, PostureCameraActivity::class.java)
        startActivity(intent)
    }
}

