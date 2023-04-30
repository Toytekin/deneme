renkler=['Sarı','Mavi','Yeşil','Siyah','Beyaz','Turuncu']

# print(type(renkler))  type() => fonksiyonu içerisine verdiğimiz  değişkenin türünü bulmamızı sağlar
# print(len(renkler))           # len() => fonksiyonu listemizin uzunluğunu verir
# print(renkler[1])             #  1. indexdeki eleman olan Mavi 'yi verir
# print(renkler[1:])            # 1. indexden itibaren tüm verileri getirir Mavi,Yaşil,Siyah,Beyaz,Turuncu
# print(renkler[2:4])           # 2. indexden 4. indexe kadar olan verileri getirir (4 dahil değil) 
# print(renkler[:4])            # 4.indexe kadar yazar. (4 dahil değil)  
# print(renkler[::2])           # listem 2 şer 2 şer ilerleyecek (0,2,4) indexler gelecek 
# print(renkler[1:4:2])         # listem 2 şer 2 şer ilerleyecek (1,3) indexler gelecek (4 dahil değil)

#  LİSTEDE DEĞİŞİKLİK YAPAN KOMUTLAR
 
# print(renkler)
# renkler.append('Gri')  # Listenin sonuına bir eleman eklemek için kullanılır

# print(renkler)
# renkler.insert(2,'Mor')# 2. indexin olduğu yere Mor elemanının ekler

# print(renkler) 
# renkler.remove('Sarı') # Sarı elemanının listeden siler

# print(renkler)

# renkler2=['araMor', 'araSarı']
# renkler.extend(renkler2) # renkler2 deki elemanları renkler listeme ekler
# print(renkler)

# silinen=renkler.pop()  # listedeki son elemanı siler ve onu geri gönderir
# print(silinen)
# print(renkler)

# renkler.reverse()      # Listeyi ters çevirir
# print(renkler)

# renkler.sort()         # listemizi büyükten küçüğe doğru sıralar
# print(renkler)

# siralanmisListe=sorted(renkler) # listemi sıralayıp değişkene atıyoruz. Üstekinden farkı listemizin yapısı değişmemiş olacak
# print(siralanmisListe)

sayilar=[5,13,9,41,2,6,7,89,1]
# print(min(sayilar)) # min() fonksiyonu listedeki en küçük sayıyı verir 
# print(max(sayilar)) # max() fonksiyonu listedeki en büyük sayıyı verir 
# print(min(renkler)) # min()f. listede alfabetik olarak ilk geleni verir
# print(max(renkler)) # max()f. listede alfabetik olarak son geleni verir

# print(sum(sayilar)) # listedeki tüm elemanları toplar



# for renk in renkler:             # for döngü kullanımı
#     print(renk)


# print(list(enumerate(renkler)))  # listemizi numaralandırarak bize verir

# varmiYokmu='Siyah' in renkler    # liste içerisinde sorgulama yapma tru yada false döndürürü
# print(varmiYokmu)

stringList=','.join(renkler) # listemdeki tüm elemanları tek bir String'e çevirir
print(stringList)

listeyeAtma=stringList.split(',')   # string bir ifadeyi istediğimiz karakterlerden itibaren bölerek bir liste oluşturur
print(listeyeAtma)





















