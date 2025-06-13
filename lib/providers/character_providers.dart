import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/character.dart';
import '../services/api_service.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Tüm Karakterler Provider
final charactersProvider = FutureProvider<List<Character>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getAllCharacters();
});

// Öğrenciler Provider
final studentsProvider = FutureProvider<List<Character>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getStudents();
});

// Personel Provider
final staffProvider = FutureProvider<List<Character>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getStaff();
});

// Ev bazında karakterler Provider (parametre ile)
final houseCharactersProvider = FutureProvider.family<List<Character>, String>((ref, house) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getCharactersByHouse(house);
});

// Arama için filtrelenmiş karakterler Provider
final filteredCharactersProvider = FutureProvider.family<List<Character>, String>((ref, query) async {
  final characters = await ref.read(charactersProvider.future);
  
  if (query.isEmpty) return characters;
  
  return characters.where((character) {
    return character.name.toLowerCase().contains(query.toLowerCase()) ||
           (character.house?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
           (character.actor?.toLowerCase().contains(query.toLowerCase()) ?? false);
  }).toList();
});

// Seçili karakterler için StateNotifier
class SelectedCharactersNotifier extends StateNotifier<List<Character>> {
  SelectedCharactersNotifier() : super([]);

  void addCharacter(Character character) {
    if (!state.contains(character)) {
      state = [...state, character];
    }
  }

  void removeCharacter(Character character) {
    state = state.where((c) => c.id != character.id).toList();
  }

  void toggleCharacter(Character character) {
    if (state.any((c) => c.id == character.id)) {
      removeCharacter(character);
    } else {
      addCharacter(character);
    }
  }

  void clearAll() {
    state = [];
  }

  bool isSelected(Character character) {
    return state.any((c) => c.id == character.id);
  }
}

// Favori karakterler Provider
final selectedCharactersProvider = StateNotifierProvider<SelectedCharactersNotifier, List<Character>>((ref) {
  return SelectedCharactersNotifier();
});

// Mevcut filtre durumu Provider
enum CharacterFilter { all, students, staff, gryffindor, slytherin, hufflepuff, ravenclaw }

final characterFilterProvider = StateProvider<CharacterFilter>((ref) {
  return CharacterFilter.all;
});

// Aktif karakterler Provider (filtreye göre)
final activeCharactersProvider = FutureProvider<List<Character>>((ref) async {
  final filter = ref.watch(characterFilterProvider);
  
  switch (filter) {
    case CharacterFilter.all:
      return ref.read(charactersProvider.future);
    case CharacterFilter.students:
      return ref.read(studentsProvider.future);
    case CharacterFilter.staff:
      return ref.read(staffProvider.future);
    case CharacterFilter.gryffindor:
      return ref.read(houseCharactersProvider('gryffindor').future);
    case CharacterFilter.slytherin:
      return ref.read(houseCharactersProvider('slytherin').future);
    case CharacterFilter.hufflepuff:
      return ref.read(houseCharactersProvider('hufflepuff').future);
    case CharacterFilter.ravenclaw:
      return ref.read(houseCharactersProvider('ravenclaw').future);
  }
});

// Arama sorgusu Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Arama sonuçları Provider
final searchResultsProvider = FutureProvider<List<Character>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final characters = await ref.read(activeCharactersProvider.future);
  
  if (query.isEmpty) return characters;
  
  return characters.where((character) {
    return character.name.toLowerCase().contains(query.toLowerCase()) ||
           (character.house?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
           (character.actor?.toLowerCase().contains(query.toLowerCase()) ?? false);
  }).toList();
}); 