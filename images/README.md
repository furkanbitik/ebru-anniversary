# Fotoğraflar — `images/` klasörü

Site iki yerde fotoğraf kullanır:

1. **Ana sayfa** (`index.html`) — "Donmuş Anlar" galerisinde **en güzel 10 kare**.
2. **Anılar sayfası** (`anilar.html`) — **tüm 68 fotoğraf** tek bir grid içinde.

Dosyaları bu klasöre at, isimleri aşağıdaki kurala göre olsun, site otomatik olarak yükler.

---

## 1. Dosya isimleri

| Slot                              | Dosya adı                                | Not                                  |
| --------------------------------- | ---------------------------------------- | ------------------------------------ |
| Ana sayfa kahramanı (hero)        | `photo-29.jpeg` *(şu an seçili)*         | Hangi numarayı istersen onu kullan.  |
| Ana sayfa galerisi — 10 kare      | `photo-1.jpeg` … `photo-10.jpeg`         | Sıralama önemli; her birinin kendi tile şekli var. |
| Anılar sayfası — tüm fotoğraflar  | `photo-1.jpeg` … `photo-68.jpeg`         | 68 dosyanın tamamı.                  |

**Kurallar**

- Uzantı **`.jpeg`** (küçük harf). `.jpg` değil — `.jpeg`.
- Boşluk kullanma: `photo-1.jpeg` ✓, `photo 1.jpeg` ✗.
- Numara sırası önemli: ana sayfadaki en güzel 10'u `photo-1.jpeg` – `photo-10.jpeg` olarak adlandır; gerisi 11–68.
- Hero fotoğrafını değiştirmek için: `index.html` içinde `<section id="hero">` bloğundaki `<img src="images/photo-29.jpeg" …>` satırında numarayı değiştir.

---

## 2. Tavsiye edilen boyutlar

Her fotoğraf, oturduğu tile'ın şekline uyarsa galeri en güzel görünür. Tile şekilleri:

| Tile şekli (CSS sınıfı)        | İdeal boyut         | En–boy oranı | Hangi fotoğraflar (ana sayfada)      |
| ------------------------------ | ------------------- | ------------ | ------------------------------------ |
| Standart (sınıf yok)           | 1200 × 800 (yatay)  | 3 : 2        | `photo-2`, `photo-3`, `photo-6`, `photo-7`, `photo-10` |
| `tile--tall` (uzun portre)     | 800 × 1200 (dikey)  | 2 : 3        | `photo-1`, `photo-5`, `photo-8`      |
| `tile--wide` (panorama)        | 1600 × 900 (yatay)  | 16 : 9       | `photo-4`, `photo-9`                 |

Anılar sayfasında (`anilar.html`) tüm 68 fotoğraf otomatik bir ritimle yerleştirilir — her 6. fotoğraf uzun, her 6. (offset 3) fotoğraf geniş olur. Bu yüzden anılar sayfasında boyut çok kritik değil; **kare ve yatay fotoğraflar** genelde en iyi sonucu verir.

**İpuçları**

- Fotoğraflar `object-fit: cover` ile kırpıldığı için yüzleri merkezde tut.
- Her dosyayı **500 KB altında** tut (68 fotoğraf × büyük dosya = mobilde yavaş yükleme). [Squoosh](https://squoosh.app) veya `tinypng.com` ile sıkıştır.
- Anılar sayfası `loading="lazy"` kullanır — ekran dışındaki fotoğraflar kullanıcı kaydırana kadar yüklenmez. Yine de orijinal dosyaları küçültmek görüntü deneyimini hızlandırır.

---

## 3. Ana sayfada hangi 10 fotoğraf?

Şu an ana sayfada `photo-1.jpeg` – `photo-10.jpeg` gösteriliyor. **En güzel 10 fotoğrafı bu numaralara taşırsan** (yani favorilerini photo-1, 2, 3, …, 10 olarak adlandırırsan) ana sayfa otomatik olarak en güzel 10'u gösterir. Geri kalan 58 fotoğraf (11–68) hâlâ Anılar sayfasında görünür.

Alternatif: ana sayfadaki sıralamayı/numaraları değiştirmek istersen `index.html` içinde `<!-- ============ GALLERY ============ -->` bölümüne git, her `<img src="images/photo-N.jpeg">` satırını istediğin numarayla değiştir.

---

## 4. Anılar sayfasını büyütme / küçültme

`anilar.html` şu an **68** tile içeriyor. Bu sayıyı değiştirmek için:

- **Daha az fotoğraf** (örneğin 50): `anilar.html`'in alt kısmındaki `<main class="gallery-all">` içinden 51-68. tile'ları sil.
- **Daha fazla fotoğraf** (örneğin 80): Mevcut son tile'ı kopyala, numarayı artır:

  ```html
  <figure class="tile" data-num="69">
    <img loading="lazy" src="images/photo-69.jpeg" alt="Anı 69" />
  </figure>
  ```

  Görsel ritim için her 6. tile'ı `tile--tall`, her 6. tile'ı (offset 3) `tile--wide` yap.

---

## 5. Fotoğraf eksikse ne olur?

Site iki yerde de eksik fotoğrafa karşı naziktir:

- **Ana sayfa galerisi:** Bulunamayan her fotoğrafın yerine bordo zemin üzerinde **"F & E"** monogramı çıkar (`script.js` halleder).
- **Anılar sayfası:** Bulunamayan tile bordo gradyent zemine döner, lightbox tıklaması kapanır.

Yani tüm 68 fotoğrafı bir kerede atmadan da siteyi gezebilirsin; eksikleri sonra ekle.

---

## 6. Sonuç klasör yapısı

```
images/
├── README.md
├── photo-1.jpeg
├── photo-2.jpeg
├── photo-3.jpeg
│   ...
└── photo-68.jpeg
```

Bu kadar. Tarayıcıyı yenile — site her şeyi otomatik toplar.
