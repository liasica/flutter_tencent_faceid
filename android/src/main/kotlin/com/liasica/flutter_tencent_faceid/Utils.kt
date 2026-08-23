package com.liasica.flutter_tencent_faceid

import android.util.Base64
import android.util.Base64OutputStream
import java.io.ByteArrayOutputStream
import java.io.File

class Utils {
    companion object {
        fun convertImageFileToBase64(imageFile: File): String {
            // return Base64.encodeToString(imageFile.readBytes(), Base64.NO_WRAP)
            return ByteArrayOutputStream().use { outputStream ->
                Base64OutputStream(outputStream, Base64.NO_WRAP).use { base64FilterStream ->
                    imageFile.inputStream().use { inputStream ->
                        inputStream.copyTo(base64FilterStream)
                    }
                }
                return@use outputStream.toString()
            }
        }
    }
}