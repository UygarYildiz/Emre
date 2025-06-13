#!/bin/bash

echo "🚀 Code generation başlatılıyor..."

# Temizleme
echo "🧹 Eski generated dosyalar temizleniyor..."
flutter packages pub run build_runner clean

# Code generation
echo "🔨 Yeni kod üretiliyor..."
flutter packages pub run build_runner build --delete-conflicting-outputs

echo "✅ Code generation tamamlandı!"
echo "📱 Artık uygulamayı çalıştırabilirsiniz: flutter run" 