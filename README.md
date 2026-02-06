# 🚀 eProcurement Demo - Panduan Setup

Panduan super simple untuk menjalankan aplikasi eProcurement Demo.

## 📋 Yang Anda Butuhkan

Hanya **Docker Desktop** saja! Tidak perlu install yang lain.

### Install Docker Desktop

**Windows:**
1. Download: https://www.docker.com/products/docker-desktop
2. Install dan restart komputer
3. Buka Docker Desktop (tunggu sampai running)

**Mac:**
1. Download: https://www.docker.com/products/docker-desktop
2. Install dan buka Docker Desktop
3. Tunggu sampai Docker running (icon whale di menu bar)

**Linux:**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt-get install docker-compose-plugin
```

## 🎯 Cara Menjalankan (Super Simple!)

### 1. Pastikan Docker Running

Buka **Docker Desktop** dan pastikan sudah running (icon whale berwarna).

### 2. Jalankan Aplikasi

Buka **Terminal** (Mac/Linux) atau **Command Prompt** (Windows), lalu:

```bash
# Masuk ke folder demo
cd /path/to/demo/folder

# Jalankan aplikasi (1 command aja!)
docker-compose up -d
```

**Tunggu 2-3 menit** untuk download images pertama kali (~500-700 MB).

### 3. Akses Aplikasi

Buka browser dan akses:

| Aplikasi | URL | Login |
|----------|-----|-------|
| **🏢 Admin Portal** | http://localhost:5183 | Email: `admin@qeraton.com`<br>Password: `admin123` |
| **👤 Vendor Portal** | http://localhost:5184 | Email: `vendor@test.com`<br>Password: `vendor123` |
| **🌐 Website** | http://localhost:5185 | (Tidak perlu login) |
| **🔧 API Docs** | http://localhost:6060/api | (Swagger Documentation) |
| **📧 Email UI** | http://localhost:8045 | (Cek email masuk di sini) |
| **📦 Storage UI** | http://localhost:9041 | User: `minioadmin` / Pass: `minioadmin` |
| **🐰 Message Queue** | http://localhost:15682 | User: `guest` / Pass: `guest` |

### 4. Selesai! 🎉

Aplikasi sudah berjalan dan siap untuk demo!

---

## 📂 5. Import Database

**Kabar Gembira!** Database akan otomatis ter-import saat Anda menjalankan `docker-compose up` untuk pertama kalinya (menggunakan file `backup.sql`).

Jika Anda ingin meng-import ulang data secara manual (misal data terhapus), jalankan perintah ini:

```bash
docker exec -i eproc-postgres psql -U eproc -d eproc_demo < backup.sql
```

Aplikasi siap digunakan dengan data lengkap!

---

## 🎬 Demo Flow

### Skenario 1: Vendor Registration
1. Buka **Vendor Portal** (http://localhost:5184)
2. Click "Register as Vendor"
3. Isi form registrasi
4. Buka **Admin Portal** (http://localhost:5183)
5. Login sebagai admin
6. Approve vendor yang baru daftar

### Skenario 2: Purchase Order
1. Login ke **Admin Portal**
2. Buat Purchase Order baru
3. Submit PO
4. Login ke **Vendor Portal**
5. Lihat PO dan acknowledge
6. Kembali ke **Admin Portal**
7. Buat Goods Receipt

### Skenario 3: Reports
1. Login ke **Admin Portal**
2. Navigate ke menu Reports
3. Generate berbagai laporan
4. Export ke Excel/PDF

---

## 🛑 Menghentikan Aplikasi

```bash
# Stop aplikasi (data tetap tersimpan)
docker-compose stop

# Stop dan hapus containers (data tetap tersimpan)
docker-compose down
```

## 🔄 Menjalankan Lagi

```bash
# Kalau sudah pernah dijalankan sebelumnya
docker-compose start

# Atau
docker-compose up -d
```

---

## 🐛 Troubleshooting

### Port Sudah Digunakan

Jika ada error "port already in use":

**Windows:**
```cmd
netstat -ano | findstr :5183
taskkill /PID <PID> /F
```

**Mac/Linux:**
```bash
lsof -ti:5183 | xargs kill -9
```

### Aplikasi Tidak Bisa Diakses

```bash
# Check status
docker-compose ps

# Lihat logs
docker-compose logs -f

# Restart
docker-compose restart
```

### Reset Semua (Fresh Start)

```bash
# Stop dan hapus semua (termasuk data)
docker-compose down -v

# Jalankan lagi
docker-compose up -d
```

### Update Images (Jika Ada Update)

```bash
# Pull images terbaru
docker-compose pull

# Restart dengan images baru
docker-compose up -d
```

---

## 📊 System Requirements

- **RAM**: Minimal 4GB (Recommended 8GB)
- **Storage**: Minimal 5GB free space
- **OS**: Windows 10/11, macOS 10.15+, atau Linux
- **Ports**: 5183, 5184, 5185, 6060, 5440, 9040, 9041, 8045, 5682, 15682 harus tersedia

---

## 💡 Tips

1. **Pastikan Docker Desktop running** sebelum jalankan command
2. **Tunggu 2-3 menit** pertama kali (download images)
3. **Jangan close Docker Desktop** saat aplikasi running
4. **Data akan tersimpan** meskipun restart komputer (selama tidak run `down -v`)

---

## 📞 Butuh Bantuan?

Jika ada masalah:

1. **Check logs**: 
   ```bash
   docker-compose logs -f
   ```

2. **Check status**: 
   ```bash
   docker-compose ps
   ```

3. **Restart semua**: 
   ```bash
   docker-compose restart
   ```

4. **Fresh start**: 
   ```bash
   docker-compose down -v
   docker-compose up -d
   ```

---

## ✅ Quick Command Reference

```bash
# Start
docker-compose up -d

# Stop
docker-compose stop

# Restart
docker-compose restart

# Logs
docker-compose logs -f

# Status
docker-compose ps

# Update
docker-compose pull
docker-compose up -d

# Reset
docker-compose down -v
docker-compose up -d
```

---

**Selamat Demo! 🎉**

Jika ada pertanyaan, hubungi developer yang memberikan file ini.
