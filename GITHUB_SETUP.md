# 🚀 CassMarrow - GitHub Repository Setup Guide

Bu dosyada CassMarrow projesini GitHub'a nasıl yükleyeceğiniz ve toplulukla nasıl paylaşacağınız anlatılıyor.

## 📦 Repository Kurulumu

### 1. GitHub'da Yeni Repository Oluşturun

1. GitHub'a gidin: https://github.com/new
2. Repository adı: `cassmarrow`
3. Açıklama: `Beautiful, customizable server greeting system for Linux servers 🚀`
4. Public olarak işaretleyin
5. **README eklemeyin** (zaten var)
6. License: MIT (zaten var)
7. Create repository

### 2. Dosyaları Yükleyin

```bash
# Repository'yi klonlayın (boş)
git clone https://github.com/ahmetakifcetin/cassmarrow.git
cd CassToolSSH
# CassMarrow dosyalarını kopyalayın
cp -r /path/to/cassmarrow/files/* .
cp -r /path/to/cassmarrow/files/.github .
cp /path/to/cassmarrow/files/.gitignore .

# Git'e ekleyin
git add .
git commit -m "Initial commit: CassMarrow v1.0.0

- Complete installation system
- Multiple themes and styles
- Docker integration
- Service monitoring
- Comprehensive documentation
- CI/CD pipeline
- Test suite"

# GitHub'a push edin
git push origin main
```

### 3. Repository Ayarlarını Yapın

#### GitHub Pages (Opsiyonel - Dokümantasyon için)
- Settings → Pages
- Source: Deploy from a branch
- Branch: main
- Folder: / (root)

#### Topics (Etiketler)
Settings → Add topics:
```
linux server ssh motd greeting ubuntu debian
bash shell script automation devops sysadmin
homelab self-hosted infrastructure monitoring
```

#### About Section
```
🚀 Beautiful, customizable server greeting system
🎨 Multiple themes and ASCII art styles
📊 Real-time system stats & Docker integration
🔧 Zero dependencies, highly configurable
```

Website: `https://ahmetakifcetin.github.io/cassmarrow`

## 📝 README Güncellemeleri

### URL'leri Düzenleyin

`README.md` dosyasında şunları değiştirin:

```bash
# Tüm "ahmetakifcetin" referanslarını kendi GitHub kullanıcı adınızla değiştirin
sed -i 's/ahmetakifcetin/ACTUAL_USERNAME/g' README.md
sed -i 's/ahmetakifcetin/ACTUAL_USERNAME/g' CONTRIBUTING.md
sed -i 's/ahmetakifcetin/ACTUAL_USERNAME/g' QUICKSTART.md
sed -i 's/ahmetakifcetin/ACTUAL_USERNAME/g' CHANGELOG.md
```

### Installation URL'i

`install.sh` içinde:
```bash
# 8. satırı güncelleyin (REPO URL)
REPO_URL="https://raw.githubusercontent.com/ACTUAL_USERNAME/cassmarrow/main"
```

## 🎨 Sosyal Önizleme (Social Preview)

### Repository İmajı Oluşturma

1. Canva veya Figma kullanarak 1280x640 boyutunda bir görsel oluşturun
2. İçerik:
   - CassMarrow logosu/ASCII art
   - "Beautiful Server Greeting System"
   - Örnek screenshot
3. Settings → Social preview → Upload image

### Önerilen Tasarım:
- Arka plan: Koyu (terminal benzeri)
- Yazı: Beyaz/Cyan
- Font: Monospace
- Screenshot: Terminalde CassMarrow çalışırken

## 📢 Lansmanı Duyurun

### 1. GitHub'da

