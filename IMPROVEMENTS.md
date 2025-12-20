# CassToolSSH v1.1.0 - Yenilikler ve Kullanım Kılavuzu

## 🎉 Yapılan İyileştirmeler

### 1. İnteraktif Kurulum Sihirbazı
Artık iki farklı kurulum modu var:

#### **Hızlı Kurulum** (Önerilen)
- Tek tıkla kurulum
- Varsayılan ayarlarla otomatik yapılandırma
- Curl ile yükleme için ideal

#### **Özel Kurulum**
Kullanıcıya adım adım sorular soruluyor:
1. ✅ **MOTD Aktifleştirme**: SSH girişinde gösterilsin mi?
2. 🎨 **Tema Seçimi**: 6 farklı renk teması (Blue, Green, Purple, Cyan, Red, Yellow)
3. 🖼️ **Stil Seçimi**: 4 farklı ASCII art stili (CassToolSSH, minimal, blocks, simple)
4. 📝 **Sistem Adı**: Özel sistem adı belirleme

### 2. Curl ile Yükleme Sorunu Çözüldü
**Sorun**: `read -p` komutu curl pipe ile çalışmıyordu, "cho: command not found" hatası

**Çözüm**:
- Interactive/non-interactive mod otomatik tespiti
- Curl ile yükleme: Otomatik hızlı kurulum
- Manuel yükleme: İnteraktif özel kurulum seçeneği
- Terminal kontrolü ile stdin yönlendirmesi

### 3. CassTool Yönetim Komutu
Yeni `casstool` komutu ile kolay yönetim:

```bash
# Durum kontrolü
casstool status

# Aktifleştir/Devre Dışı Bırak
casstool enable
casstool disable

# Hızlı tema değiştir
casstool theme

# Hızlı stil değiştir
casstool style

# Test et
casstool test

# Yapılandırma düzenle
casstool config

# İnteraktif özelleştirme
casstool customize

# Kaldır
casstool uninstall
```

### 4. MOTD Otomasyonu
- SSH girişinde otomatik gösterilme artık seçilebilir
- `MOTD_ENABLED` config parametresi ile kontrol
- SSH config otomatik yapılandırması (`PrintMotd yes`)
- Kolay aktifleştirme/devre dışı bırakma

### 5. Geliştirilmiş Hata Yönetimi
- Tüm komutlarda hata kontrolü (`2>/dev/null`)
- Graceful fallback'ler
- Daha iyi error mesajları
- Türkçe kullanıcı mesajları

---

## 📦 Kurulum

### Hızlı Kurulum (Curl ile - Non-Interactive)

```bash
curl -fsSL https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH/main/install.sh | sudo bash
```

**Otomatik Ayarlar:**
- ✅ MOTD: Aktif
- 🎨 Tema: Cyan
- 🖼️ Stil: CassToolSSH
- 📝 Ad: "CassToolSSH Infrastructure"

### İnteraktif Kurulum (Manuel - Özelleştirilebilir)

```bash
# Script'i indir
wget https://raw.githubusercontent.com/ahmetakifcetin/CassToolSSH/main/install.sh

# Çalıştır
sudo bash install.sh
```

**Kurulum Adımları:**
1. Hızlı/Özel kurulum seçimi
2. (Özel kurulumda) MOTD aktifleştirme seçimi
3. (Özel kurulumda) Tema seçimi
4. (Özel kurulumda) Stil seçimi
5. (Özel kurulumda) Sistem adı belirleme

---

## 🎮 Kullanım Örnekleri

### Kurulumdan Sonra İlk Adımlar

```bash
# 1. Durumu kontrol et
casstool status

# 2. Test et
casstool test

# 3. Tema değiştir
casstool theme
# Seçenekler:
# 1) blue    2) green   3) purple
# 4) cyan    5) red     6) yellow

# 4. Stil değiştir
casstool style
# Seçenekler:
# 1) CassToolSSH  2) minimal
# 3) blocks      4) simple
```

### MOTD Yönetimi

```bash
# MOTD'yi aktifleştir (SSH girişinde göster)
casstool enable

# MOTD'yi devre dışı bırak (SSH girişinde gösterme)
casstool disable

# Durum kontrolü
casstool status
```

### Özelleştirme

```bash
# İnteraktif özelleştirme menüsü
casstool customize

# Veya direkt config dosyasını düzenle
casstool config
# (nano /etc/CassToolSSH.conf açılır)
```

