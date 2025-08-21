import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class CreateActivityPage extends ConsumerStatefulWidget {
  const CreateActivityPage({super.key});

  @override
  ConsumerState<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends ConsumerState<CreateActivityPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emojiCtrl = TextEditingController(text: '🎯');
  Color _color = const Color(0xFF7367F0);

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emojiCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(dbProvider);
    await db.createActivity(
      name: _nameCtrl.text.trim(),
      emoji: _emojiCtrl.text.trim().isEmpty ? '🎯' : _emojiCtrl.text.trim(),
      // DatabaseService attend colorValue (int ARGB)
      colorValue: _color.value,
      dailyGoalMinutes: 0,
      weeklyGoalMinutes: 0,
      monthlyGoalMinutes: 0,
      yearlyGoalMinutes: 0,
    );
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle activité')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nom obligatoire' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emojiCtrl,
                decoration: const InputDecoration(labelText: 'Emoji'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Couleur'),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDialog<Color>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Choisir une couleur'),
                          content: Wrap(
                            spacing: 8, runSpacing: 8,
                            children: [
                              for (final c in [
                                Colors.indigo, Colors.blue, Colors.teal,
                                Colors.green, Colors.orange, Colors.pink, Colors.purple,
                              ])
                                InkWell(
                                  onTap: () => Navigator.pop(ctx, c),
                                  child: Container(
                                    width: 28, height: 28,
                                    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                      if (picked != null) setState(() => _color = picked);
                    },
                    child: Container(
                      width: 24, height: 24,
                      decoration: BoxDecoration(
                        color: _color, shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: _save, child: const Text('Créer')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
