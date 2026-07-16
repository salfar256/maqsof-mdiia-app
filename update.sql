-- ============================================================
-- MAQSOF MDIIA — UPDATE / MIGRASI (v1.2)
-- Jalankan file ini di Supabase > SQL Editor bila database LAMA
-- kamu sudah pernah dibuat (agar fitur baru berfungsi).
-- Aman dijalankan berkali-kali.
-- ============================================================

-- Pemisah data antar halaman: "Maqsof Putri" & "Maqsof Putra"
alter table pemasukan          add column if not exists profil text default 'putri';
alter table pengeluaran        add column if not exists profil text default 'putri';
alter table biaya_operasional  add column if not exists profil text default 'putri';
alter table gaji               add column if not exists profil text default 'putri';
alter table stok_barang        add column if not exists profil text default 'putri';

-- Pembelian paketan / dus pada stok
alter table stok_barang add column if not exists isi_per_paket numeric;
alter table stok_barang add column if not exists harga_beli_paket numeric;

-- Pastikan data lama masuk ke halaman "Maqsof Putri"
update pemasukan          set profil = 'putri' where profil is null;
update pengeluaran        set profil = 'putri' where profil is null;
update biaya_operasional  set profil = 'putri' where profil is null;
update gaji               set profil = 'putri' where profil is null;
update stok_barang        set profil = 'putri' where profil is null;

-- ============================================================
-- v1.7 — Kategori kustom disimpan di server (seragam di semua HP)
-- ============================================================
create table if not exists kategori_kustom (
  id uuid primary key default gen_random_uuid(),
  profil text default 'putri',
  modul text not null,
  field text not null,
  nama text not null,
  tipe text not null default 'added',   -- 'added' | 'hidden'
  created_at timestamptz not null default now()
);
alter table kategori_kustom enable row level security;
drop policy if exists "akses_login" on kategori_kustom;
create policy "akses_login" on kategori_kustom for all to authenticated using (true) with check (true);
