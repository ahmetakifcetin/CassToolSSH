# casstool - Proje Dosya Yapısı

## 📦 Repository Dosyaları

```
casstool/
├── install.sh                  # Ana kurulum scripti
├── README.md                   # Proje dokümantasyonu
├── THEMES.md                   # Tema rehberi
├── LICENSE                     # MIT License
├── .gitignore                  # Git ignore kuralları
│
├── themes/                     # Tema dosyaları
│   ├── gradients.sh           # Gradient tema tanımları
│   └── styles.sh              # ASCII art stiller
│
├── scripts/                    # Yardımcı scriptler
│   ├── motd.sh                # Ana MOTD scripti
│   ├── casstool             # Yönetim komutu
│   ├── customize.sh           # İnteraktif özelleştirme
│   └── uninstall.sh           # Kaldırma scripti
│
└── screenshots/                # Ekran görüntüleri
    ├── casstool-ice.png
    ├── casstool-matrix.png
    ├── casstool-ocean.png
    ├── casstool-sunset.png
    ├── casstool-fire.png
    └── ...
```

## 🚀 Kurulum Sonrası Dosya Yapısı

```
/opt/casstool/               # Ana dizin
├── motd.sh                    # MOTD scripti
├── customize.sh               # Özelleştirme aracı
└── uninstall.sh               # Kaldırma scripti

/etc/
├── casstool.conf            # Kullanıcı yapılandırması
└── update-motd.d/
    └── 00-casstool          # MOTD hook

/usr/local/bin/
└── casstool                 # Yönetim komutu

/etc/update-motd.d.backup/     # Orijinal MOTD yedekleri
```

## 📋 Dosya Açıklamaları

### install.sh
- İnteraktif/non-interactive kurulum desteği
- Tema ve stil seçimi sihirbazı
- Otomatik sistem tespit
- MOTD sistemi yapılandırması

### README.md
- Tüm tema ve stiller
- Kurulum talimatları
- Yapılandırma örnekleri
- Kullanım kılavuzu

### THEMES.md
- 16 tema detayları
- Gradient açıklamaları
- Tema karşılaştırma tablosu
- Önerilen kombinasyonlar

### themes/gradients.sh
- 10 gradient tema tanımı
- Renk palette fonksiyonları
- Dinamik renk yükleme

### themes/styles.sh
- 3 ASCII art stili
- Stil fonksiyonları
- Özelleştirilebilir logo

### scripts/motd.sh
- Ana karşılama ekranı
- Dinamik bilgi toplama
- Tema ve stil rendering
- Smart status indicators

### scripts/casstool
- Komut satırı yönetim aracı
- Hızlı tema/stil değiştirme
- Status ve test fonksiyonları
- İnteraktif menüler

## 🔧 Geliştirme İçin

```bash
# Repository'yi klonla
git clone https://github.com/ahmetakifcetin/CassToolSSH.git
cd casstool

# Test et
sudo ./install.sh

# Değişiklik yap
nano scripts/motd.sh

# Test et
/opt/casstool/motd.sh

# Commit et
git add .
git commit -m "feat: yeni özellik"
git push
```

## 📸 Screenshot Ekleme

```bash
# Screenshot al
casstool test

# Kaydet
screenshots/casstool-TEMA.png

# Optimize et
optipng -o7 screenshots/casstool-TEMA.png
```

## 🎨 Yeni Tema Ekleme

1. `themes/gradients.sh` dosyasını düzenle
2. Yeni tema fonksiyonu ekle
3. `scripts/motd.sh` içinde tema case'e ekle
4. `scripts/casstool` yönetim aracına ekle
5. `THEMES.md` dosyasını güncelle
6. Screenshot ekle

## 🚀 Release Süreci

1. CHANGELOG.md güncelle
2. Version numaralarını güncelle
3. GitHub'da tag oluştur: `git tag v2.0.0`
4. Release notes yaz
5. GitHub Release oluştur
6. Sosyal medyada duyur

---

**casstool v2.0.0** 🎨
