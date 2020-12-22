type HumanFriendlyByteUnits* = tuple[
  bite: int64, kilo: int64, mega: int64, giga: int64,
  tera: int64, peta: int64, exa: int64, zetta: int64]  ## Tuple of Human Friendly Byte Units.

type HumanBytes* = tuple[human: string, short: string,
                        units: HumanFriendlyByteUnits] ## Tuple of Human Friendly Byte Units as Strings.


template divmod(a, b: SomeInteger): array[0..1, int] =
  [int(int(a) / int(b)), int(a mod b)]


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
  var bytes_parts: array[8, string]
  var human_bytes_short = ""
  var this_byte_unit = ""
  if unlikely(zetta > 0):
    this_byte_unit = $zetta
    this_byte_unit.add " Zettabytes"
    if human_bytes_short.len == 0:
      human_bytes_short = this_byte_unit
    bytes_parts[0] = this_byte_unit
  if unlikely(exa > 0):
    this_byte_unit = $exa
    this_byte_unit.add " Exabytes"
    if human_bytes_short.len == 0:
      human_bytes_short = this_byte_unit
    bytes_parts[1] = this_byte_unit
  if unlikely(peta > 0):
    this_byte_unit = $peta
    this_byte_unit.add " Petabytes"
    if human_bytes_short.len == 0:
      human_bytes_short = this_byte_unit
    bytes_parts[2] = this_byte_unit
  if tera > 0:
    this_byte_unit = $tera
    this_byte_unit.add " Terabytes"
    if human_bytes_short.len == 0:
      human_bytes_short = this_byte_unit
    bytes_parts[3] = this_byte_unit
  if giga > 0:
    this_byte_unit = $giga
    this_byte_unit.add " Gigabytes"
    if human_bytes_short.len == 0:
      human_bytes_short = this_byte_unit
    bytes_parts[4] = this_byte_unit
  if mega > 0:
    this_byte_unit = $mega
    this_byte_unit.add " Megabytes"
    if human_bytes_short.len == 0:
      human_bytes_short = this_byte_unit
    bytes_parts[5] = this_byte_unit
  if kilo > 0:
    this_byte_unit = $kilo
    this_byte_unit.add " Kilobytes"
    if human_bytes_short.len == 0:
      human_bytes_short = this_byte_unit
    bytes_parts[6] = this_byte_unit
  if human_bytes_short.len == 0:
    human_bytes_short = $bite
    human_bytes_short.add " Bytes"
  bytes_parts[7] = $bite & " Bytes"

  # The only way to make a Tuple Type without any extra temporary variable is cast
  result = cast[HumanBytes]((human: bytes_parts.join, short: human_bytes_short,
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
