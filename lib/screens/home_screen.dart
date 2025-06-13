import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/character_providers.dart';
import '../widgets/character_card.dart';
import '../widgets/character_filter_chips.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart';
import 'character_detail_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = ref.watch(searchQueryProvider);

    // Arama fonksiyonu
    void onSearchChanged(String query) {
      ref.read(searchQueryProvider.notifier).state = query;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🧙‍♂️ Harry Potter Karakterleri',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        shadowColor: Colors.black26,
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Karakter, ev veya oyuncu ara...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),

          // Filtre Çipleri
          const CharacterFilterChips(),

          // Karakter Listesi
          Expanded(
            child: _CharacterList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Favoriler ekranına gidecek
          _showFavorites(context, ref);
        },
        child: const Icon(Icons.favorite),
        tooltip: 'Favori Karakterler',
      ),
    );
  }

  void _showFavorites(BuildContext context, WidgetRef ref) {
    final selectedCharacters = ref.read(selectedCharactersProvider);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Favori Karakterler (${selectedCharacters.length})',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              if (selectedCharacters.isEmpty)
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Henüz favori karakter eklemediniz',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: selectedCharacters.length,
                    itemBuilder: (context, index) {
                      final character = selectedCharacters[index];
                      return CharacterCard(
                        character: character,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailScreen(character: character),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterList extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResultsAsync = ref.watch(searchResultsProvider);

    return searchResultsAsync.when(
      data: (characters) {
        if (characters.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Aradığınız kriterlere uygun karakter bulunamadı',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            // Verileri yenile
            ref.invalidate(charactersProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CharacterCard(
                  character: character,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterDetailScreen(character: character),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const LoadingShimmer(),
      error: (error, stackTrace) => ErrorDisplayWidget(
        error: error.toString(),
        onRetry: () {
          ref.invalidate(searchResultsProvider);
        },
      ),
    );
  }
} 