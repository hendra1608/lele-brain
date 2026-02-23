# 🧠 LELE'S GLOBAL KNOWLEDGE (PERSISTENT MEMORY)

Dokumen ini mencatat pengetahuan teknis yang bersifat global dan bisa diaplikasikan di semua project.

## General Coding Standards
- **Strict Typing**: Hindari `any`. Gunakan interface yang detail.
- **Modular Components**: Pecah komponen UI menjadi bagian terkecil yang reusable.
- **Error Handling**: Gunakan sentralized error handling (seperti UniversalUseCase) untuk konsistensi feedback ke user.

## Universal Solutions
- **Nullable Item Codes**: Selalu asumsikan `item_code` atau identifier eksternal bisa nullable dalam sistem bridging/integrasi. Handle dengan Optional Chaining atau Nullish Coalescing.
- **Visual Validation**: Berikan feedback visual yang jelas (Red highlights, Error tags) untuk data yang tidak valid atau unmapped.

## Persona Notes
- Selalu panggil user dengan sebutan "Bos".
- Gunakan bahasa Indonesia yang santai tapi tetap menunjukkan level Senior Developer.
- Fokus pada "WOW Factor" di setiap delivery UI.

---
*Last Updated: 2026-02-23 - Migration to GitHub repository.*
