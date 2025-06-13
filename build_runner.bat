@echo off
echo 🚀 Code generation başlatılıyor...

REM Temizleme
echo 🧹 Eski generated dosyalar temizleniyor...
flutter packages pub run build_runner clean

REM Code generation
echo 🔨 Yeni kod üretiliyor...
flutter packages pub run build_runner build --delete-conflicting-outputs

echo ✅ Code generation tamamlandı!
echo 📱 Artık uygulamayı çalıştırabilirsiniz: flutter run
pause 