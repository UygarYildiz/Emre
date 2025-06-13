import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/character.dart';
import '../providers/character_providers.dart';

class CharacterDetailScreen extends ConsumerWidget {
  final Character character;

  const CharacterDetailScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacters = ref.watch(selectedCharactersProvider);
    final isSelected = selectedCharacters.any((c) => c.id == character.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                character.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'character_${character.id}',
                    child: character.image != null && character.image!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: character.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  // Gradient overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black26,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(selectedCharactersProvider.notifier).toggleCharacter(character);
                },
                icon: Icon(
                  isSelected ? Icons.favorite : Icons.favorite_border,
                  color: isSelected ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Temel Bilgiler
                  _buildSection(
                    context,
                    'Temel Bilgiler',
                    [
                      _buildInfoTile('İsim', character.name),
                      if (character.alternateNames != null && character.alternateNames!.isNotEmpty)
                        _buildInfoTile(
                          'Diğer İsimler',
                          character.alternateNames!.join(', '),
                        ),
                      if (character.actor != null && character.actor!.isNotEmpty)
                        _buildInfoTile('Oyuncu', character.actor!),
                      if (character.alternateActors != null && character.alternateActors!.isNotEmpty)
                        _buildInfoTile(
                          'Diğer Oyuncular',
                          character.alternateActors!.join(', '),
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Karakteristik Özellikler
                  _buildSection(
                    context,
                    'Karakteristik Özellikler',
                    [
                      if (character.species != null && character.species!.isNotEmpty)
                        _buildInfoTile('Tür', character.species!),
                      if (character.gender != null && character.gender!.isNotEmpty)
                        _buildInfoTile('Cinsiyet', character.gender!),
                      if (character.ancestry != null && character.ancestry!.isNotEmpty)
                        _buildInfoTile('Soy', character.ancestry!),
                      if (character.eyeColour != null && character.eyeColour!.isNotEmpty)
                        _buildInfoTile('Göz Rengi', character.eyeColour!),
                      if (character.hairColour != null && character.hairColour!.isNotEmpty)
                        _buildInfoTile('Saç Rengi', character.hairColour!),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Hogwarts Bilgileri
                  _buildSection(
                    context,
                    'Hogwarts Bilgileri',
                    [
                      if (character.house != null && character.house!.isNotEmpty)
                        _buildHouseTile(character.house!),
                      _buildStatusTile('Öğrenci', character.hogwartsStudent == true),
                      _buildStatusTile('Personel', character.hogwartsStaff == true),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Büyücü Bilgileri
                  if (character.wizard == true) ...[
                    _buildSection(
                      context,
                      'Büyücü Bilgileri',
                      [
                        _buildStatusTile('Büyücü', character.wizard == true),
                        if (character.wand != null) _buildWandTile(character.wand!),
                        if (character.patronus != null && character.patronus!.isNotEmpty)
                          _buildInfoTile('Patronus', character.patronus!),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Kişisel Bilgiler
                  _buildSection(
                    context,
                    'Kişisel Bilgiler',
                    [
                      if (character.dateOfBirth != null && character.dateOfBirth!.isNotEmpty)
                        _buildInfoTile('Doğum Tarihi', character.dateOfBirth!),
                      if (character.yearOfBirth != null)
                        _buildInfoTile('Doğum Yılı', character.yearOfBirth.toString()),
                      _buildStatusTile('Hayatta', character.alive != false),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTile(String label, bool status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Icon(
                  status ? Icons.check_circle : Icons.cancel,
                  color: status ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  status ? 'Evet' : 'Hayır',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: status ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHouseTile(String house) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              'Ev',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getHouseColor(house),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                house,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWandTile(Wand wand) {
    final wandInfo = <String>[];
    if (wand.wood != null && wand.wood!.isNotEmpty) {
      wandInfo.add('Ahşap: ${wand.wood}');
    }
    if (wand.core != null && wand.core!.isNotEmpty) {
      wandInfo.add('Çekirdek: ${wand.core}');
    }
    if (wand.length != null) {
      wandInfo.add('Uzunluk: ${wand.length}" ');
    }

    if (wandInfo.isEmpty) return const SizedBox.shrink();

    return _buildInfoTile('Asa', wandInfo.join('\n'));
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