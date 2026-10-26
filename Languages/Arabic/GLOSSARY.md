# FuseCP Arabic Glossary

The unified reference for translating the FuseCP interface into Arabic (`ar-AE`).

## Core terms

| English | Arabic | Avoid |
|---|---|---|
| Organization | المؤسسة / مؤسسة / المؤسسات | منظمة، تنظيم |
| Mailbox | صندوق البريد / صناديق البريد | علبة البريد |
| Bandwidth | عرض النطاق الترددي | الباندويث |
| Domain | النطاق / نطاق / النطاقات | المجال، الدومين |
| Sub-domain | النطاق الفرعي | — |
| Domain pointer / alias | مؤشر النطاق | — |
| Password | كلمة المرور | كلمة السر |
| Folder | المجلد | الملف (معناه File) |
| File | الملف | — |
| Export | تصدير | استخراج |
| Import | استيراد | — |
| Web site | موقع الويب / مواقع الويب | موقع إلكتروني |
| Virtual machine (VM) | الجهاز الافتراضي | الآلة الافتراضية |
| Enable / Disable | تمكين / تعطيل | — |
| Enabled / Disabled (status) | ممكَّن / معطَّل (or مفعّل / معطّل depending on the noun's gender) | — |
| Quota | الحصة / الحصص | — |
| Reseller | الموزّع | البائع، المورّد |
| Peer | النظير / النظراء | مقترن، الاقتران |
| Hosting space | مساحة الاستضافة | — |
| Hosting plan | خطة الاستضافة | — |
| Hosting add-on | الوظيفة الإضافية للاستضافة | — |
| Customer | العميل | — |
| User | المستخدم | — |
| Server | الخادم | السيرفر |
| Service | الخدمة | — |
| Provider | الموفّر | — |
| Settings | الإعدادات | — |
| Scheduled task | المهمة المجدولة | — |
| Audit log | سجل التدقيق | — |
| Backup / Restore | النسخ الاحتياطي / الاستعادة | — |
| Snapshot / Checkpoint | اللقطة / نقطة الاستعادة | — |
| Certificate | الشهادة | — |
| Distribution list | قائمة التوزيع | — |
| Public folder | المجلد العام | — |
| Name server | خادم الأسماء | اسم الخادم |
| Subnet | الشبكة الفرعية | النطاق الفرعي |
| Gateway | البوابة | — |
| Report | التقرير | — |

## Names that stay in English

Product names, protocols and acronyms are not translated. They keep their original spelling:

- Exchange, SharePoint, Lync, Skype for Business, Active Directory, ActiveSync, Let's Encrypt, FrontPage
- Hyper-V, Proxmox, SQL Server, MySQL, MariaDB, IIS, FTP, DNS, IP, VLAN, VPS, RDS, CRM, OWA, DotNetNuke, FuseCP
- System account names such as `serveradmin` and `admin`

## Style rules

- **Buttons and actions:** use the verbal noun (إضافة، حذف، حفظ، تحديث، إنشاء), not the imperative (أضف، احذف).
- **Progress messages:** start with «جارٍ» (جارٍ الحذف...).
- **Transitional states:** use «جارٍ...» (جارٍ التشغيل). Final states use the past participle or an adjective (قيد التشغيل، متوقف).
- **Punctuation:**
  - Arabic comma «،», question mark «؟» and semicolon «؛», with no space before them.
  - Keep a colon «:» where the original has one.
- **Spelling:**
  - Write the hamza on hamzat al-qat' (إضافة، إعدادات، أدوات).
  - Do not put a hamza on hamzat al-wasl (اسم، الاتصال، الافتراضي).
  - Taa marbuta (كلمة) and alef maqsura (إلى، على) are written correctly.
- **Sound masculine plural:** in the nominative and the idafa construct, the noun ends in «ـو» (مستخدمو Exchange).
- **Latin text:** a phrase must not start with a Latin word in a way that flips its order in a right-to-left context. Write «خادم Exchange», not «Exchange خادم».
- **Things that must not change:**
  - Variables: `{0}` and `{user}`.
  - HTML tags and entities: `&nbsp;`.
  - Code inside `OnClientClick`: only the message text between the quotes is translated.
  - Bracketed variables: `[date]`.
