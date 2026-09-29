# IT Asset Tracker — GitHub Pages + Supabase

## ฟังก์ชันในเวอร์ชันนี้
- Login ด้วย Supabase Authentication
- ข้อมูลกลางบน Supabase PostgreSQL + RLS
- Asset Management / Users / Assignment / History / Photos / QR
- จัดการประเภทอุปกรณ์: เพิ่ม / แก้ไขชื่อและไอคอน / ลบ
- Users: Name, EID, Position, Department
- Export Excel
- Export PDF
- Import Excel
- ดาวน์โหลด Excel Import Template
- Backup / Restore JSON

## ไฟล์
- `index.html` — โปรแกรมหลัก
- `config.js` — Supabase URL + Publishable Key ของคุณ
- `supabase.sql` — SQL สำหรับสร้างตารางและ RLS
- `IT-Asset-Tracker-Import-Template.xlsx` — Template สำหรับ Import Excel

## การ Import Excel
ไฟล์ Excel รองรับ 2 Sheet:

### Assets
คอลัมน์:
`Asset ID`, `Asset Name`, `Type`, `Model`, `Serial Number`, `Location`, `Purchase Date`, `Warranty Expiry`, `Status`, `Assignee`, `Notes`

### Users
คอลัมน์:
`User ID`, `Name`, `EID`, `Position`, `Department`

Asset ID / User ID เว้นว่างได้สำหรับรายการใหม่ ระบบจะสร้าง ID ให้เอง

Type ต้องตรงกับประเภทที่มีอยู่ในระบบ ส่วน Status รองรับ key หรือชื่อสถานะที่แสดงในระบบ

Import จะตรวจข้อมูลก่อนบันทึก หากมีบางแถวผิด ระบบจะถามว่าจะนำเข้าเฉพาะแถวที่ถูกต้องหรือไม่

รายการที่มี Asset ID / User ID ตรงกันจะถูกอัปเดต รายการใหม่จะถูกเพิ่ม

> รูปภาพและประวัติการใช้งานจะไม่ถูกนำเข้าจาก Excel Template

## Export
- `Export Excel` จะสร้างไฟล์ `.xlsx` พร้อม Sheets: Assets และ Users
- `Export PDF` จะสร้างรายงานรายการ Assets เป็น PDF แนวนอน A4
- `Excel Template` จะดาวน์โหลด Template เปล่าสำหรับกรอกข้อมูล

## GitHub Pages
เมื่ออัปเดตโปรแกรม ให้แทนที่ `index.html` บน Repository เดิมได้เลย
**อย่าทับ `config.js` หากมี Supabase URL/Publishable Key ของคุณอยู่แล้ว**

## Supabase Security
ห้ามใส่ `service_role` หรือ Secret Key ใน `config.js` หรือ GitHub Repository ให้ใช้ Publishable Key และ RLS ตามที่กำหนดใน `supabase.sql`
