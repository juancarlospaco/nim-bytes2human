import strformat, json, strutils


type HumanFriendlyByteUnits* = tuple[
  bite: int64, kilo: int64, mega: int64, giga: int64,
  tera: int64, peta: int64, exa: int64, zetta: int64]  ## Tuple of Human Friendly Byte Units.

type HumanBytes* = tuple[human: string, short: string,
                        units: HumanFriendlyByteUnits] ## Tuple of Human Friendly Byte Units as Strings.


func divmod(a, b: SomeInteger): array[0..1, int] {.inline.} =
  [int(int(a) / int(b)), int(a mod b)]


func bytes2human*(integer_bytes: int64): HumanBytes =
    ## Calculate Bytes, with precision from Bytes to Yottabytes.
    ## Calculate all Byte units from integer_bytes positive integer.
    assert integer_bytes >= 0, "Invalid Negative value for integer_bytes!."
    var bite: int64
    var kilo: int64
    var mega: int64
    var giga: int64
    var tera: int64
    var peta: int64
    var exa: int64
    var zetta: int64
    var yotta: int64

    (kilo, bite) = divmod(integer_bytes, int64(1_024))
    (mega, kilo) = divmod(kilo, int64(1_024))
    (giga, mega) = divmod(mega, int64(1_024))
    (tera, giga) = divmod(giga, int64(1_024))
    (peta, tera) = divmod(tera, int64(1_024))
    (exa, peta) = divmod(peta, int64(1_024))
    (zetta, exa) = divmod(exa, int64(1_024))
    (yotta, zetta) = divmod(zetta, int64(1_024))

    # Build a namedtuple with all named bytes units and all its integer values.
    let bytes_units: HumanFriendlyByteUnits = (
      bite: bite, kilo: kilo, mega: mega, giga: giga,
      tera: tera, peta: peta, exa: exa, zetta: zetta)

    # Build a human friendly bytes string with frequent bytes units.
    var bytes_parts: seq[string] = @[""]
    var human_bytes_short = ""
    var this_byte_unit = ""
    if zetta > 0:
        this_byte_unit = fmt"{zetta} Zettabytes"
        if not human_bytes_short.len.bool:
            human_bytes_short = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if exa > 0:
        this_byte_unit = fmt"{exa} Exabytes"
        if not human_bytes_short.len.bool:
            human_bytes_short = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if peta > 0:
        this_byte_unit = fmt"{peta} Petabytes"
        if not human_bytes_short.len.bool:
            human_bytes_short = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if tera > 0:
        this_byte_unit = fmt"{tera} Terabytes"
        if not human_bytes_short.len.bool:
            human_bytes_short = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if giga > 0:
        this_byte_unit = fmt"{giga} Gigabytes"
        if not human_bytes_short.len.bool:
            human_bytes_short = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if mega > 0:
        this_byte_unit = fmt"{mega} Megabytes"
        if not human_bytes_short.len.bool:
            human_bytes_short = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if kilo > 0:
        this_byte_unit = fmt"{kilo} Kilobytes"
        if not human_bytes_short.len.bool:
            human_bytes_short = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if not human_bytes_short.len.bool:
        human_bytes_short = fmt"{bite} Bytes"
    bytes_parts.add(fmt"{bite} Bytes")

    let r: HumanBytes = (human: bytes_parts.join" ", short: human_bytes_short,
                         units: bytes_units)
    result = r


when isMainModule:
  #runnableExamples:
  echo bytes2human(2398345659434540923)  # 2 Exabytes.
  echo bytes2human(1027)                 # 1 Byte.
  echo bytes2human(666)
  echo bytes2human(0)                    # 0 Byte.
