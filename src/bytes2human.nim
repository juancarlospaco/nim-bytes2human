#!/usr/bin/nim c -r

import strformat
import json
import pylib


type HumanFriendlyByteUnits = tuple[
  bite: int64, kilo: int64, mega: int64, giga: int64,
  tera: int64, peta: int64, exa: int64, zetta: int64, yotta: int64]
type HumanBytes = tuple[human: string, auto: string,
                        units: HumanFriendlyByteUnits]


proc bytes2human(integer_bytes: int64): HumanBytes =
    ## Calculate Bytes, with precision from Bytes to Yottabytes.
    ## Calculate all Byte units from integer_bytes positive integer.
    assert integer_bytes >= 0, "Invalid value for integer_bytes, is Negative!."
    let kilo = int64(integer_bytes / 1_024)
    let mega = int64(kilo / 1_024)
    let giga = int64(mega / 1_024)
    let tera = int64(giga / 1_024)
    let peta = int64(tera / 1_024)
    let exa  = int64(peta / 1_024)
    let zetta = int64(exa / 1_024)
    let yotta = int64(zetta / 1_024)

    # Build a namedtuple with all named bytes units and all its integer values.
    let bytes_units: HumanFriendlyByteUnits = (
      bite: integer_bytes, kilo: kilo, mega: mega, giga: giga,
      tera: tera, peta: peta, exa: exa, zetta: zetta, yotta: yotta)

    # Build a human friendly bytes string with frequent bytes units.
    var bytes_parts: seq[string]
    var human_bytes_auto = ""
    var this_byte_unit = ""
    if yotta:
        this_byte_unit = fmt"{yotta} Yottabytes"
        if not human_bytes_auto:
            human_bytes_auto = this_byte_unit
        bytes_parts.add(this_byte_unit)
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
        human_bytes_auto = fmt"{integer_bytes} Bytes"
    bytes_parts.add(fmt"{integer_bytes} Bytes")

    let r: HumanBytes = (human: " ".join(bytes_parts), auto: human_bytes_auto,
                         units: bytes_units)
    result = r


if is_main_module:
  echo bytes2human(2398345659434540923)  # 2 Exabytes.
  echo bytes2human(1)                    # 1 Byte.
  echo bytes2human(1)                    # 0 Byte.