### Hızlı Değişiklikler

```bash
# Manuel config değişiklikleri
sudo nano /etc/CassToolSSH.conf

# Değişiklikleri test et
casstool test

# SSH'dan çıkıp gir, otomatik gösterilecek
exit
ssh user@server
```

---

## 🎨 Tema ve Stil Örnekleri

### Temalar

| Tema    | Kullanım Senaryosu |
|---------|-------------------|
| **Blue**   | Professional, sakin sunucular |
| **Green**  | Production, başarılı sistemler |
| **Purple** | Creative, özel projeler |
| **Cyan**   | Modern, teknoloji odaklı (varsayılan) |
| **Red**    | Kritik, dikkat gerektiren |
| **Yellow** | Warning, test sunucuları |

### Stiller

| Stil           | Açıklama |
|----------------|----------|
| **CassToolSSH** | Tam logo, detaylı (varsayılan) |
| **minimal**    | Basit kutu tasarımı |
| **blocks**     | Modern blok karakterler |
| **simple**     | Düz metin, minimalist |

---

## 📝 Config Dosyası Detayları

Dosya: `/etc/CassToolSSH.conf`

```bash
# Görüntüleme Ayarları
SHOW_HOSTNAME=true      # Hostname göster
SHOW_KERNEL=true        # Kernel version
SHOW_UPTIME=true        # Uptime
SHOW_LOAD=true          # Load average
SHOW_MEMORY=true        # Memory kullanımı
SHOW_DISK=true          # Disk kullanımı
SHOW_IP=true            # IP adresleri
SHOW_DOCKER=true        # Docker durumu
SHOW_SERVICES=true      # Servis durumları
SHOW_LAST_LOGIN=true    # Son giriş bilgisi

# Özel Metin
SYSTEM_NAME="CassToolSSH Infrastructure"
SYSTEM_VERSION="v1.0"
CUSTOM_MESSAGE=""       # Alt mesaj (opsiyonel)

# Tema ve Stil
COLOR_THEME="cyan"      # blue, green, purple, cyan, red, yellow
ASCII_STYLE="CassToolSSH" # CassToolSSH, minimal, blocks, simple

# İzlenen Servisler
MONITORED_SERVICES="nginx docker postgresql mysql"

# MOTD Durumu
MOTD_ENABLED="true"     # true/false
```

---

## 🔧 İleri Seviye Kullanım

### Production Server Örneği

```bash
sudo nano /etc/CassToolSSH.conf
```

```bash
SYSTEM_NAME="Production API Server"
SYSTEM_VERSION="v2.0"
COLOR_THEME="red"
ASCII_STYLE="CassToolSSH"
CUSTOM_MESSAGE="⚠️  PRODUCTION - Tüm değişiklikler onay gerektirir"
MONITORED_SERVICES="nginx docker postgresql redis"
MOTD_ENABLED="true"
```

### Development Server Örneği

```bash
SYSTEM_NAME="Development Environment"
SYSTEM_VERSION="dev-latest"
COLOR_THEME="green"
ASCII_STYLE="blocks"
CUSTOM_MESSAGE="🚀 Happy coding! Break things, learn, repeat."
MONITORED_SERVICES="docker postgresql"
MOTD_ENABLED="true"
```

### Minimal Setup

```bash
SYSTEM_NAME="Server"
COLOR_THEME="cyan"
ASCII_STYLE="simple"
SHOW_DOCKER=false
SHOW_SERVICES=false
SHOW_LAST_LOGIN=false
MONITORED_SERVICES=""
MOTD_ENABLED="true"
```

---

## 🐛 Sorun Giderme

### MOTD Gösterilmiyor

```bash
# 1. MOTD durumunu kontrol et
casstool status

# 2. MOTD'yi aktifleştir
casstool enable

# 3. Manuel test et
casstool test

# 4. SSH config kontrol
grep PrintMotd /etc/ssh/sshd_config

# 5. SSH servisini yeniden başlat
sudo systemctl restart sshd
```

### Tema/Stil Değişiklikleri Uygulanmıyor

```bash
# 1. Config dosyasını kontrol et
cat /etc/CassToolSSH.conf

# 2. Manuel test et
casstool test

# 3. SSH'dan çıkıp tekrar gir
exit
ssh user@server
```

### Servisler Gösterilmiyor

