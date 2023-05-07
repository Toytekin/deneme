# Text Field Kullanımı Ve Notlar



controller => controller ile girilen inputu kontrol ediyorsun


# decoration

Genel olarak dekorasyonun tamamı buradan yapılır

# border: ==  genel olarak kullan
# focusedBorder: == tiklandığında border değşikilikeliri için kullan

  +OutlineInputBorder => Çerçeve verir
     + borderRadius: BorderRadius.all(Radius.circular(12))) => Çerçevenin köşesini yuvarlar
     + borderSide: çerçeve kalınlığı ve rengini ayarla   

 +  constraints: textfildın genişliğini yüksekliğini ayarla
 +  contentPadding: iç boşluk
 +  fillColor: Bununla textfildımızın içini bir renk ile doldurabiliriz ama   filled: True yapmak zorundasyız
 +  label: textfildımızın üstunde kısa bilgi verir. Genelde sol üst köşededir. Bunu değiştirmek istiyosan  << floatingLabelAlignment: FloatingLabelAlignment.center >> kullan.
 +   floatingLabelStyle: TextStyle(color: Colors.purple, fontSize: 20)), labelin stilini belirliyorz
 + keyboardType: tıklanınca açılacak klavyenin tipini belirliyo
 
       
        


