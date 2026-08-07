# REST API Documentation - Customer

## Table of Contents
- [Overview](#overview)
- [Authentication](#authentication)
- [Base URL](#base-url)
- [Daftar Endpoint](#daftar-endpoint)
- [1. List Customer](#1-list-customer)
- [2. Create Customer](#2-create-customer)
- [3. Detail Customer](#3-detail-customer)
- [4. Update Customer](#4-update-customer)
- [5. Link Akun User](#5-link-akun-user)
- [6. Unlink Akun User](#6-unlink-akun-user)
- [7. Unlinked Akun User](#7-unlinked-akun-user) 
- [8. List Area](#8-list-area)
- [Response Codes](#response-codes)
- [Data Models](#data-models)

---

## Overview

Customer API memungkinkan pengelolaan data pelanggan, termasuk CRUD data customer, dan pengelolaan tautan antara customer dengan akun user di sistem.

**Fitur utama:**
- Daftar dan cari customer dengan filter (search, area, tipe_pelanggan)
- Detail customer beserta data akun user dan area yang terhubung
- Update data customer
- Link/unlink customer dengan akun user (kolom `user_id` pada tabel customers)

**Catatan tabel customers:**
Tabel customers menggunakan `$incrementing = false` — ID ditentukan secara manual saat `store` untuk menghindari konflik dengan tabel `users`.

**Base URL:** `/api/v1`

---

## Authentication

Endpoint yang membutuhkan autentikasi menggunakan Laravel Sanctum. Sertakan bearer token di header:

```
Authorization: Bearer {your-token-here}
```

---

## Base URL

| Scope | Base URL |
|-------|----------|
| Customer (list, create) | `yf/customer` |
| Customer (detail, update, link) | `/api/v1/customers` |
| Area | `yf/area` |

---

## Daftar Endpoint

| Method | Endpoint | Auth | Deskripsi |
|--------|----------|------|-----------|
| `GET` | `yf/customer/loaddatacustomer` | ❌ | Daftar customer dengan filter & paginasi |
| `POST` | _(lihat CustomerController)_ | ❌ | Buat customer baru |
| `GET` | `/api/v1/customers/{id}` | ✅ | Detail customer + user + area |
| `PUT` | `/api/v1/customers/{id}` | ✅ | Update data customer |
| `POST` | `/api/v1/customers/{id}/link` | ✅ | Tautkan customer ke akun user |
| `DELETE` | `/api/v1/customers/{id}/link` | ✅ | Putuskan tautan customer dari akun user |
| `GET` | `/api/v1/customers/unlinked-users` | ✅ | Daftar user yang belum ter-link ke customer |
| `GET` | `yf/area` | ✅ | Daftar area |

---

## 1. List Customer

Menampilkan daftar customer dengan paginasi (10 per halaman). Mendukung filter pencarian, area, dan tipe pelanggan.

**Endpoint:** `GET /api/yf/customer/loaddatacustomer`

**Authentication:** Not required

**Query Parameters:**

| Parameter | Type | Required | Deskripsi |
|-----------|------|----------|-----------|
| `search` | string | Tidak | Filter berdasarkan nama atau nomor HP customer |
| `area` | integer | Tidak | Filter berdasarkan `area_id` |
| `customer_type` | string | Tidak | Filter berdasarkan `tipe_pelanggan` (partial match) |
| `page` | integer | Tidak | Nomor halaman (default: 1) |

**Request:**
```
GET /api/yf/customer/loaddatacustomer
```

**Request dengan filter:**
```
GET /api/yf/customer/loaddatacustomer?search=PT+ABC&area=2&customer_type=industri
```

**Success Response (200):**

```json
{
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 1,
                "name": "PT ABC Indonesia",
                "phone": "0211234567",
                "address": "Jl. Sudirman No. 10, Jakarta",
                "email": "info@ptabc.co.id",
                "tipe_pelanggan": "industri",
                "area_id": 2,
                "user_id": null,
                "created_at": "2026-01-15T08:00:00.000000Z",
                "updated_at": "2026-01-15T08:00:00.000000Z"
            },
            {
                "id": 2,
                "name": "CV Maju Jaya",
                "phone": "02298765432",
                "address": "Jl. Gatot Subroto No. 5, Bandung",
                "email": "cv.majujaya@gmail.com",
                "tipe_pelanggan": "umkm",
                "area_id": 1,
                "user_id": 15,
                "created_at": "2026-02-10T09:30:00.000000Z",
                "updated_at": "2026-08-01T10:00:00.000000Z"
            }
        ],
        "first_page_url": "http://localhost/api/yf/customer/loaddatacustomer?page=1",
        "from": 1,
        "last_page": 5,
        "last_page_url": "http://localhost/api/yf/customer/loaddatacustomer?page=5",
        "next_page_url": "http://localhost/api/yf/customer/loaddatacustomer?page=2",
        "path": "http://localhost/api/yf/customer/loaddatacustomer",
        "per_page": 10,
        "prev_page_url": null,
        "to": 10,
        "total": 48
    }
}
```

---

## 2. Create Customer

Membuat customer baru. ID customer ditentukan otomatis agar tidak bentrok dengan ID di tabel `users`.

**Endpoint:** `POST /api/yf/customer/store` _(sesuaikan route jika berbeda)_

**Authentication:** Not required

**Request Body:**

| Field | Type | Required | Deskripsi |
|-------|------|----------|-----------|
| `name` | string | Ya | Nama customer, maks 255 karakter |
| `phone` | string | Tidak | Nomor telepon, maks 20 karakter |
| `address` | string | Ya | Alamat customer, maks 255 karakter |
| `email` | string | Tidak | Email unik, maks 255 karakter |
| `tipe_pelanggan` | string | Ya | Tipe pelanggan, maks 50 karakter |
| `area_id` | integer | Ya | ID area |

**Request:**
```
POST /api/yf/customer/store
Content-Type: application/json

{
    "name": "PT Baru Jaya",
    "phone": "0213456789",
    "address": "Jl. Kebon Jeruk No. 12, Jakarta Barat",
    "email": "info@ptbarujaya.co.id",
    "tipe_pelanggan": "industri",
    "area_id": 3
}
```

**Success Response (200):**

```json
{
    "status": "success",
    "message": "Customer created successfully"
}
```

**Error Response (409) — Konflik ID:**

```json
{
    "status": "error",
    "message": "Terjadi konflik ID. Coba lagi."
}
```

**Error Response (422) — Validasi gagal:**

```json
{
    "message": "The name field is required.",
    "errors": {
        "name": ["The name field is required."],
        "tipe_pelanggan": ["The tipe_pelanggan field is required."]
    }
}
```

---

## 3. Detail Customer

Mengambil detail satu customer beserta data akun user yang tertaut dan area.

**Endpoint:** `GET /api/v1/customers/{id}`

**Authentication:** Required

**Path Parameters:**

| Parameter | Type | Deskripsi |
|-----------|------|-----------|
| `id` | integer | ID customer |

**Request:**
```
GET /api/v1/customers/2
Authorization: Bearer {token}
```

**Success Response (200):**

```json
{
    "status": "success",
    "message": "Detail customer berhasil dimuat.",
    "data": {
        "id": 2,
        "name": "CV Maju Jaya",
        "phone": "02298765432",
        "address": "Jl. Gatot Subroto No. 5, Bandung",
        "email": "cv.majujaya@gmail.com",
        "tipe_pelanggan": "umkm",
        "area_id": 1,
        "user_id": 15,
        "created_at": "2026-02-10T09:30:00.000000Z",
        "updated_at": "2026-08-01T10:00:00.000000Z",
        "user": {
            "id": 15,
            "name": "Andi Suryana",
            "email": "andi@cvmajujaya.com",
            "role": "customer"
        },
        "area": {
            "id": 1,
            "name": "Bandung"
        }
    }
}
```

**Response jika belum ada akun tertaut:**

```json
{
    "status": "success",
    "message": "Detail customer berhasil dimuat.",
    "data": {
        "id": 1,
        "name": "PT ABC Indonesia",
        "user_id": null,
        "user": null,
        "area": {
            "id": 2,
            "name": "Jakarta"
        }
    }
}
```

**Error Response (404):**

```json
{
    "status": "error",
    "message": "Customer tidak ditemukan."
}
```

---

## 4. Update Customer

Mengubah data customer. Semua field bersifat opsional — kirim hanya field yang ingin diubah.

**Endpoint:** `PUT /api/v1/customers/{id}`

**Authentication:** Required

**Path Parameters:**

| Parameter | Type | Deskripsi |
|-----------|------|-----------|
| `id` | integer | ID customer |

**Request Body (semua field opsional):**

| Field | Type | Deskripsi |
|-------|------|-----------|
| `name` | string | Nama customer, maks 255 karakter |
| `phone` | string\|null | Nomor telepon, maks 20 karakter |
| `address` | string | Alamat customer, maks 255 karakter |
| `email` | string\|null | Email unik (kecuali milik customer ini sendiri) |
| `tipe_pelanggan` | string | Tipe pelanggan, maks 50 karakter |
| `area_id` | integer | ID area |

**Request:**
```
PUT /api/v1/customers/2
Authorization: Bearer {token}
Content-Type: application/json

{
    "phone": "0812999888",
    "address": "Jl. Asia Afrika No. 20, Bandung",
    "tipe_pelanggan": "industri"
}
```

**Success Response (200):**

```json
{
    "status": "success",
    "message": "Data customer CV Maju Jaya berhasil diperbarui.",
    "data": {
        "id": 2,
        "name": "CV Maju Jaya",
        "phone": "0812999888",
        "address": "Jl. Asia Afrika No. 20, Bandung",
        "email": "cv.majujaya@gmail.com",
        "tipe_pelanggan": "industri",
        "area_id": 1,
        "user_id": 15,
        "user": {
            "id": 15,
            "name": "Andi Suryana",
            "email": "andi@cvmajujaya.com",
            "role": "customer"
        },
        "area": {
            "id": 1,
            "name": "Bandung"
        }
    }
}
```

**Error Response (404):**

```json
{
    "status": "error",
    "message": "Customer tidak ditemukan."
}
```

**Error Response (422) — Email sudah digunakan customer lain:**

```json
{
    "message": "The email has already been taken.",
    "errors": {
        "email": ["The email has already been taken."]
    }
}
```

---

## 5. Link Akun User

Menautkan customer dengan akun user yang ada di sistem. Setelah ditautkan, user tersebut dapat login dan mengakses fitur customer (self-order, dll).

**Endpoint:** `POST /api/v1/customers/{id}/link`

**Authentication:** Required

**Path Parameters:**

| Parameter | Type | Deskripsi |
|-----------|------|-----------|
| `id` | integer | ID customer |

**Request Body:**

| Field | Type | Required | Deskripsi |
|-------|------|----------|-----------|
| `user_id` | integer | Ya | ID user yang akan ditautkan |

**Request:**
```
POST /api/v1/customers/2/link
Authorization: Bearer {token}
Content-Type: application/json

{
    "user_id": 15
}
```

**Success Response (200):**

```json
{
    "status": "success",
    "message": "Akun berhasil ditautkan ke customer CV Maju Jaya.",
    "data": {
        "customer_id": 2,
        "customer_name": "CV Maju Jaya",
        "linked_user": {
            "id": 15,
            "name": "Andi Suryana",
            "email": "andi@cvmajujaya.com",
            "role": "customer"
        }
    }
}
```

**Error Response (404) — Customer tidak ditemukan:**

```json
{
    "status": "error",
    "message": "Customer tidak ditemukan."
}
```

**Error Response (422) — User sudah terhubung ke customer lain:**

```json
{
    "status": "error",
    "message": "Akun user ini sudah terhubung dengan customer lain (PT ABC Indonesia)."
}
```

**Error Response (422) — Customer sudah punya akun lain:**

```json
{
    "status": "error",
    "message": "Customer ini sudah terhubung dengan akun lain. Unlink terlebih dahulu."
}
```

**Error Response (422) — User tidak ditemukan:**

```json
{
    "message": "The selected user id is invalid.",
    "errors": {
        "user_id": ["The selected user id is invalid."]
    }
}
```

> **Catatan:** Satu user hanya bisa ditautkan ke satu customer. Jika customer sudah terhubung ke akun lain, lakukan unlink dulu sebelum menautkan ke akun baru.

---

## 6. Unlink Akun User

Memutuskan tautan antara customer dan akun user. Setelah unlink, kolom `user_id` pada customer menjadi `null`.

**Endpoint:** `DELETE /api/v1/customers/{id}/link`

**Authentication:** Required

**Path Parameters:**

| Parameter | Type | Deskripsi |
|-----------|------|-----------|
| `id` | integer | ID customer |

**Request:**
```
DELETE /api/v1/customers/2/link
Authorization: Bearer {token}
```

**Success Response (200):**

```json
{
    "status": "success",
    "message": "Tautan akun Andi Suryana dari customer CV Maju Jaya berhasil diputus."
}
```

**Error Response (404) — Customer tidak ditemukan:**

```json
{
    "status": "error",
    "message": "Customer tidak ditemukan."
}
```

**Error Response (422) — Belum ada akun tertaut:**

```json
{
    "status": "error",
    "message": "Customer ini belum terhubung dengan akun apapun."
}
```

---

## 7. Unlinked Akun User

Menampilkan daftar akun user dengan role `customer` yang belum terhubung ke customer manapun. Berguna untuk memilih akun yang akan ditautkan ke customer.

**Endpoint:** `GET /api/v1/customers/unlinked-users`

**Authentication:** Required

**Query Parameters:**

| Parameter | Type | Required | Deskripsi |
|-----------|------|----------|-----------|
| `search` | string | Tidak | Filter berdasarkan nama atau email user |
| `page` | integer | Tidak | Nomor halaman (default: 1) |

**Request:**
```
GET /api/v1/customers/unlinked-users
Authorization: Bearer {token}
```

**Request dengan filter:**
```
GET /api/v1/customers/unlinked-users?search=john
Authorization: Bearer {token}
```

**Success Response (200):**

```json
{
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 15,
                "name": "John Doe",
                "email": "john@example.com",
                "role": "customer"
            },
            {
                "id": 20,
                "name": "Jane Smith",
                "email": "jane@example.com",
                "role": "customer"
            }
        ],
        "first_page_url": "http://localhost/api/v1/customers/unlinked-users?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "http://localhost/api/v1/customers/unlinked-users?page=1",
        "next_page_url": null,
        "path": "http://localhost/api/v1/customers/unlinked-users",
        "per_page": 10,
        "prev_page_url": null,
        "to": 2,
        "total": 2
    }
}
```

**Catatan:**
- Hanya menampilkan user dengan role `customer`
- User yang sudah terhubung ke customer manapun tidak akan muncul
- Paginasi: 10 user per halaman

## 8. List Area

Mengambil daftar area yang tersedia untuk digunakan sebagai filter atau saat membuat/update customer.

**Endpoint:** `GET /api/yf/area`

**Authentication:** Required

**Request:**
```
GET /api/yf/area
Authorization: Bearer {token}
```

**Success Response (200):**

```json
{
    "data": [
        { "id": 1, "name": "Bandung" },
        { "id": 2, "name": "Jakarta" },
        { "id": 3, "name": "Surabaya" },
        { "id": 4, "name": "Yogyakarta" }
    ]
}
```

---

## Response Codes

| HTTP Status | Arti |
|-------------|------|
| `200 OK` | Request berhasil |
| `201 Created` | Data berhasil dibuat |
| `401 Unauthorized` | Token tidak valid atau tidak disertakan |
| `404 Not Found` | Data tidak ditemukan |
| `409 Conflict` | Konflik ID saat membuat customer |
| `422 Unprocessable Entity` | Validasi request gagal |
| `500 Internal Server Error` | Error di sisi server |

---

## Data Models

### Customer

| Field | Type | Deskripsi |
|-------|------|-----------|
| `id` | integer | ID customer (non-auto-increment) |
| `name` | string | Nama customer/perusahaan |
| `phone` | string\|null | Nomor telepon |
| `address` | string | Alamat customer |
| `email` | string\|null | Email customer (unik) |
| `tipe_pelanggan` | string | Tipe pelanggan (contoh: `industri`, `umkm`, `personal`) |
| `area_id` | integer | ID area |
| `user_id` | integer\|null | ID user yang ditautkan (null jika belum ada akun) |
| `created_at` | datetime | Waktu dibuat |
| `updated_at` | datetime | Waktu terakhir diperbarui |

### Relasi

| Relasi | Type | Deskripsi |
|--------|------|-----------|
| `user` | `belongsTo User` | Akun user yang ditautkan (`id`, `name`, `email`, `role`) |
| `area` | `belongsTo Area` | Area customer (`id`, `name`) |

---

## Contoh Alur Penggunaan

### Alur: Daftarkan customer baru dan tautkan akun

```
1. POST /api/yf/customer/store
   Body: { "name": "PT Baru", "address": "Jakarta", "tipe_pelanggan": "industri", "area_id": 2 }
   → Customer dibuat dengan ID otomatis

2. GET /api/v1/customers/{id}
   → Konfirmasi data customer + user_id masih null

3. POST /api/yf/register   (atau sudah ada user yang ada)
   → Buat akun user baru dengan role "customer"

4. POST /api/v1/customers/{id}/link
   Body: { "user_id": 20 }
   → Customer tertaut ke akun user
```

### Alur: Ganti akun yang tertaut

```
1. DELETE /api/v1/customers/{id}/link
   → Putuskan tautan akun lama

2. POST /api/v1/customers/{id}/link
   Body: { "user_id": 25 }
   → Tautkan ke akun baru
```

### Alur: Cari customer berdasarkan nama

```
GET /api/yf/customer/loaddatacustomer?search=PT+ABC&area=2
→ Daftar customer bernama "PT ABC" di area Jakarta (id: 2)
```
