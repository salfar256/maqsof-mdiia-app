-- ============================================================
-- MAQSOF MDIIA — Skema Database (Supabase / PostgreSQL)
-- Jalankan seluruh isi file ini di: Supabase > SQL Editor > New query > Run
-- ============================================================

-- 1) PEMASUKAN --------------------------------------------------
create table if not exists pemasukan (
  id uuid primary key default gen_random_uuid(),
  tanggal date not null default current_date,
  keterangan text not null,
  kategori text,
  jumlah numeric not null default 0,
  created_at timestamptz not null default now()
);

-- 2) PENGELUARAN ------------------------------------------------
create table if not exists pengeluaran (
  id uuid primary key default gen_random_uuid(),
  tanggal date not null default current_date,
  keterangan text not null,
  kategori text,
  jumlah numeric not null default 0,
  created_at timestamptz not null default now()
);

-- 3) BIAYA OPERASIONAL ------------------------------------------
create table if not exists biaya_operasional (
  id uuid primary key default gen_random_uuid(),
  tanggal date not null default current_date,
  nama_biaya text not null,
  kategori text,
  periode text,
  jumlah numeric not null default 0,
  created_at timestamptz not null default now()
);

-- 4) GAJI KARYAWAN ----------------------------------------------
create table if not exists gaji (
  id uuid primary key default gen_random_uuid(),
  tanggal date not null default current_date,
  nama_karyawan text not null,
  jabatan text,
  periode text,
  status text default 'Belum Dibayar',
  jumlah numeric not null default 0,
  created_at timestamptz not null default now()
);

-- 5) STOK BARANG ------------------------------------------------
create table if not exists stok_barang (
  id uuid primary key default gen_random_uuid(),
  nama_barang text not null,
  kategori text,
  stok numeric not null default 0,
  satuan text,
  stok_minimum numeric default 0,
  harga_beli numeric default 0,
  harga_jual numeric default 0,
  created_at timestamptz not null default now()
);

-- 6) KATEGORI KUSTOM (daftar pilihan kategori/satuan yang bisa ditambah/dihapus) --
create table if not exists kategori_kustom (
  id uuid primary key default gen_random_uuid(),
  profil text default 'putri',
  modul text not null,
  field text not null,
  nama text not null,
  tipe text not null default 'added',   -- 'added' | 'hidden'
  created_at timestamptz not null default now()
);

-- ============================================================
-- KOLOM TAMBAHAN (aman dijalankan berulang / untuk upgrade)
--   profil            : memisahkan data "Maqsof Putri" & "Maqsof Putra"
--   isi_per_paket     : jumlah isi per dus/paket (stok)
--   harga_beli_paket  : harga beli per dus/paket (stok)
-- ============================================================
alter table pemasukan          add column if not exists profil text default 'putri';
alter table pengeluaran        add column if not exists profil text default 'putri';
alter table biaya_operasional  add column if not exists profil text default 'putri';
alter table gaji               add column if not exists profil text default 'putri';
alter table stok_barang        add column if not exists profil text default 'putri';

alter table stok_barang add column if not exists isi_per_paket numeric;
alter table stok_barang add column if not exists harga_beli_paket numeric;

-- ============================================================
-- ROW LEVEL SECURITY
-- Data hanya bisa diakses oleh pengguna yang SUDAH LOGIN (authenticated).
-- Pengunjung tanpa login (anon) tidak bisa membaca / menulis data.
-- ============================================================
alter table pemasukan          enable row level security;
alter table pengeluaran        enable row level security;
alter table biaya_operasional  enable row level security;
alter table gaji               enable row level security;
alter table stok_barang        enable row level security;
alter table kategori_kustom    enable row level security;

-- Hapus policy lama jika ada (biar bisa dijalankan ulang tanpa error)
drop policy if exists "akses_publik" on pemasukan;
drop policy if exists "akses_publik" on pengeluaran;
drop policy if exists "akses_publik" on biaya_operasional;
drop policy if exists "akses_publik" on gaji;
drop policy if exists "akses_publik" on stok_barang;
drop policy if exists "akses_login" on pemasukan;
drop policy if exists "akses_login" on pengeluaran;
drop policy if exists "akses_login" on biaya_operasional;
drop policy if exists "akses_login" on gaji;
drop policy if exists "akses_login" on stok_barang;
drop policy if exists "akses_login" on kategori_kustom;

create policy "akses_login" on pemasukan          for all to authenticated using (true) with check (true);
create policy "akses_login" on pengeluaran        for all to authenticated using (true) with check (true);
create policy "akses_login" on biaya_operasional  for all to authenticated using (true) with check (true);
create policy "akses_login" on gaji               for all to authenticated using (true) with check (true);
create policy "akses_login" on stok_barang        for all to authenticated using (true) with check (true);
create policy "akses_login" on kategori_kustom    for all to authenticated using (true) with check (true);

-- ============================================================
-- (OPSIONAL) DATA CONTOH — hapus tanda komentar (--) untuk mengisi contoh
-- ============================================================
-- insert into pemasukan (tanggal, keterangan, kategori, jumlah) values
--   (current_date, 'Penjualan harian', 'Penjualan', 350000),
--   (current_date - 1, 'Jual pulsa', 'Jasa', 45000);
-- insert into pengeluaran (tanggal, keterangan, kategori, jumlah) values
--   (current_date, 'Belanja gula & kopi', 'Belanja Stok', 120000);
-- insert into stok_barang (nama_barang, kategori, stok, satuan, stok_minimum, harga_beli, harga_jual) values
--   ('Kopi sachet', 'Minuman', 8, 'sachet', 10, 1200, 2000),
--   ('Beras 5kg', 'Sembako', 4, 'pack', 3, 62000, 68000);
