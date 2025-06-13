import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/character_providers.dart';

class CharacterFilterChips extends ConsumerWidget {
  const CharacterFilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(characterFilterProvider);

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'Tümü',
            icon: Icons.people,
            filter: CharacterFilter.all,
            isSelected: selectedFilter == CharacterFilter.all,
            onSelected: () => ref.read(characterFilterProvider.notifier).state = CharacterFilter.all,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Öğrenciler',
            icon: Icons.school,
            filter: CharacterFilter.students,
            isSelected: selectedFilter == CharacterFilter.students,
            onSelected: () => ref.read(characterFilterProvider.notifier).state = CharacterFilter.students,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Personel',
            icon: Icons.work,
            filter: CharacterFilter.staff,
            isSelected: selectedFilter == CharacterFilter.staff,
            onSelected: () => ref.read(characterFilterProvider.notifier).state = CharacterFilter.staff,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Gryffindor',
            icon: Icons.shield,
            filter: CharacterFilter.gryffindor,
            isSelected: selectedFilter == CharacterFilter.gryffindor,
            onSelected: () => ref.read(characterFilterProvider.notifier).state = CharacterFilter.gryffindor,
            color: const Color(0xFF7D2027),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Slytherin',
            icon: Icons.shield,
            filter: CharacterFilter.slytherin,
            isSelected: selectedFilter == CharacterFilter.slytherin,
            onSelected: () => ref.read(characterFilterProvider.notifier).state = CharacterFilter.slytherin,
            color: const Color(0xFF0D4C29),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Hufflepuff',
            icon: Icons.shield,
            filter: CharacterFilter.hufflepuff,
            isSelected: selectedFilter == CharacterFilter.hufflepuff,
            onSelected: () => ref.read(characterFilterProvider.notifier).state = CharacterFilter.hufflepuff,
            color: const Color(0xFFECB939),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Ravenclaw',
            icon: Icons.shield,
            filter: CharacterFilter.ravenclaw,
            isSelected: selectedFilter == CharacterFilter.ravenclaw,
            onSelected: () => ref.read(characterFilterProvider.notifier).state = CharacterFilter.ravenclaw,
            color: const Color(0xFF0E1A40),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final CharacterFilter filter;
  final bool isSelected;
  final VoidCallback onSelected;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.filter,
    required this.isSelected,
    required this.onSelected,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? Theme.of(context).primaryColor;
    
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : chipColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.white,
      selectedColor: chipColor,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? chipColor : chipColor.withOpacity(0.3),
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
} 