- [ ] Release oluşturun (v1.0.0)
- [ ] Release notes ekleyin (CHANGELOG'dan)
- [ ] Tag oluşturun: `v1.0.0`

```bash
git tag -a v1.0.0 -m "CassMarrow v1.0.0 - Initial Release"
git push origin v1.0.0
```

### 2. Reddit'te Paylaşın

**r/selfhosted** (en uygun):
```
Title: [Project] CassMarrow - Beautiful Server Greeting System for Linux

I've created CassMarrow, a customizable server greeting tool that 
makes your SSH logins beautiful and informative!

Features:
- 🎨 Multiple themes & ASCII art styles
- 📊 Real-time system stats
- 🐳 Docker integration
- 🔧 Zero dependencies
- ⚡ One-line install

GitHub: https://github.com/ahmetakifcetin/CassToolSSH
Would love your feedback!
```

Diğer subredditler:
- r/homelab
- r/linuxadmin
- r/sysadmin
- r/commandline
- r/bash

### 3. Hacker News

https://news.ycombinator.com/submit

```
Title: CassMarrow – Beautiful server greeting system for Linux
URL: https://github.com/ahmetakifcetin/CassToolSSH```

### 4. Twitter/X

```
🚀 Just released CassMarrow v1.0!

A beautiful server greeting system for Linux 
that makes SSH logins informative and stunning 🎨

✨ Multiple themes & styles
📊 Real-time stats  
🐳 Docker integration
⚡ Zero dependencies

Check it out: github.com/ahmetakifcetin/CassToolSSH
#Linux #DevOps #SelfHosted #OpenSource
```

### 5. Dev.to Article

Bir blog yazısı yazın:
- Projenin hikayesi
- Neden oluşturduğunuz
- Nasıl kullanılır
- Ekran görüntüleri
- Gelecek planları

### 6. Product Hunt (Opsiyonel)

https://www.producthunt.com/posts/new

## 🏷️ Badges (Rozetler) Ekleyin

README.md'nin başına:

```markdown
![GitHub Stars](https://img.shields.io/github/stars/ahmetakifcetin/cassmarrow?style=social)
![GitHub Forks](https://img.shields.io/github/forks/ahmetakifcetin/cassmarrow?style=social)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux-green.svg)
![Shell](https://img.shields.io/badge/shell-bash-yellow.svg)
![GitHub Issues](https://img.shields.io/github/issues/ahmetakifcetin/cassmarrow)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/ahmetakifcetin/cassmarrow)
![CI](https://github.com/ahmetakifcetin/cassmarrow/workflows/CI%20Tests/badge.svg)
```

## 🤝 Topluluk Yönetimi

### Issue Yönetimi

1. **Labeling Strategy**:
   - `bug` - Hatalar
   - `enhancement` - Yeni özellikler
   - `documentation` - Dokümantasyon
   - `good first issue` - Yeni katkıcılar için
   - `help wanted` - Yardım arıyoruz
   - `question` - Sorular

2. **Response Time**:
   - Issue'lara 24-48 saat içinde yanıt verin
   - PR'lara 2-3 gün içinde review yapın

3. **Templates**:
   Zaten var: `.github/ISSUE_TEMPLATE/`

### Pull Request Süreci

1. Her PR'ı inceleyin
2. CI testlerinin geçtiğinden emin olun
3. Kod kalitesini kontrol edin
4. Değişiklikleri test edin
5. Contributors'a teşekkür edin

### Contributors Listesi

README.md'ye ekleyin:
```markdown
## 🙏 Contributors

Thanks to these wonderful people:

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- ALL-CONTRIBUTORS-LIST:END -->
```

## 📈 Analytics & Insights

### GitHub Insights

- Settings → Insights
- İstatistikleri takip edin:
  - Stars
  - Forks
  - Clones
  - Traffic
  - Popular content

### Star History

https://star-history.com/#ahmetakifcetin/CassToolSSH
## 🔄 Sürekli Geliştirme

### Roadmap Oluşturun

`ROADMAP.md` dosyası:
```markdown
# CassMarrow Roadmap

## Version 1.1 (Q1 2026)
- [ ] Weather integration
- [ ] Network statistics
- [ ] More themes
- [ ] Plugin system

## Version 1.2 (Q2 2026)
- [ ] Web configuration panel
- [ ] Mobile app support
- [ ] Cloud integration

## Community Requests
- Check GitHub issues for popular requests
```

### Changelog Güncel Tutun

Her yeni özellik için CHANGELOG.md'yi güncelleyin.

## 💡 İpuçları

1. **İlk Hafta**:
   - Aktif olun, sorulara hızlı cevap verin
   - Bug'ları hızlıca düzeltin
   - Topluluk feedback'ini dinleyin

2. **İlk Ay**:
   - Yeni özellikler ekleyin
   - Dokümantasyonu geliştirin
   - Video tutorial yapın

3. **Uzun Vadede**:
   - Düzenli güncellemeler yapın
   - Topluluk katkılarını kabul edin
   - Projeyi aktif tutun

## 📺 Video İçerik (Opsiyonel)

YouTube'da demo video:
1. Kurulum gösterimi
2. Özelleştirme demo
3. Farklı temalar showcase
4. Use case örnekleri

## 🎯 Success Metrics

İlk ay hedefleri:
- [ ] 100+ GitHub stars
- [ ] 10+ contributors
- [ ] 5+ forks
- [ ] Reddit'te front page
- [ ] 1000+ install

## ✅ Son Kontrol Listesi

Yayınlamadan önce:

- [ ] Tüm URL'ler güncellendi
- [ ] README doğru ve güncel
- [ ] LICENSE dosyası var
- [ ] .gitignore eksiksiz
- [ ] CI/CD çalışıyor
- [ ] Test suite geçiyor
- [ ] Demo script çalışıyor
- [ ] Screenshots hazır
- [ ] Social preview yüklendi
- [ ] Topics/tags eklendi
- [ ] Release notes hazır

## 🚀 Go Live!

```bash
# Final commit
git add .
git commit -m "Ready for launch! 🚀"
git push origin main

# Create release
git tag -a v1.0.0 -m "CassMarrow v1.0.0 - Initial Public Release"
git push origin v1.0.0
```

## 📞 Destek Kanalları

- GitHub Issues: Teknik sorular
- GitHub Discussions: Genel tartışmalar
- Twitter: Güncellemeler ve duyurular
- Email: Özel sorular için

---

**İyi Şanslar! 🎉**

CassMarrow'u topluluğa sunmanın tam zamanı!
