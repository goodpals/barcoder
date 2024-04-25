## Barcoder
Simple CLI barcode generation tool.

### Installation
- `brew install goodpals/goodpals/barcoder`

### Usage
`barcoder 1234` will generate a normal 128 barcode.
`barcoder -t qr 1234` for a QR.

### Why?
- Alex needed it for something at work
- Cal and Alex are doing an art thing with QR codes and this makes iteration faster
- CLIs are convenient

### Current issues
- Some barcode scanners don't work with light barcodes on dark backgrounds (looking at you, Dynamsoft), so you'll want a light terminal theme in those cases. There is the invert flag (`-i`) but it doesn't always work with Dynamsoft either.
- Works best when you have a font that respects the vertical spacing of block characters. [Inconsolata](https://github.com/googlefonts/Inconsolata) is nice. It isn't totally necessary, most scanners seem to still work without this but it looks nicer.