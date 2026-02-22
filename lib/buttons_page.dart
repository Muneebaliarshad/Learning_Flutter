import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  String _selectedSegment = 'Option 1';
  List<bool> _toggleSelections = [false, true, false];
  String? _selectedDropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Buttons'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Material Design 3 Buttons Section
            _buildSectionTitle('Material Design 3 Buttons', theme),
            const SizedBox(height: 16),

            // FilledButton
            FilledButton(
              onPressed: () => _showSnackBar('FilledButton pressed'),
              child: const Text('Filled Button'),
            ),
            const SizedBox(height: 12),

            // FilledButton.tonal
            FilledButton.tonal(
              onPressed: () => _showSnackBar('FilledButton.tonal pressed'),
              child: const Text('Filled Button Tonal'),
            ),
            const SizedBox(height: 12),

            // OutlinedButton
            OutlinedButton(
              onPressed: () => _showSnackBar('OutlinedButton pressed'),
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 12),

            // TextButton
            TextButton(
              onPressed: () => _showSnackBar('TextButton pressed'),
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 12),

            // Buttons with Icons
            FilledButton.icon(
              onPressed: () => _showSnackBar('FilledButton with icon pressed'),
              icon: const Icon(Icons.favorite),
              label: const Text('Filled Button Icon'),
            ),
            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () =>
                  _showSnackBar('OutlinedButton with icon pressed'),
              icon: const Icon(Icons.share),
              label: const Text('Outlined Button Icon'),
            ),
            const SizedBox(height: 12),

            TextButton.icon(
              onPressed: () => _showSnackBar('TextButton with icon pressed'),
              icon: const Icon(Icons.download),
              label: const Text('Text Button Icon'),
            ),
            const SizedBox(height: 24),

            // Icon Buttons Section
            _buildSectionTitle('Icon Buttons', theme),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => _showSnackBar('IconButton pressed'),
                  icon: const Icon(Icons.favorite),
                  tooltip: 'Favorite',
                ),
                IconButton.filled(
                  onPressed: () => _showSnackBar('IconButton.filled pressed'),
                  icon: const Icon(Icons.star),
                  tooltip: 'Star',
                ),
                IconButton.filledTonal(
                  onPressed: () =>
                      _showSnackBar('IconButton.filledTonal pressed'),
                  icon: const Icon(Icons.thumb_up),
                  tooltip: 'Like',
                ),
                IconButton.outlined(
                  onPressed: () => _showSnackBar('IconButton.outlined pressed'),
                  icon: const Icon(Icons.share),
                  tooltip: 'Share',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // FloatingActionButton Section
            _buildSectionTitle('FloatingActionButton', theme),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'fab_default',
                  onPressed: () =>
                      _showSnackBar('FloatingActionButton pressed'),
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton.extended(
                  heroTag: 'fab_extended',
                  onPressed: () =>
                      _showSnackBar('FloatingActionButton.extended pressed'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                FloatingActionButton.small(
                  heroTag: 'fab_small',
                  onPressed: () =>
                      _showSnackBar('FloatingActionButton.small pressed'),
                  child: const Icon(Icons.favorite),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // SegmentedButton Section
            _buildSectionTitle('SegmentedButton', theme),
            const SizedBox(height: 16),

            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Option 1', label: Text('Option 1')),
                ButtonSegment(value: 'Option 2', label: Text('Option 2')),
                ButtonSegment(value: 'Option 3', label: Text('Option 3')),
              ],
              selected: {_selectedSegment},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedSegment = newSelection.first;
                });
                _showSnackBar('Selected: $_selectedSegment');
              },
            ),
            const SizedBox(height: 24),

            // ToggleButtons Section
            _buildSectionTitle('ToggleButtons', theme),
            const SizedBox(height: 16),

            ToggleButtons(
              isSelected: _toggleSelections,
              onPressed: (int index) {
                setState(() {
                  _toggleSelections[index] = !_toggleSelections[index];
                });
                _showSnackBar('Toggle ${index + 1} toggled');
              },
              children: const [
                Icon(Icons.format_bold),
                Icon(Icons.format_italic),
                Icon(Icons.format_underlined),
              ],
            ),
            const SizedBox(height: 24),

            // DropdownButton Section
            _buildSectionTitle('DropdownButton', theme),
            const SizedBox(height: 16),

            DropdownButton<String>(
              value: _selectedDropdownValue,
              hint: const Text('Select an option'),
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'option1', child: Text('Option 1')),
                DropdownMenuItem(value: 'option2', child: Text('Option 2')),
                DropdownMenuItem(value: 'option3', child: Text('Option 3')),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDropdownValue = newValue;
                });
                _showSnackBar('Selected: $newValue');
              },
            ),
            const SizedBox(height: 24),

            // PopupMenuButton Section
            _buildSectionTitle('PopupMenuButton', theme),
            const SizedBox(height: 16),

            PopupMenuButton<String>(
              onSelected: (String value) {
                _showSnackBar('Selected: $value');
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Show Menu'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Button States Section
            _buildSectionTitle('Button States', theme),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: null, // Disabled state
              child: const Text('Disabled FilledButton'),
            ),
            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: null, // Disabled state
              child: const Text('Disabled OutlinedButton'),
            ),
            const SizedBox(height: 12),

            TextButton(
              onPressed: null, // Disabled state
              child: const Text('Disabled TextButton'),
            ),
            const SizedBox(height: 24),

            // Custom Styled Buttons Section
            _buildSectionTitle('Custom Styled Buttons', theme),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: () => _showSnackBar('Custom styled button pressed'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Rounded Button'),
            ),
            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: () => _showSnackBar('Custom outlined button pressed'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                side: const BorderSide(width: 2),
              ),
              child: const Text('Thick Border Button'),
            ),
            const SizedBox(height: 12),

            TextButton(
              onPressed: () => _showSnackBar('Custom text button pressed'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                backgroundColor: colorScheme.surfaceVariant,
              ),
              child: const Text('TextButton with Background'),
            ),
            const SizedBox(height: 24),

            // Cupertino Buttons Section
            _buildSectionTitle('Cupertino Buttons (iOS Style)', theme),
            const SizedBox(height: 16),

            CupertinoButton(
              onPressed: () => _showSnackBar('CupertinoButton pressed'),
              child: const Text('CupertinoButton'),
            ),
            const SizedBox(height: 12),

            CupertinoButton.filled(
              onPressed: () => _showSnackBar('CupertinoButton.filled pressed'),
              child: const Text('CupertinoButton.filled'),
            ),
            const SizedBox(height: 12),

            CupertinoButton(
              onPressed: () =>
                  _showSnackBar('CupertinoButton with color pressed'),
              color: CupertinoColors.activeBlue,
              child: const Text('CupertinoButton (Colored)'),
            ),
            const SizedBox(height: 12),

            CupertinoButton(
              onPressed: null, // Disabled state
              child: const Text('CupertinoButton (Disabled)'),
            ),
            const SizedBox(height: 24),

            // Deprecated Buttons Section
            _buildSectionTitle('Deprecated Buttons (Still Available)', theme),
            const SizedBox(height: 8),
            Text(
              'Note: These are deprecated but still functional',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () =>
                  _showSnackBar('ElevatedButton pressed (Deprecated)'),
              child: const Text('ElevatedButton (Deprecated)'),
            ),
            const SizedBox(height: 12),

            TextButton(
              onPressed: () => _showSnackBar('FlatButton equivalent'),
              child: const Text('FlatButton → Use TextButton'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => _showSnackBar('RaisedButton equivalent'),
              child: const Text('RaisedButton → Use FilledButton'),
            ),
            const SizedBox(height: 24),

            // Custom/Composition Buttons Section
            _buildSectionTitle('Custom/Composition Buttons', theme),
            const SizedBox(height: 16),

            // GestureDetector
            GestureDetector(
              onTap: () => _showSnackBar('GestureDetector tapped'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'GestureDetector Button',
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // InkWell
            InkWell(
              onTap: () => _showSnackBar('InkWell tapped'),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'InkWell Button (with ripple)',
                  style: TextStyle(
                    color: colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // MaterialButton
            MaterialButton(
              onPressed: () => _showSnackBar('MaterialButton pressed'),
              color: colorScheme.tertiaryContainer,
              textColor: colorScheme.onTertiaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('MaterialButton'),
            ),
            const SizedBox(height: 12),

            // GestureDetector with Long Press
            GestureDetector(
              onTap: () => _showSnackBar('GestureDetector tapped'),
              onLongPress: () => _showSnackBar('GestureDetector long pressed'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'GestureDetector (Tap & Long Press)',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // InkWell with custom splash
            InkWell(
              onTap: () => _showSnackBar('InkWell with custom splash'),
              splashColor: colorScheme.primary.withOpacity(0.3),
              highlightColor: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'InkWell (Custom Splash)',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
