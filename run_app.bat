@echo off
echo 🚀 Harry Potter Flutter uygulaması başlatılıyor...
echo.

echo 📦 Paketler kontrol ediliyor...
flutter pub get

echo.
echo 🔧 Code generation kontrol ediliyor...
if not exist "lib\models\character.freezed.dart" (
    echo Freezed dosyaları bulunamadı, oluşturuluyor...
    flutter packages pub run build_runner build --delete-conflicting-outputs
) else (
    echo ✅ Generated dosyalar mevcut
)

echo.
echo 🏥 Flutter doctor kontrol ediliyor...
flutter doctor

echo.
echo 📱 Uygulama başlatılıyor...
flutter run

pause 