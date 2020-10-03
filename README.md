# nim-bytes2human

Calculate all Byte units from integer bytes positive `int64`,
with precision from Bytes to Yottabytes, and return a human friendly string representation.
Works with `--gc:arc`, `--gc:orc`, `--panics:on`, `--experimental:strictFuncs`, C, C++, JavaScript.
Uses `system.nim` only, does not import anything from stdlib.

![screenshot](https://source.unsplash.com/wloRJGS6Y34/800x402 "Illustrative Photo by https://unsplash.com/@florian_perennes")


# Use

```nim
>>> import bytes2human
>>> echo bytes2human(2398345659434540923)  # 2 Exabytes.
(human: "2 Exabytes 82 Petabytes 162 Terabytes 686 Gigabytes 371 Megabytes 136 Kilobytes 891 Bytes", short: "2 Exabytes", units: (bite: 891, kilo: 136, mega: 371, giga: 686, tera: 162, peta: 82, exa: 2, zetta: 0))
>>> echo bytes2human(1027) # 1 Kilobytes.
(human: "1 Kilobytes 3 Bytes", short: "1 Kilobytes", units: (bite: 3, kilo: 1, mega: 0, giga: 0, tera: 0, peta: 0, exa: 0, zetta: 0))
>>> echo bytes2human(0)  # 0 Byte.
(human: "0 Bytes", short: "0 Bytes", units: (bite: 0, kilo: 0, mega: 0, giga: 0, tera: 0, peta: 0, exa: 0, zetta: 0))
>>> echo bytes2human(-666)  # Invalid!.
Error: unhandled exception: 0 <= integer_bytes Invalid Negative value for integer_bytes!. [AssertionError]
>>>
```


# Install

```
nimble install bytes2human
```


# Requisites

- [Nim](https://nim-lang.org)


# Documentation

<details>
    <summary><b>bytes2human()</b></summary>

**Description:**
Calculate Bytes, with precision from Bytes to Yottabytes.
Calculate all Byte units from integer_bytes positive integer.
The proc only accepts `int64`.

**Arguments:**
- `integer_bytes` Bytes size, positive `int64` type, required.

**Returns:** `HumanBytes` type, a tuple.

</details>
