# 🚀 VS Code Flutter Hotkeys Guide

Tổng hợp các **phím tắt hữu ích** giúp bạn build, clean và debug nhanh hơn trong **Visual Studio Code** khi làm việc với **Flutter project**.

---

## 🏗️ Build Tasks

| Phím tắt | Mô tả |
|-----------|--------|
| **Ctrl + Shift + B** | 🏁 Build APK **Production** |
| **Ctrl + Shift + D** | 🧪 Build APK **Development** |
| **Ctrl + Shift + S** | ⚙️ Build APK **Staging** |
| **Ctrl + Shift + R** | 🔨 **Build Runner (One-time build)** – chạy lệnh:<br>`flutter pub run build_runner build --delete-conflicting-outputs` |
| **Ctrl + Shift + L** | 🌐 **Generate Localization (L10n)** – chạy:<br>`flutter gen-l10n` |
| **Ctrl + Shift + C** | 🧹 **Clean Project** – chạy:<br>`flutter clean` |

---

## 🧠 Debug & Run Tasks

| Phím tắt | Mô tả |
|-----------|--------|
| **F5** | ▶️ **Start Debug** – chạy ứng dụng ở chế độ Debug |
| **Ctrl + Shift + F5** | 🔁 **Restart Debug Session** |
| **Shift + F5** | ⏹️ **Stop Debug Session** |
| **Ctrl + F5** | 🚀 **Run Without Debug** – chạy ứng dụng không bật debug |

---

## 💡 Gợi ý thêm

- Có thể thêm các **custom task** khác trong file `.vscode/tasks.json` (ví dụ: chạy test, build web, format code, v.v.)
- Nếu phím tắt bị trùng, bạn có thể kiểm tra và chỉnh trong:  
  👉 `File → Preferences → Keyboard Shortcuts` (`Ctrl + K Ctrl + S`)

---

📁 **File liên quan**
- `.vscode/keybindings.json` – chứa các phím tắt tuỳ chỉnh.  
- `.vscode/tasks.json` – định nghĩa các lệnh build/run tương ứng.
