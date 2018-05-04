# nim-bytes2human

Calculate all Byte units from integer bytes positive int64,
with precision from Bytes to Yottabytes, and return a human friendly string representation.


![screenshot](https://source.unsplash.com/wloRJGS6Y34/800x402 "Illustrative Photo by https://unsplash.com/@florian_perennes")


# Use

```nim
>>> import bytes2human
echo bytes2human(2398345659434540923)  # 2 Exabytes.
(human: "2 Exabytes 2130 Petabytes 2181282 Terabytes 2233633454 Gigabytes 2287240657267 Megabytes 2342134433041544 Kilobytes 2398345659434540923 Bytes", auto: "2 Exabytes", units: (bite: 2398345659434540923, kilo: 2342134433041544, mega: 2287240657267, giga: 2233633454, tera: 2181282, peta: 2130, exa: 2, zetta: 0, yotta: 0))
>>> echo bytes2human(1)  # 1 Byte.
(human: "1 Bytes", auto: "1 Bytes", units: (bite: 1, kilo: 0, mega: 0, giga: 0, tera: 0, peta: 0, exa: 0, zetta: 0, yotta: 0))
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