```bash
# 1. Servislerin doğru yazıldığından emin ol
systemctl list-units --type=service | grep nginx

# 2. Config dosyasını düzenle
casstool config

# 3. MONITORED_SERVICES satırını güncelle
MONITORED_SERVICES="nginx docker postgresql"

# 4. Test et
casstool test
```

---

## 🗑️ Kaldırma

```bash
# CassToolSSH'u tamamen kaldır
casstool uninstall

# Veya
sudo /opt/CassToolSSH/uninstall.sh
```

**Kaldırılan Öğeler:**
- ✅ `/opt/CassToolSSH/` dizini
- ✅ `/etc/CassToolSSH.conf` dosyası
- ✅ `/usr/local/bin/casstool` komutu
- ✅ `/etc/update-motd.d/00-CassToolSSH` hook
- ✅ Orijinal MOTD ayarları geri yüklenir

---

## 📊 Kurulum Akışı

### Non-Interactive (Curl)
```
curl | bash
    ↓
Banner göster
    ↓
Root kontrolü
    ↓
OS tespiti
    ↓
Hızlı kurulum (otomatik)
    ↓
Config oluştur (varsayılan)
    ↓
MOTD scripti oluştur
    ↓
MOTD sistemi kur
    ↓
casstool komutu oluştur
    ↓
Tamamlandı!
```

### Interactive (Manuel)
```
sudo bash install.sh
    ↓
Banner göster
    ↓
Root kontrolü
    ↓
OS tespiti
    ↓
Kurulum sihirbazı
    ├─ Hızlı kurulum
    └─ Özel kurulum
        ├─ MOTD aktif mi?
        ├─ Tema seç
        ├─ Stil seç
        └─ Sistem adı
    ↓
Config oluştur (seçimlere göre)
    ↓
MOTD scripti oluştur
    ↓
MOTD sistemi kur
    ↓
casstool komutu oluştur
    ↓
Tamamlandı!
```

---

## 🎯 Önemli Değişiklikler

### v1.0.1 → v1.1.0

1. ✅ **Curl ile yükleme düzeltildi**: Interactive/non-interactive mod tespiti
2. ✅ **Kurulum sihirbazı eklendi**: Hızlı/Özel kurulum seçenekleri
3. ✅ **casstool komutu eklendi**: Tüm yönetim işlemleri tek komutla
4. ✅ **MOTD enable/disable**: SSH girişinde gösterilme kontrolü
5. ✅ **Geliştirilmiş hata yönetimi**: Daha az hata, daha iyi mesajlar
6. ✅ **Türkçe kullanıcı arayüzü**: Tüm mesajlar Türkçe
7. ✅ **SSH otomatik yapılandırma**: PrintMotd otomatik aktifleştirme

---

## 💡 İpuçları

1. **Production vs Development**: Farklı sunucularda farklı temalar kullan (Production: red, Dev: green)

2. **Hızlı tema değiştirme**: `casstool theme` ile interaktif tema değiştir

3. **MOTD'yi geçici kapat**: `casstool disable` (kalıcı değil, tekrar `enable` ile aç)

4. **Config yedekle**: 
   ```bash
   sudo cp /etc/CassToolSSH.conf /etc/CassToolSSH.conf.backup
   ```

5. **Cron job ile bildirim**: 
   ```bash
   # Her gün saat 9'da MOTD'yi mail olarak gönder
   0 9 * * * /opt/CassToolSSH/motd.sh | mail -s "Daily Server Report" admin@example.com
   ```

---

## 🚀 Sonraki Adımlar

1. **GitHub'a yükle**: Yeni `install.sh`'i repo'ya push et
2. **README güncelle**: Yeni özellikleri dokümante et
3. **CHANGELOG güncelle**: v1.1.0 değişikliklerini ekle
4. **Release oluştur**: GitHub'da v1.1.0 release'i yayınla

---

## 📞 Destek

Sorun yaşarsan:

1. **Status kontrol**: `casstool status`
2. **Test**: `casstool test`
3. **GitHub Issues**: https://github.com/ahmetakifcetin/CassToolSSH/issues
4. **Dokümantasyon**: README.md ve QUICKSTART.md

---

**Made with ❤️ by Joel**

🌟 Projeyi beğendiysen star vermeyi unutma!
🐦 Sosyal medyada paylaş!
🤝 Katkıda bulun!
