# Harry Potter Karakterleri Mobil Uygulaması

Bu uygulama, [Harry Potter API](https://hp-api.onrender.com) kullanarak Harry Potter evrenindeki karakterleri listeleyen ve detaylarını gösteren modern bir Flutter mobil uygulamasıdır.

## 🎯 Özellikler

- **Karakter Listesi**: Tüm Harry Potter karakterlerini görüntüleme
- **Filtreler**: Öğrenciler, personel ve Hogwarts evlerine göre filtreleme
- **Arama**: Karakter ismi, oyuncu adı veya ev ismine göre arama
- **Favori Karakterler**: Sevdiğiniz karakterleri favori listesine ekleme
- **Detay Sayfası**: Her karakter için kapsamlı bilgi sayfası
- **Responsive Tasarım**: Tüm ekran boyutlarına uyumlu arayüz
- **Modern UI**: Material Design 3 ile tasarlanmış temiz arayüz
- **Hata Yönetimi**: Kullanıcı dostu hata mesajları ve yeniden deneme seçenekleri

## 🛠️ Kullanılan Teknolojiler

### State Yönetimi
- **Flutter Riverpod**: Modern ve güçlü state yönetimi
- **Hooks Riverpod**: React hooks benzeri state yönetimi

### HTTP İstekleri
- **Dio**: Professional HTTP client
- **Interceptors**: Request/response logging ve hata yönetimi

### UI ve UX
- **Flutter Hooks**: Fonksiyonel widget yaklaşımı
- **Cached Network Image**: Performanslı resim yükleme ve önbellekleme
- **Shimmer**: Loading state için güzel animasyonlar
- **Material Design 3**: Modern ve tutarlı tasarım sistemi

### Code Generation
- **Freezed**: Immutable data classları
- **JSON Serialization**: Otomatik JSON parsing
- **Build Runner**: Code generation otomasyonu

## 📱 Ekran Görüntüleri

### Ana Ekran
- Karakter listesi ve arama
- Filtre çipleri (Evler, öğrenci/personel)
- Pull-to-refresh desteği
- Favori butonları

### Karakter Detayı
- Hero animasyonu ile resim geçişi
- Kapsamlı karakter bilgileri
- Asa, patronus ve diğer büyücü detayları
- Responsive layout

### Favori Karakterler
- Bottom sheet ile favori liste
- Kolay erişim ve yönetim

## 🏗️ Proje Yapısı

```
lib/
├── models/           # Data modelleri (Freezed ile)
├── services/         # API servisleri (Dio ile)
├── providers/        # Riverpod provider'ları
├── screens/          # Uygulama ekranları
├── widgets/          # Yeniden kullanılabilir widget'lar
└── main.dart         # Ana uygulama dosyası
```

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- Android/iOS emulator veya fiziksel cihaz

### Adımlar

1. **Projeyi klonlayın**
```bash
git clone <repository-url>
cd harry_potter_app
```

2. **Bağımlılıkları yükleyin**
```bash
flutter pub get
```

3. **Code generation çalıştırın**
```bash
flutter packages pub run build_runner build
```

4. **Uygulamayı çalıştırın**
```bash
flutter run
```

### Development Modunda Code Generation
Geliştirme sırasında değişiklikleri otomatik takip etmek için:
```bash
flutter packages pub run build_runner watch
```

## 📋 API Endpoints

Uygulama aşağıdaki Harry Potter API endpoint'lerini kullanır:

- `GET /api/characters` - Tüm karakterler
- `GET /api/characters/students` - Öğrenciler
- `GET /api/characters/staff` - Personel
- `GET /api/characters/house/{house}` - Ev bazında karakterler

## 🎨 Tasarım Özellikleri

### Tema
- **Ana Renk**: Harry Potter temasına uygun mor (#2D1B69)
- **Ev Renkleri**: Her Hogwarts evi için orijinal renkler
- **Typography**: Okunabilir ve modern font hierarchy
- **Dark Mode**: Sistem temasına uyumlu dark mode desteği

### Animasyonlar
- Hero animasyonları resim geçişlerinde
- Shimmer loading animasyonları
- Smooth scroll animasyonları
- Card hover efektleri

## 🔧 Özelleştirme

### Yeni Filtre Ekleme
`CharacterFilter` enum'ına yeni değer ekleyip `activeCharactersProvider`'ı güncelleyin.

### Yeni API Endpoint'i
`ApiService` sınıfına yeni method ekleyip ilgili provider'ı oluşturun.

### UI Bileşenleri
`widgets/` klasöründeki bileşenler yeniden kullanılabilir şekilde tasarlanmıştır.

## 📱 Platform Desteği

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11+)
- ✅ **Web** (PWA desteği)
- ✅ **Desktop** (Windows, macOS, Linux)

## 🐛 Hata Yönetimi

- Network connectivity kontrolleri
- API timeout yönetimi
- User-friendly hata mesajları
- Retry mekanizmaları
- Graceful degradation

## 🚦 Test Etme

```bash
# Unit testler
flutter test

# Integration testler
flutter test integration_test/

# Widget testler
flutter test test/widgets/
```

## 📈 Performans Optimizasyonları

- Image caching ile network kullanımını azaltma
- Lazy loading ile memory kullanımını optimize etme
- Provider caching ile gereksiz API çağrılarını önleme
- Efficient list rendering

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add amazing feature'`)
4. Branch'i push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## 🙏 Teşekkürler

- [Harry Potter API](https://hp-api.onrender.com) - Verileri sağladığı için
- Flutter ve Dart ekipleri - Harika framework için
- Riverpod ekibi - Excellent state management için 