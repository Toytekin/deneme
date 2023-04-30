total = 0

for i in range(1, 1000):
    if i % 3 == 0 or i % 5 == 0:
        total += i


#
a = float(input("1. Sayıyı girin: "))
b = float(input("2. Sayıyı girin: "))
c = float(input("3. Sayıyı girin: "))

if a > b:
    a, b = b, a
if a > c:
    a, c = c, a
if b > c:
    b, c = c, b

print("Girilen sayıların büyükten küçüğe sıralanmış hali: ", c, b, a)
