import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldsPage extends StatefulWidget {
  const TextFieldsPage({super.key});

  @override
  State<TextFieldsPage> createState() => _TextFieldsPageState();
}

class _TextFieldsPageState extends State<TextFieldsPage> {
  final _formKey = GlobalKey<FormState>();
  final _basicController = TextEditingController();
  final _multilineController = TextEditingController();
  final _formEmailController = TextEditingController();
  final _formPasswordController = TextEditingController();
  final _cupertinoController = TextEditingController();
  final _readOnlyController = TextEditingController(text: 'Read only value');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _basicController.dispose();
    _multilineController.dispose();
    _formEmailController.dispose();
    _formPasswordController.dispose();
    _cupertinoController.dispose();
    _readOnlyController.dispose();
    super.dispose();
  }

  void _onSubmitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form valid: ${_formEmailController.text}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Text Fields'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionTitle(title: '1. TextField (Material)', theme: theme),

              const SizedBox(height: 8),

              TextField(
                controller: _basicController,
                decoration: InputDecoration(
                  labelText: 'Basic TextField',
                  hintText: 'Single line input',
                  prefixIcon: const Icon(Icons.text_fields),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _readOnlyController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Read-only TextField',
                  hintText: 'Cannot edit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _multilineController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Multiline TextField',
                  hintText: 'Enter multiple lines...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
              ),

              const SizedBox(height: 32),

              _SectionTitle(title: '2. TextFormField (with validation)', theme: theme),
              const SizedBox(height: 8),

              TextFormField(
                controller: _formEmailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'you@example.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _formPasswordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _onSubmitForm(),
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Min 6 characters',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              FilledButton(
                onPressed: _onSubmitForm,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Validate Form'),
              ),

              const SizedBox(height: 32),

              _SectionTitle(title: '3. CupertinoTextField (iOS style)', theme: theme),

              const SizedBox(height: 8),

              CupertinoTextField(
                controller: _cupertinoController,
                placeholder: 'iOS-style text field',
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(CupertinoIcons.pencil, color: CupertinoColors.systemGrey),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemFill,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 16),

              CupertinoTextField(
                placeholder: 'Cupertino multiline',
                maxLines: 3,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemFill,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              CupertinoTextField(
                placeholder: 'Obscured (password style)',
                obscureText: true,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemFill,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.theme});

  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
