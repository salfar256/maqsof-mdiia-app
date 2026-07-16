# 🏪 MAQSOF MDIIA — Aplikasi Manajemen Warung

Aplikasi web untuk mengelola **pemasukan, pengeluaran, biaya operasional, gaji karyawan, dan stok barang** warung. Data tersimpan di **Supabase**, aplikasi **dilindungi login** (hanya pengguna terdaftar), dan bisa di-*hosting* di **Netlify**. Logo tampil sebagai ikon saat ditambahkan ke layar HP.

> ### 🔄 Sudah pakai versi lama? Jalankan `update.sql`
> Kalau database kamu sudah dibuat sebelumnya, buka **Supabase → SQL Editor**, jalankan isi file **`update.sql`** satu kali agar 3 fitur baru berfungsi:
> 1. **Harga beli otomatis** untuk pembelian paketan/dus (mis. 1 dus isi 24 = Rp18.000 → otomatis Rp750/satuan, plus hitung laba per satuan).
> 2. **Kategori bisa diketik sendiri** (ketik baru atau pilih dari saran) di Pemasukan, Pengeluaran, Operasional, dan Stok.
> 3. **Kategori tersimpan di server** — daftar kategori (tambah/hapus) kini seragam di semua HP, bukan per perangkat.
> 3. **Dua halaman terpisah**: *Maqsof Putri* & *Maqsof Putra* — tampilan sama, data berbeda. Ganti lewat menu **Pengaturan**.

Isi folder:

| File | Fungsi |
|------|--------|
| `index.html` | Aplikasinya |
| `schema.sql` | Skema database + aturan keamanan Supabase |
| `update.sql` | Migrasi untuk database lama (jalankan bila upgrade) |
| `manifest.webmanifest` | Info aplikasi untuk ikon di HP |
| `icon-192.png`, `icon-512.png`, `apple-touch-icon.png`, `favicon-*.png`, `logo-web.png`, `logo.png` | Logo & ikon |
| `netlify.toml` | Konfigurasi hosting Netlify |

> URL & kunci Supabase sudah tertanam di `index.html`. Kamu tinggal menyiapkan database & akun login.

---

## 🚀 Pemasangan (± 10 menit)

### 1. Jalankan skema database
1. Buka **https://supabase.com** → masuk ke project kamu.
2. Menu kiri **SQL Editor** → **New query**.
3. Buka `schema.sql`, salin **seluruh isinya**, tempel, klik **Run**. Muncul "Success" = berhasil. ✅

### 2. Buat akun login (WAJIB)
Aplikasi hanya bisa dibuka oleh pengguna terdaftar. Buat akunnya:
1. Menu kiri **Authentication** → tab **Users** → tombol **Add user** → **Create new user**.
2. Isi:
   - **Email:** `sitimarwahhanifanuroin@gmail.com`
   - **Password:** `maqsof256`
   - Centang **Auto Confirm User** (penting, supaya bisa langsung login).
3. Klik **Create user**.

> Ganti password nanti lewat menu Authentication kapan saja.
> Kalau ingin email lain yang boleh masuk, ubah daftar `ALLOWED_EMAILS` di dalam `index.html`.

### 3. (Disarankan) Tutup pendaftaran umum
Supaya tidak ada orang lain bikin akun sendiri:
- **Authentication → Sign In / Providers → Email** → matikan **Allow new users to sign up**.

### 4. Jalankan / hosting aplikasi
**Coba di komputer:** klik dua kali `index.html`.

**Hosting di Netlify (bisa diakses dari HP):**
1. Buka **https://app.netlify.com** → **Add new site → Deploy manually**.
2. **Tarik (drag) seluruh folder ini** ke area upload.
3. Netlify memberi alamat (mis. `namawarung.netlify.app`). Buka dari HP/komputer.

### 5. Login
Masukkan email & password akun tadi → aplikasi terbuka. Sesi tetap tersimpan sampai kamu menekan **Keluar**.

---

