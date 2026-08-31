# Fotoğraf Tarih Analizi

`public/images/` içindeki 88 fotoğrafın tarihlendirme çalışması. Kaynak: EXIF metadata +
görüntü içine basılmış tarih damgaları + kıyafet/mekân eşleştirmesi.

## Yöntem ve kapsam

| Kaynak | Fotoğraf sayısı | Güvenilirlik |
|---|---|---|
| EXIF `DateTimeOriginal` | 6 | Kesin |
| Görüntüye basılı tarih damgası | 13 | Kesin (okunabilir metin) |
| Kıyafet/mekân eşleştirmesi | 5 | Yüksek |
| Mevsim/kıyafet tahmini | 4 | Orta |
| **Hiçbir ipucu yok** | **60** | — |

Dosya sistemi zaman damgaları işe yaramadı: 88 dosyanın tamamı `2026-06-05 17:49:19`
(tek seferde kopyalanmışlar).

**Önemli:** Dosya numarası kronolojik DEĞİL. Örnek: #41 = 27 Nisan, #6 = 6 Mayıs.
Numara sırasına göre tarih tahmini yapılamaz.

## Kesin tarihli fotoğraflar

### EXIF metadata (Galaxy A24, 4128x3096 orijinal)

| Dosya | Çekim zamanı |
|---|---|
| photo-74 | 2026-06-04 11:06:45 |
| photo-75 | 2026-06-04 11:06:47 |
| photo-76 | 2026-06-04 11:06:49 |
| photo-77 | 2026-06-04 11:06:54 |
| photo-78 | 2026-06-04 11:06:57 |
| photo-79 | 2026-06-04 11:06:59 |

14 saniye içinde çekilmiş altı kare — tek bir an.

### Görüntüye basılı tarih damgası

| Dosya | Damga | Ay |
|---|---|---|
| photo-41 | 27 Nis 2026 | 1. ay |
| photo-30 | 29 Nis 2026 | 1. ay |
| photo-44 | 29 Nis 2026 | 1. ay |
| photo-49 | 30 Nis 2026 | 1. ay |
| photo-31 | 2 May 2026 | 1. ay |
| photo-53 | 2 May 2026 | 1. ay |
| photo-55 | 2 May 2026 | 1. ay |
| photo-6  | 6 May 2026 | 1. ay |
| photo-66 | 6 May 2026 | 1. ay |
| photo-8  | 7 May 2026 | 1. ay |
| photo-9  | 7 May 2026 | 1. ay |
| photo-10 | 7 May 2026 | 1. ay |
| photo-57 | 7 May 2026 | 1. ay |

## Görsel eşleştirmeyle tarihlenenler

### 4 Haziran 2026 — ZAYIF, kanıt sayılmaz

photo-80, 81, 82, 83, 84

Kıyafet photo-74…79 ile aynı görünüyor, ama **aynı kıyafet farklı günlerde tekrar
giyilebilir**. Bu bir tarih kanıtı değildir; sayfa yerleşiminde kullanılmadı.

### Yaz, ayrı bir gün — tarih belirsiz

photo-85, 86, 87, 88

Park/çardak, Furkan gri polo + kafada güneş gözlüğü, Ebru krem ceket + pudra şal.
Arka planda gitar çalan biri var. Dördü de aynı gün. Yaz kıyafeti, yoğun yeşillik —
2. ay muhtemel ama Mayıs ortası da mümkün. **Kesin değil.**

## Tarihlenemeyenler

Kalan 60 fotoğrafta hiçbir metadata, damga veya eşleşme ipucu yok. Görsel olarak
ayırt edilebilen buluşma grupları (tarihleri bilinmiyor):

- photo-1…4 — pembe şal, iç mekân
- photo-13…16 — su kenarı/park, Ebru bej trençkot
- photo-17…21, 59…62 — orman/dere, Furkan siyah tişört
- photo-33…40 — çam ormanı, Ebru krem, Furkan lacivert gömlek
- photo-45…48, 56 — asansör/iç mekân
- photo-50…52 — söğüt ağacı altında
- photo-63…67 — pencere önü, Furkan kahverengi tişört (photo-66 damgası: 6 May 2026,
  yani bu grup 1. ay)
- photo-69…72 — balkon, Furkan gri gömlek, Ebru kot ceket

## Sayfalara uygulanan değişiklik

Yalnızca **EXIF ile kanıtlanan** tek fotoğraf taşındı:

- `photo-75` → 1. ay galerisinden çıkarıldı, 2. ay galerisine eklendi (alt yazısıyla birlikte).
- `photo-76` → 2. ay hero fotoğrafı yapıldı.

photo-81, 84, 88 kıyafet benzerliği dışında hiçbir kanıta dayanmadığı için
1. ay sayfasında bırakıldı. Kıyafet eşleştirmesi tarihlendirme için geçerli bir
yöntem değildir — aynı kıyafet farklı günlerde giyilebilir.

## Alt yazılardan gelen tarihler

Furkan'ın 1. ay galerisine kendi yazdığı alt yazılarda geçen tarihler:

| Dosya | Tarih | Kaynak |
|---|---|---|
| photo-73 | 21 Mayıs 2026 | "21 Mayıs konserinde..." |
| photo-70 | 22 Mayıs 2026 | "22 Mayıs ... 1 aylık kutlaması" |
