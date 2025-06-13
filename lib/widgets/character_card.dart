import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/character.dart';
import '../providers/character_providers.dart';

class CharacterCard extends ConsumerWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterCard({
    Key? key,
    required this.character,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacters = ref.watch(selectedCharactersProvider);
    final isSelected = selectedCharacters.any((c) => c.id == character.id);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Karakter Resmi
              Hero(
                tag: 'character_${character.id}',
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: character.image != null && character.image!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: character.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Karakter Bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // İsim
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Ev
                    if (character.house != null && character.house!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getHouseColor(character.house!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          character.house!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    const SizedBox(height: 4),

                    // Oyuncu
                    if (character.actor != null && character.actor!.isNotEmpty)
                      Text(
                        '🎭 ${character.actor}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 4),

                    // Durum İkonları
                    Row(
                      children: [
                        if (character.wizard == true)
                          const Icon(Icons.auto_fix_high, size: 16, color: Colors.purple),
                        if (character.wizard == true) const SizedBox(width: 4),
                        if (character.hogwartsStudent == true)
                          const Icon(Icons.school, size: 16, color: Colors.blue),
                        if (character.hogwartsStudent == true) const SizedBox(width: 4),
                        if (character.hogwartsStaff == true)
                          const Icon(Icons.work, size: 16, color: Colors.orange),
                        if (character.hogwartsStaff == true) const SizedBox(width: 4),
                        if (character.alive == false)
                          const Icon(Icons.dangerous, size: 16, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),

              // Favori Butonu
              IconButton(
                onPressed: () {
                  ref.read(selectedCharactersProvider.notifier).toggleCharacter(character);
                },
                icon: Icon(
                  isSelected ? Icons.favorite : Icons.favorite_border,
                  color: isSelected ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getHouseColor(String house) {
    switch (house.toLowerCase()) {
      case 'gryffindor':
        return const Color(0xFF7D2027);
      case 'slytherin':
        return const Color(0xFF0D4C29);
      case 'hufflepuff':
        return const Color(0xFFECB939);
      case 'ravenclaw':
        return const Color(0xFF0E1A40);
      default:
        return Colors.grey;
    }
  }
} 