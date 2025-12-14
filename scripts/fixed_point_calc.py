# fixed_point_calc.py : tiny helper for Q1.15 conversions (education)
def q15_from_float(x: float) -> int:
    if x > 0.999969: x = 0.999969
    if x < -1.0:     x = -1.0
    return int(round(x * 32768.0))

def float_from_q15(v: int) -> float:
    # interpret signed 16-bit
    if v & 0x8000:
        v = v - 0x10000
    return v / 32768.0

if __name__ == "__main__":
    for x in [0.0, 0.1, 0.5, 0.9, -0.25]:
        q = q15_from_float(x)
        print(x, hex(q & 0xFFFF), float_from_q15(q & 0xFFFF))
