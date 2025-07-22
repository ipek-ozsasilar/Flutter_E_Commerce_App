void main() {
  print("🚀 App başladı");
  
  // ❌ CRASH VERSION
  // riskyOperationWithoutTryCatch();
  
  // ✅ SAFE VERSION  
  riskyOperationWithTryCatch();
  
  print("✅ App hala çalışıyor!"); // Bu satır çalışır!
}

// ❌ Try-catch olmadan - APP CRASH!
void riskyOperationWithoutTryCatch() {
  throw Exception("💥 Something went wrong!");
  print("Bu satır ASLA çalışmaz"); // Dead code
}

// ✅ Try-catch ile - APP DEVAM EDER!
void riskyOperationWithTryCatch() {
  try {
    throw Exception("💥 Something went wrong!");
    print("Bu satır çalışmaz ama app crash olmaz");
  } catch (e) {
    print("⚠️ Error yakalandı: $e");
    print("🛡️ Graceful handling yapıldı");
    // App devam ediyor!
  }
  
  print("✨ Try-catch'ten sonra kod devam ediyor");
} 