# 🚀 VS Code Flutter Hotkeys Guide

Hướng dẫn tổng hợp các phím tắt hữu ích giúp bạn **build, clean, generate code, và debug** nhanh hơn trong Flutter project bằng **Visual Studio Code**.

---

## 🏗️ Build Tasks

| Phím tắt | Mô tả |
|----------|-------|
| **Ctrl + Shift + B** | 🏁 Build APK **Production** |
| **Ctrl + Shift + D** | 🧪 Build APK **Development** |
| **Ctrl + Shift + S** | ⚙️ Build APK **Staging** |
| **Ctrl + Shift + R** | 🔨 Build Runner (**One-time build**) – chạy:<br>`flutter pub run build_runner build --delete-conflicting-outputs` |
| **Ctrl + Shift + L** | 🌐 Generate Localization (**L10n**) – chạy:<br>`flutter gen-l10n` |
| **Ctrl + Shift + C** | 🧹 Clean Project – chạy:<br>`flutter clean` |

---

## ⚡ Flutter Pub Commands

| Phím tắt | Mô tả |
|----------|-------|
| **Ctrl + Alt + G** | 📦 Flutter Pub Get – tải các dependency mới |
| **Ctrl + Alt + U** | ⬆️ Flutter Pub Upgrade – nâng cấp các dependency |
| **Ctrl + Alt + O** | 🔍 Flutter Pub Outdated – kiểm tra các package lỗi thời |
| **Ctrl + Alt + C** | 🧹 Flutter Clean – xóa build cũ |

---

## 🧠 Debug & Run Tasks

| Phím tắt | Mô tả |
|----------|-------|
| **F5** | ▶️ Start Debug – chạy ứng dụng ở chế độ Debug |
| **Ctrl + Shift + F5** | 🔁 Restart Debug Session |
| **Shift + F5** | ⏹️ Stop Debug Session |
| **Ctrl + F5** | 🚀 Run Without Debug – chạy ứng dụng không bật debug |

---

## 💡 Tips & Notes

- Bạn có thể thêm các **custom task** khác trong file `.vscode/tasks.json`, ví dụ: chạy test, build web, format code, v.v.  
- Nếu phím tắt bị trùng hoặc muốn chỉnh sửa, mở:  
  👉 `File → Preferences → Keyboard Shortcuts (Ctrl + K Ctrl + S)`  
- Các phím tắt này áp dụng khi **editor đang focus**, một số có thể thay đổi theo OS.

---

## 📁 File liên quan

- `.vscode/keybindings.json` – chứa các phím tắt tuỳ chỉnh.  
- `.vscode/tasks.json` – định nghĩa các lệnh build/run tương ứng với phím tắt.