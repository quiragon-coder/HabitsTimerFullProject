import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers_timer.dart';

class CreateActivityPage extends ConsumerStatefulWidget {
  const CreateActivityPage({super.key});
  @override
  ConsumerState<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends ConsumerState<CreateActivityPage> {
  final _form = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  String _emoji = '🎯';
  Color _color = const Color(0xFF6C63FF);

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Créer une activité')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nom requis' : null,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: ['🎯','✏️','📚','🏃','🎸','💻','🧘','📖','🎮','🍳']
                    .map((e) => ChoiceChip(
                      label: Text(e), selected: _emoji == e,
                      onSelected: (_) => setState(() => _emoji = e),
                    ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Couleur'),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      final c = await showDialog<Color>(
                        context: context,
                        builder: (_) => _ColorPickerDialog(initial: _color),
                      );
                      if (c != null) setState(() => _color = c);
                    },
                    child: CircleAvatar(backgroundColor: _color),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Créer'),
                onPressed: () async {
                  if (!_form.currentState!.validate()) return;
                  await db.createActivity(
                    name: _nameCtrl.text.trim(),
                    emoji: _emoji,
                    colorValue: _color.value,
                  );
                  if (mounted) Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog({required this.initial});
  final Color initial;
  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}
class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _current = widget.initial;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choisir une couleur'),
      content: SizedBox(
        width: 280,
        child: Wrap(
          spacing: 8, runSpacing: 8,
          children: [
            const Color(0xFF6C63FF),
            const Color(0xFFFF6B6B),
            const Color(0xFF00C2A8),
            const Color(0xFFFFC107),
            const Color(0xFF00BCD4),
            const Color(0xFF8BC34A),
            const Color(0xFF9C27B0),
          ].map((c) => GestureDetector(
            onTap: () => setState(() => _current = c),
            child: CircleAvatar(
              radius: 18, backgroundColor: c,
              child: _current.value == c.value ? const Icon(Icons.check) : null,
            ),
          )).toList(),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop<Color>(context), child: const Text('Annuler')),
        FilledButton(onPressed: () => Navigator.pop<Color>(context, _current), child: const Text('OK')),
      ],
    );
  }
}
