// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:args/args.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode/src/barcode_1d.dart';
import 'package:barcode/src/qrcode.dart';
import 'package:quiver/iterables.dart';

final _parser = ArgParser()
  ..addFlag(
    'help',
    abbr: 'h',
    negatable: false,
    help: 'Shows this help message.',
  )
  ..addFlag(
    'version',
    abbr: 'v',
    negatable: false,
    help: 'Shows the current version.',
  )
  ..addOption(
    'type',
    abbr: 't',
    defaultsTo: '128',
    help: 'Options: 128, qr.',
  )
  ..addOption(
    'height',
    abbr: 'y',
    defaultsTo: '8',
    help: 'Height for 1D barcodes.',
  );

void main(List<String> aargs) {
  final args = _parser.parse(aargs);
  if (args['help'] as bool) {
    print(_parser.usage);
    return;
  }
  if (args['version'] as bool) {
    print('barcoder 0.0.1');
    return;
  }
  final data = args.rest.first;
  final type = args['type'] as String;
  final height = int.parse(args['height']);
  final output = switch (type) {
    '128' => _barcode128(data, height: height),
    'qr' => _qr(data),
    _ => 'Unknown type: $type',
  };
  print(output);
}

String _pixel(bool pixel) => pixel ? '█' : ' ';

String _barcode128(String data, {int height = 8}) {
  final line =
      (Barcode.code128() as Barcode1D).convert(data).map(_pixel).join();
  return List.filled(height, line).join('\n');
}

String _qr(String data) {
  final qr =
      (Barcode.qrCode() as BarcodeQR).convert(utf8.encoder.convert(data));
  final rows = partition(qr.pixels, qr.width);
  final pixels = [
    for (final row in rows) row.map((e) => e ? '█' : ' ').join(),
  ];
  return pixels.join('\n');
}
