# 🦁 Hayvanat Bahçesi Yönetim Sistemi (Database Project)

Bu repo; bir hayvanat bahçesinde **hayvan**, **tür**, **alan/enclosure**, **personel**, **ziyaretçi**, **sponsor**, **beslenme programı**, **bakım görevleri** ve **ziyaret planları** süreçlerini yönetmek için tasarlanmış **Oracle uyumlu** bir veritabanı projesidir.

## 📌 İçerik
- `sql/01_schema.sql` : Tablolar + PK/FK/Check constraint’ler
- `sql/02_seed.sql` : Örnek veri (INSERT)
- `sql/03_queries.sql` : Örnek sorgular (subquery, join, group by, date/char function, update, alter table)

## 🗂️ Repo Yapısı
```
zoo-management-db/
├─ README.md
├─ sql/
   ├─ 01_schema.sql
   ├─ 02_seed.sql
   └─ 03_queries.sql

```

## ▶️ Çalıştırma (Oracle)
SQL Developer’da sırayla çalıştır:
```sql
@sql/01_schema.sql
@sql/02_seed.sql
@sql/03_queries.sql
```

## ✅ Notlar 
- Zaman alan kolonlar **TIMESTAMP** olarak tasarlandı (ör. FeedingSchedules.Time, VisitPlans.Start/EndTime).
- Tekrar eden atama/sunum senaryoları için ilişki tablolarında PK içine tarih/saat alanı eklendi (örn. KeeperAssignments, PresentationAssignments).
- FK kolonları için index önerileri schema dosyasında eklendi.
