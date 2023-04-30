mesaj='merhaba'
print(mesaj.lower())



print(mesaj.startswith("mef")) #Burada sorgulama yapıyoruz başlama sorgulaması
print(len(mesaj)) # Mesajın  uzunlugunu bize veriyor


ad_soyad='Yasin'
yas='25'

print('{} kişisi {} yaşında'.format(ad_soyad,yas)) # Buradaa format ile süsülü parantezleri doldurmayı öğreniyoruz
print(f'{ad_soyad} kişisi aslında {yas} yaşında')

sayilar=[1,25,2,35,558,6,8]


siralanmis_sayilar = sorted(sayilar, reverse=True)

print(siralanmis_sayilar)