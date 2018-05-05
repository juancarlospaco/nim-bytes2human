#!/usr/bin/nim c -r

import strformat
import json
import pylib


type HumanFriendlyByteUnits = tuple[
  bite: int64, kilo: int64, mega: int64, giga: int64,
  tera: int64, peta: int64, exa: int64, zetta: int64]
type HumanBytes = tuple[human: string, auto: string,
                        units: HumanFriendlyByteUnits]


# proc divmod(a: int, b: int):     array[0..1, int]   = [int(a / b), int(a mod b)]
# proc divmod(a: int8, b: int8):   array[0..1, int8]  = [int8(a / b), int8(a mod b)]
# proc divmod(a: int16, b: int16): array[0..1, int16] = [int16(a / b), int16(a mod b)]
# proc divmod(a: int32, b: int32): array[0..1, int32] = [int32(a / b), int32(a mod b)]
proc divmod(a: int64, b: int64): array[0..1, int64] = [int64(a / b), int64(a mod b)]


proc bytes2human*(integer_bytes: int64): HumanBytes =
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
    var bytes_parts: seq[string]
    var human_bytes_auto = ""
    var this_byte_unit = ""
    if zetta:
        this_byte_unit = fmt"{zetta} Zettabytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if exa:
        this_byte_unit = fmt"{exa} Exabytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if peta:
        this_byte_unit = fmt"{peta} Petabytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if tera:
        this_byte_unit = fmt"{tera} Terabytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if giga:
        this_byte_unit = fmt"{giga} Gigabytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if mega:
        this_byte_unit = fmt"{mega} Megabytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if kilo:
        this_byte_unit = fmt"{kilo} Kilobytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
    if not human_bytes_auto:
        human_bytes_auto = fmt"{bite} Bytes"
    bytes_parts.add(fmt"{bite} Bytes")

    let r: HumanBytes = (human: " ".join(bytes_parts), auto: human_bytes_auto,
                         units: bytes_units)
    result = r


if is_main_module:
  echo bytes2human(2398345659434540923)  # 2 Exabytes.
  echo bytes2human(1027)                    # 1 Byte.
  echo bytes2human(0)                    # 0 Byte.
