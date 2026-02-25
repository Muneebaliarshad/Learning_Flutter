import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Country {
  final String countryName;
  final String flag;
  final String capital;

  const Country({
    required this.countryName,
    required this.flag,
    required this.capital,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryName: json['countryName'] as String,
      flag: json['flag'] as String,
      capital: json['capital'] as String,
    );
  }
}

class LocalJsonPage extends StatefulWidget {
  const LocalJsonPage({super.key});

  @override
  State<LocalJsonPage> createState() => _LocalJsonPageState();
}

class _LocalJsonPageState extends State<LocalJsonPage> {
  late Future<List<Country>> _countriesFuture;

  @override
  void initState() {
    super.initState();
    _countriesFuture = _loadCountries();
  }

  Future<List<Country>> _loadCountries() async {
    final jsonString =
        await rootBundle.loadString('assets/data/country.json');
    final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
    return decoded
        .map((e) => Country.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local JSON (Countries)'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Country>>(
        future: _countriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error loading JSON:\\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              ),
            );
          }

          final countries = snapshot.data ?? [];
          if (countries.isEmpty) {
            return const Center(
              child: Text('No countries found in JSON.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: countries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final country = countries[index];
              return Card(
                child: ListTile(
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 28),
                  ),
                  title: Text(
                    country.countryName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Capital: ${country.capital}',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

