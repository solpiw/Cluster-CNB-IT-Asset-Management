# IT Asset Tracker — GitHub Pages + Supabase

ชุดนี้เปลี่ยน IT Asset Tracker จากการเก็บข้อมูลใน browser เป็นฐานข้อมูลกลางบน Supabase และใช้ GitHub Pages เป็นหน้าเว็บ

## ข้อมูลผู้ใช้งาน (Users)

หน้า **จัดการผู้ใช้งาน** แยกข้อมูลออกเป็น 4 ช่อง:
- ชื่อ-นามสกุล
- EID
- ตำแหน่ง (Position)
- แผนก (Department) — เลือกจาก Dropdown

รายการแผนกเริ่มต้น ได้แก่ IT, Front Office, Housekeeping, Food & Beverage, Kitchen, Engineering, Finance & Accounting, Human Resources, Sales & Marketing, Revenue Management, Purchasing, Security, Spa, Executive Office และ Other

ผู้ใช้งานเดิมที่ไม่มี EID/Position จะยังคงอยู่ และสามารถกด **แก้ไข** เพื่อเติมข้อมูลได้ ระบบจะไม่แยกค่าจากช่อง "แผนก / ตำแหน่ง" เดิมให้อัตโนมัติ เพื่อป้องกันข้อมูลเดิมถูกเปลี่ยนโดยไม่ตั้งใจ

## โครงสร้างไฟล์

- `index.html` — ตัวระบบ
- `config.js` — URL + Supabase Publishable Key
- `supabase.sql` — สร้างตาราง + RLS

## ขั้นตอนติดตั้ง

### 1) สร้าง Supabase Project

1. เข้า https://supabase.com/dashboard
2. Create new project
3. ตั้งชื่อ เช่น `it-asset-tracker`
4. ตั้ง Database Password และเก็บไว้ใน password manager
5. รอ project พร้อมใช้งาน

### 2) สร้าง Database

1. เปิด SQL Editor
2. เปิดไฟล์ `supabase.sql`
3. Copy ทั้งหมดไปวาง
4. กด Run
5. ตรวจสอบ Table Editor จะเห็น `app_state`

### 3) สร้างผู้ใช้งาน Login

ใน Supabase Dashboard ไปที่ Authentication > Users แล้วสร้างผู้ใช้ให้ทีม IT เช่น

- itadmin@yourdomain.com
- itusmvl@yourdomain.com
- itusmss@yourdomain.com

ผู้ใช้แต่ละคนต้องมี Password ของตัวเอง

แนะนำให้ปิด Public Sign Ups เพื่อไม่ให้บุคคลภายนอกสมัคร account เอง

### 4) ใส่ Project URL และ Publishable Key

ไปที่ Project > Connect หรือ Settings > API Keys แล้วคัดลอก

- Project URL
- Publishable key (`sb_publishable_...`)

นำไปใส่ใน `config.js`

ห้ามใส่ `sb_secret_...` หรือ `service_role` key ใน `config.js`

### 5) สร้าง GitHub Repository

1. เข้า GitHub
2. New repository
3. ตั้งชื่อ `it-asset-tracker`
4. ถ้าเป็นระบบภายใน แนะนำตั้ง Private
5. Create repository

### 6) Upload files

Upload:

- index.html
- config.js

ไม่จำเป็นต้อง upload `supabase.sql` แต่เก็บไว้เป็นเอกสารสำรองได้

### 7) เปิด GitHub Pages

Repository > Settings > Pages

- Source: Deploy from a branch
- Branch: `main`
- Folder: `/ (root)`
- Save

รอ GitHub deploy แล้วจะได้ URL ประมาณ:

`https://YOUR_GITHUB_USERNAME.github.io/it-asset-tracker/`

### 8) Login

เปิด URL แล้ว Login ด้วย account ที่สร้างใน Supabase Authentication

ทุกเครื่องที่ login จะอ่าน/เขียนข้อมูลจาก `app_state` ชุดเดียวกัน

## ความปลอดภัย

GitHub Pages เป็น public/static hosting จึงต้องถือว่า `config.js` ถูกเปิดเผยได้ การป้องกันข้อมูลจริงอยู่ที่ Supabase Auth + PostgreSQL RLS

Publishable key สามารถอยู่ใน frontend ได้ แต่ secret/service_role key ห้ามอยู่ใน frontend

## หมายเหตุเรื่องการบันทึกข้อมูล

ระบบเดิมเก็บ state ทั้งหมดเป็น JSON ก้อนเดียว ระบบใหม่นี้ยังคงโครงสร้างเดิมเพื่อให้ย้ายระบบได้ง่าย ดังนั้นถ้ามีผู้ใช้สองคนแก้ข้อมูลพร้อมกัน การบันทึกครั้งหลังอาจทับ state ของอีกคนได้

สำหรับทีมเล็กและการใช้งานภายในเหมาะกับโครงสร้างนี้ แต่หากจะขยายเป็นระบบ Production ขนาดใหญ่ ควรแยกตาราง assets, users, assignments, history, locations, warranties ฯลฯ
