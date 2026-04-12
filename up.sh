#!/bin/bash
echo "جاري الرفع يا إبراهيم..."
# التأكد من إضافة كل شيء بما فيها الـ assets
git add .
git add -f assets/ 2>/dev/null
# تسجيل التعديل بوقت الرفع
git commit -m "تحديث تلقائي بتاريخ $(date +'%Y-%m-%d %H:%M')"
# الرفع بالقوة لضمان التزامن
git push origin main --force
echo "-----------------------------------"
echo "تم الرفع بنجاح إلى GitHub! 🚀"
