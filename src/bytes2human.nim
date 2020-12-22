type HumanFriendlyByteUnits* = tuple[
  bite: int64, kilo: int64, mega: int64, giga: int64,
  tera: int64, peta: int64, exa: int64, zetta: int64]  ## Tuple of Human Friendly Byte Units.

type HumanBytes* = tuple[human: string, short: string,
                        units: HumanFriendlyByteUnits] ## Tuple of Human Friendly Byte Units as Strings.


template divmod(a, b: SomeInteger): array[2, int] =
  [int(int(a) / int(b)), int(a mod b)]


template wordsToCap(wordCount: static[Positive]): static[int] =
  ## Average length of words, World 9, English 6 (Wikipedia, Wolfram, Oxford).
  ## (9*wordCount)+(whitespace*wordCount) http://ravi.io/language-word-lengths
  (9 * wordCount) + wordCount  # Still better than a random guess.


template abytes(stringy: var string; unit: static[string]) =
  stringy.add ' '
  when len(unit) > 0:
    stringy.add unit # "SOMETHINGbytes"
    stringy.add 'b'
  else:
    stringy.add 'B'  # Just "Bytes"
  stringy.add 'y'
  stringy.add 't'
  stringy.add 'e'
  stringy.add 's'


func join(a: array[8, string]): string {.inline, noinit.} =
  result = newStringOfCap( # 7 times " " + 8 times len(string)
    7 + a[0].len + a[1].len + a[2].len + a[3].len + a[4].len + a[5].len + a[6].len + a[7].len)
  if a[0].len > 0: result.add a[0] & ' '
  if a[1].len > 0: result.add a[1] & ' '
  if a[2].len > 0: result.add a[2] & ' '
  if a[3].len > 0: result.add a[3] & ' '
  if a[4].len > 0: result.add a[4] & ' '
  if a[5].len > 0: result.add a[5] & ' '
  if a[6].len > 0: result.add a[6] & ' '
  if a[7].len > 0: result.add a[7]


func bytes2human*(integer_bytes: int64): HumanBytes =
  ## Calculate Bytes, with precision from Bytes to Yottabytes.
  ## Calculate all Byte units from integer_bytes positive integer.
  assert integer_bytes >= 0, "Invalid Negative value for integer_bytes."

  var bite, kilo, mega, giga, tera, peta, exa, zetta, yotta {.noinit.}: int64
  (kilo, bite) = divmod(integer_bytes, int64(1_024))
  (mega, kilo) = divmod(kilo, int64(1_024))
  (giga, mega) = divmod(mega, int64(1_024))
  (tera, giga) = divmod(giga, int64(1_024))
  (peta, tera) = divmod(tera, int64(1_024))
  (exa, peta) = divmod(peta, int64(1_024))
  (zetta, exa) = divmod(exa, int64(1_024))
  (yotta, zetta) = divmod(zetta, int64(1_024))

  # Build a human friendly bytes string with frequent bytes units.
  var bytesParts: array[8, string]
  var humanBytesShort = newStringOfCap(wordsToCap(2))
  var thisByteUnit = newStringOfCap(wordsToCap(16)) # 8 * 2
  if unlikely(zetta > 0):
    thisByteUnit = $zetta
    abytes(thisByteUnit, "Zetta")
    if humanBytesShort.len == 0:
      humanBytesShort = thisByteUnit
    bytesParts[0] = thisByteUnit
  if unlikely(exa > 0):
    thisByteUnit = $exa
    abytes(thisByteUnit, "Exa")
    if humanBytesShort.len == 0:
      humanBytesShort = thisByteUnit
    bytesParts[1] = thisByteUnit
  if unlikely(peta > 0):
    thisByteUnit = $peta
    abytes(thisByteUnit, "Peta")
    if humanBytesShort.len == 0:
      humanBytesShort = thisByteUnit
    bytesParts[2] = thisByteUnit
  if tera > 0:
    thisByteUnit = $tera
    abytes(thisByteUnit, "Tera")
    if humanBytesShort.len == 0:
      humanBytesShort = thisByteUnit
    bytesParts[3] = thisByteUnit
  if giga > 0:
    thisByteUnit = $giga
    abytes(thisByteUnit, "Giga")
    if humanBytesShort.len == 0:
      humanBytesShort = thisByteUnit
    bytesParts[4] = thisByteUnit
  if mega > 0:
    thisByteUnit = $mega
    abytes(thisByteUnit, "Mega")
    if humanBytesShort.len == 0:
      humanBytesShort = thisByteUnit
    bytesParts[5] = thisByteUnit
  if kilo > 0:
    thisByteUnit = $kilo
    abytes(thisByteUnit, "Kilo")
    if humanBytesShort.len == 0:
      humanBytesShort = thisByteUnit
    bytesParts[6] = thisByteUnit
  if humanBytesShort.len == 0:
    humanBytesShort = $bite
    abytes(humanBytesShort, "")
  bytesParts[7] = $bite
  abytes(bytesParts[7], "")

  # The only way to make a Tuple Type without any extra temporary variable is cast
  result = cast[HumanBytes]((human: bytesParts.join, short: humanBytesShort,
    # Build a namedtuple with all named bytes units and all its integer values.
    units: cast[HumanFriendlyByteUnits]((
      bite: bite, kilo: kilo, mega: mega, giga: giga,
      tera: tera, peta: peta, exa: exa, zetta: zetta
    ))
  ))


when isMainModule:
  #runnableExamples:
  when not defined(js):
    echo bytes2human(2398345659434540923) # 2 Exabytes.
  echo bytes2human(1027)                  # 1 Byte.
  echo bytes2human(1024)                  # 1 Byte.
  echo bytes2human(666)
  echo bytes2human(0)                     # 0 Byte.
  echo bytes2human(1)
