import 'package:flutter/material.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;

  const ErrorDisplayWidget({
    Key? key,
    required this.error,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hata İkonu
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[600],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Başlık
            Text(
              'Bir Hata Oluştu',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            // Hata Mesajı
            Text(
              _getErrorMessage(error),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Tekrar Dene Butonu
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Tekrar Dene'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              
            const SizedBox(height: 16),
            
            // Yardım Metni
            Text(
              'İnternet bağlantınızı kontrol edin veya daha sonra tekrar deneyin.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(String error) {
    // API hata mesajlarını daha kullanıcı dostu hale getir
    if (error.contains('İnternet bağlantınızı kontrol edin')) {
      return 'İnternet bağlantısı sorunu yaşanıyor. Lütfen bağlantınızı kontrol edin.';
    } else if (error.contains('zaman aşımına uğradı')) {
      return 'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.';
    } else if (error.contains('Sunucu hatası')) {
      return 'Sunucu şu anda erişilebilir değil. Lütfen daha sonra tekrar deneyin.';
    } else if (error.contains('Karakterler yüklenemedi')) {
      return 'Karakterler yüklenirken bir sorun oluştu. Tekrar deneyin.';
    } else {
      return 'Beklenmeyen bir hata oluştu. Lütfen uygulamayı yeniden başlatın.';
    }
  }
}

// Küçük hata widget'i (inline kullanım için)
class InlineErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;

  const InlineErrorWidget({
    Key? key,
    required this.error,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 14,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              iconSize: 20,
              color: Colors.red[600],
              tooltip: 'Tekrar Dene',
            ),
          ],
        ],
      ),
    );
  }
} 