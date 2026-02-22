import 'package:flutter/material.dart';

class GesturesDemoPage extends StatefulWidget {
  const GesturesDemoPage({super.key});

  @override
  State<GesturesDemoPage> createState() => _GesturesDemoPageState();
}

class _GesturesDemoPageState extends State<GesturesDemoPage> {
  final List<String> _eventLog = [];
  static const int _maxLogEntries = 12;

  double _panX = 0, _panY = 0;
  double _scale = 1.0;
  double _rotation = 0;
  double _verticalDragOffset = 0;
  double _horizontalDragOffset = 0;

  void _log(String message) {
    setState(() {
      _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)} $message');
      if (_eventLog.length > _maxLogEntries) _eventLog.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Gestures Demo'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          _buildEventLog(colorScheme),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSection(
                  theme,
                  'Tap',
                  'Tap, TapDown, TapUp, TapCancel',
                  _buildTapZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Double Tap',
                  'DoubleTap, DoubleTapDown, DoubleTapCancel',
                  _buildDoubleTapZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Long Press',
                  'LongPress, LongPressStart, MoveUpdate, Up, End',
                  _buildLongPressZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Secondary / Tertiary Tap',
                  'Right-click, middle-click (or two-finger tap)',
                  _buildSecondaryTertiaryZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Pan (free drag)',
                  'PanDown, Start, Update, End, Cancel',
                  _buildPanZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Scale (pinch)',
                  'ScaleStart, ScaleUpdate, ScaleEnd',
                  _buildScaleZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Vertical Drag',
                  'VerticalDrag Down, Start, Update, End, Cancel',
                  _buildVerticalDragZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Horizontal Drag',
                  'HorizontalDrag Down, Start, Update, End, Cancel',
                  _buildHorizontalDragZone(colorScheme),
                ),
                _buildSection(
                  theme,
                  'Force Press (3D Touch)',
                  'ForcePress Start, Peak, Update, End',
                  _buildForcePressZone(colorScheme),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventLog(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      constraints: const BoxConstraints(maxHeight: 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Last events',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: _eventLog.isEmpty
                ? Text(
                    'Trigger gestures below…',
                    style: TextStyle(
                      fontSize: 11,
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _eventLog.length,
                    itemBuilder: (_, i) => Text(
                      _eventLog[i],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    ThemeData theme,
    String title,
    String subtitle,
    Widget child,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildTapZone(ColorScheme colorScheme) {
    return GestureDetector(
      onTapDown: (d) => _log('Tap Down'),
      onTapUp: (d) => _log('Tap Up'),
      onTapCancel: () => _log('Tap Cancel'),
      onTap: () => _log('Tap'),
      child: _zone(
        colorScheme,
        'Tap here',
        colorScheme.primaryContainer,
      ),
    );
  }

  Widget _buildDoubleTapZone(ColorScheme colorScheme) {
    return GestureDetector(
      onDoubleTapDown: (d) => _log('DoubleTap Down'),
      onDoubleTapCancel: () => _log('DoubleTap Cancel'),
      onDoubleTap: () => _log('Double Tap'),
      child: _zone(
        colorScheme,
        'Double-tap here',
        colorScheme.secondaryContainer,
      ),
    );
  }

  Widget _buildLongPressZone(ColorScheme colorScheme) {
    return GestureDetector(
      onLongPressDown: (d) => _log('LongPress Down'),
      onLongPressCancel: () => _log('LongPress Cancel'),
      onLongPressStart: (d) => _log('LongPress Start'),
      onLongPressMoveUpdate: (d) => _log('LongPress MoveUpdate'),
      onLongPressUp: () => _log('LongPress Up'),
      onLongPressEnd: (d) => _log('LongPress End'),
      onLongPress: () => _log('Long Press'),
      child: _zone(
        colorScheme,
        'Long-press here',
        colorScheme.tertiaryContainer,
      ),
    );
  }

  Widget _buildSecondaryTertiaryZone(ColorScheme colorScheme) {
    return GestureDetector(
      onSecondaryTapDown: (d) => _log('SecondaryTap Down'),
      onSecondaryTapUp: (d) => _log('SecondaryTap Up'),
      onSecondaryTapCancel: () => _log('SecondaryTap Cancel'),
      onSecondaryTap: () => _log('Secondary Tap'),
      onTertiaryTapDown: (d) => _log('TertiaryTap Down'),
      onTertiaryTapUp: (d) => _log('TertiaryTap Up'),
      onTertiaryTapCancel: () => _log('TertiaryTap Cancel'),
      child: _zone(
        colorScheme,
        'Right-click / middle-click (or 2-finger tap)',
        colorScheme.surfaceContainerHighest,
      ),
    );
  }

  Widget _buildPanZone(ColorScheme colorScheme) {
    return GestureDetector(
      onPanDown: (d) => _log('Pan Down'),
      onPanStart: (d) => _log('Pan Start'),
      onPanUpdate: (d) {
        setState(() {
          _panX += d.delta.dx;
          _panY += d.delta.dy;
        });
        _log('Pan Update');
      },
      onPanEnd: (d) => _log('Pan End'),
      onPanCancel: () => _log('Pan Cancel'),
      child: _zone(
        colorScheme,
        'Drag freely • Δ(${_panX.toStringAsFixed(0)}, ${_panY.toStringAsFixed(0)})',
        colorScheme.primaryContainer.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildScaleZone(ColorScheme colorScheme) {
    return GestureDetector(
      onScaleStart: (d) => _log('Scale Start'),
      onScaleUpdate: (d) {
        setState(() {
          _scale *= d.scale;
          _rotation += d.rotation;
        });
        _log('Scale Update');
      },
      onScaleEnd: (d) => _log('Scale End'),
      child: _zone(
        colorScheme,
        'Pinch / rotate • scale: ${_scale.toStringAsFixed(2)}',
        colorScheme.secondaryContainer.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildVerticalDragZone(ColorScheme colorScheme) {
    return GestureDetector(
      onVerticalDragDown: (d) => _log('VerticalDrag Down'),
      onVerticalDragStart: (d) => _log('VerticalDrag Start'),
      onVerticalDragUpdate: (d) {
        setState(() => _verticalDragOffset += d.delta.dy);
        _log('VerticalDrag Update');
      },
      onVerticalDragEnd: (d) => _log('VerticalDrag End'),
      onVerticalDragCancel: () => _log('VerticalDrag Cancel'),
      child: _zone(
        colorScheme,
        'Drag up/down • offset: ${_verticalDragOffset.toStringAsFixed(0)}',
        colorScheme.tertiaryContainer.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildHorizontalDragZone(ColorScheme colorScheme) {
    return GestureDetector(
      onHorizontalDragDown: (d) => _log('HorizontalDrag Down'),
      onHorizontalDragStart: (d) => _log('HorizontalDrag Start'),
      onHorizontalDragUpdate: (d) {
        setState(() => _horizontalDragOffset += d.delta.dx);
        _log('HorizontalDrag Update');
      },
      onHorizontalDragEnd: (d) => _log('HorizontalDrag End'),
      onHorizontalDragCancel: () => _log('HorizontalDrag Cancel'),
      child: _zone(
        colorScheme,
        'Drag left/right • offset: ${_horizontalDragOffset.toStringAsFixed(0)}',
        colorScheme.surfaceContainerHighest,
      ),
    );
  }

  Widget _buildForcePressZone(ColorScheme colorScheme) {
    return GestureDetector(
      onForcePressStart: (d) => _log('ForcePress Start'),
      onForcePressPeak: (d) => _log('ForcePress Peak'),
      onForcePressUpdate: (d) => _log('ForcePress Update'),
      onForcePressEnd: (d) => _log('ForcePress End'),
      child: _zone(
        colorScheme,
        'Force press (3D Touch, if supported)',
        colorScheme.errorContainer.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _zone(ColorScheme colorScheme, String label, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