## 📲 Menaruh logo di layar HP
1. Buka situs Netlify-nya di browser HP (Chrome / Safari).
2. **Android:** menu ⋮ → **Tambahkan ke layar utama**.
   **iPhone:** tombol Share → **Add to Home Screen**.
3. Ikon **MAQSOF MDIIA** akan muncul di layar HP dan terbuka layar penuh seperti aplikasi.

---

## 📱 Cara Pakai
- **Beranda** — ringkasan untung/rugi bulan ini, grafik arus kas 6 bulan, peringatan stok menipis.
- **Pemasukan / Pengeluaran / Biaya Operasional / Gaji** — tombol **Tambah** untuk mencatat, ikon pensil untuk ubah, tempat sampah untuk hapus.
- **Stok Barang** — atur *stok minimum*; bila stok menipis muncul peringatan di Beranda.
  - **Beli paketan/dus?** Isi *Isi per paket* dan *Harga beli per paket*, harga beli per satuan dihitung otomatis (mis. Rp18.000 ÷ 24 = Rp750). Laba per satuan juga muncul otomatis.
  - **Cetak PDF** — tombol *Cetak PDF* membuat laporan stok rapi (bisa disimpan sebagai PDF lewat dialog cetak, di HP maupun komputer).
  - **Kosongkan** — tombol *Kosongkan* menjadikan semua stok 0 sekaligus (ada peringatan dulu; nama & harga barang tetap tersimpan).
  - **Edit stok kilat** — ubah angka stok langsung di tabel (tanpa buka form); muncul tombol ✓ untuk simpan dan ✗ untuk batal.
- **Kelola kategori** — di form, pilih *⚙️ Kelola kategori…* untuk menambah atau **menghapus** kategori dari daftar pilihan (Enter/tombol Tambah untuk menambah, ikon tempat sampah untuk menghapus). Menghapus hanya menyembunyikan dari daftar; data lama tetap aman.
- **Filter** — di setiap halaman ada dropdown filter (per kategori / status) di sebelah kotak pencarian.
- **Ringkasan Beranda** — angka *Operasional* dan *Gaji* sudah termasuk entri di modul Pengeluaran yang berkategori operasional/gaji (mis. Listrik, Sewa, Transport → Operasional; Gaji → Gaji).
- **Kategori** — di form, ketik kategori baru atau pilih dari daftar saran; kategori baru langsung tersimpan.
- **Ganti halaman (Putri/Putra)** — buka **Pengaturan → Halaman/Wajah Warung**, pilih *Maqsof Putri* atau *Maqsof Putra*. Data tiap halaman terpisah total.
- **Pemilih bulan** (kanan atas) — mengganti periode laporan per bulan.
- **Rentang bulan di Beranda** — di Beranda, pemilih berubah jadi *dari–sampai* sehingga ringkasan & grafik bisa menampilkan beberapa bulan sekaligus (mis. Jan–Jul), bukan hanya satu bulan.
- **Keluar** ada di menu **Pengaturan** (di HP: tab **Lainnya**).

---

## 🔒 Keamanan
- Aplikasi memakai **Supabase Authentication**; data hanya bisa dibaca/ditulis setelah login (diatur oleh RLS di `schema.sql`).
- Kunci yang dipasang di aplikasi adalah **anon public key** — memang aman untuk dipasang di frontend.
- **Jangan** pernah memasang **service_role** / **secret key** di aplikasi atau membagikannya. Jika kunci itu pernah bocor, buka **Settings → API** di Supabase dan **reset/rotate**.

---

## ❓ Masalah Umum
- **"Email atau kata sandi salah"** → cek akun sudah dibuat di Authentication dan **Auto Confirm** tercentang.
- **"Email belum dikonfirmasi"** → buka user di Authentication, konfirmasi manual, atau buat ulang dengan Auto Confirm.
- **Data tidak muncul / gagal memuat** → pastikan `schema.sql` sudah di-Run.
- **Butuh online** → Supabase butuh koneksi internet.

Selamat mengelola warung! 🌿
