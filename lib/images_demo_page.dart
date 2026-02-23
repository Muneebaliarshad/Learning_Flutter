import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ImagesDemoPage extends StatefulWidget {
  const ImagesDemoPage({super.key});

  @override
  State<ImagesDemoPage> createState() => _ImagesDemoPageState();
}

class _ImagesDemoPageState extends State<ImagesDemoPage> {
  static const String _assetPath = 'assets/images/placeholder.jpg';
  static const String _networkUrl = 'https://picsum.photos/500/500';

  File? _demoFile;
  Uint8List? _memoryImageBytes;
  bool _fileReady = false;

  @override
  void initState() {
    super.initState();
    _prepareFileAndMemoryImages();
  }

  Future<void> _prepareFileAndMemoryImages() async {
    try {
      final byteData = await rootBundle.load(_assetPath);
      final bytes = byteData.buffer.asUint8List();

      setState(() {
        _memoryImageBytes = bytes;
      });

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/demo_placeholder.png');
      await file.writeAsBytes(bytes);

      if (mounted) {
        setState(() {
          _demoFile = file;
          _fileReady = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _fileReady = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Images Demo'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            theme,
            '1. Image.asset()',
            'Image bundled in the app (pubspec → assets)',
            _buildAssetImage(colorScheme),
          ),
          _buildSection(
            theme,
            '2. Image.network()',
            'Image loaded from a URL (with loading & error)',
            _buildNetworkImage(colorScheme),
          ),
          _buildSection(
            theme,
            '3. Image.file()',
            'Image from device filesystem (e.g. camera/gallery)',
            _buildFileImage(colorScheme),
          ),
          _buildSection(
            theme,
            '4. Image.memory()',
            'Image from in-memory bytes (Uint8List)',
            _buildMemoryImage(colorScheme),
          ),
          _buildSection(
            theme,
            '5. Image with ImageProvider',
            'Using Image(image: AssetImage(...))',
            _buildImageWithProvider(colorScheme),
          ),
          _buildSection(
            theme,
            '6. DecorationImage',
            'Image as background (e.g. in Container)',
            _buildDecorationImage(colorScheme),
          ),
          _buildSection(
            theme,
            '7. FadeInImage',
            'Placeholder until image loads (asset → network)',
            _buildFadeInImage(colorScheme),
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
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildImageFrame(
    ColorScheme colorScheme,
    Widget child, {
    double height = 140,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _buildAssetImage(ColorScheme colorScheme) {
    return _buildImageFrame(
      colorScheme,
      Image.asset(
        _assetPath,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.broken_image, size: 48, color: colorScheme.error),
      ),
    );
  }

  Widget _buildNetworkImage(ColorScheme colorScheme) {
    return _buildImageFrame(
      colorScheme,
      Image.network(
        _networkUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 48, color: colorScheme.error),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Network error\n($error)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileImage(ColorScheme colorScheme) {
    if (!_fileReady || _demoFile == null) {
      return _buildImageFrame(
        colorScheme,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(height: 8),
            Text(
              'Preparing file...',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return _buildImageFrame(
      colorScheme,
      Image.file(
        _demoFile!,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.broken_image, size: 48, color: colorScheme.error),
      ),
    );
  }

  Widget _buildMemoryImage(ColorScheme colorScheme) {
    if (_memoryImageBytes == null) {
      return _buildImageFrame(
        colorScheme,
        Text(
          'Loading bytes...',
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
      );
    }

    return _buildImageFrame(
      colorScheme,
      Image.memory(
        _memoryImageBytes!,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.broken_image, size: 48, color: colorScheme.error),
      ),
    );
  }

  Widget _buildImageWithProvider(ColorScheme colorScheme) {
    return _buildImageFrame(
      colorScheme,
      Image(
        image: AssetImage(_assetPath),
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.broken_image, size: 48, color: colorScheme.error),
      ),
    );
  }

  Widget _buildDecorationImage(ColorScheme colorScheme) {
    return _buildImageFrame(
      colorScheme,
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(_networkUrl),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {},
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'DecorationImage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFadeInImage(ColorScheme colorScheme) {
    return _buildImageFrame(
      colorScheme,
      FadeInImage(
        placeholder: AssetImage(_assetPath),
        image: NetworkImage(_networkUrl),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholderErrorBuilder: (_, __, ___) => Icon(
          Icons.image_not_supported,
          size: 48,
          color: colorScheme.outline,
        ),
        imageErrorBuilder: (_, __, ___) =>
            Icon(Icons.wifi_off, size: 48, color: colorScheme.error),
      ),
    );
  }
}
