# Polaris

Polaris to nieoficjalny, fanowski companion do **Wiedźmina 3** w wersji RC4 PL/EN.

## Uruchamianie

- `index.html` — wersja polska
- `index-en.html` — wersja angielska

Obie strony używają wspólnego klucza `localStorage` (`polaris-complete-rc3`), dlatego przełączanie języka nie usuwa postępu.

## Publikacja

GitHub Actions publikuje statyczne pliki bezpośrednio z repozytorium przez GitHub Pages. Deployment nie zależy od archiwum ZIP ani podzielonego payloadu.

Publikowane pliki: `index.html`, `index-en.html`, `alerts.html`, `overlay.html`, `manifest.json` i `service-worker.js`.

## Polaris Alert dla OBS

- `alerts.html` — panel sterowania przeznaczony także do użycia jako własny dok przeglądarki w OBS
- `overlay.html` — przezroczysta nakładka Browser Source (zalecany rozmiar 1920 × 1080)
- `polaris-hotkeys.lua` — opcjonalny skrypt OBS dodający globalne skróty do pięciu akcji nakładki

Każdy typ alertu ma osobny sygnał dźwiękowy. Aby operator słyszał go podczas gry, dla źródła Polaris należy wybrać w OBS `Zaawansowane właściwości dźwięku → Monitorowanie dźwięku → Monitorowanie i wyjście`.

Panel i nakładka komunikują się lokalnie przez `BroadcastChannel` oraz zdarzenia `localStorage`. Dzięki temu nie wymagają konta, serwera ani płatnej usługi. Oba adresy muszą być otwarte w tej samej instancji OBS.

## Dokumentacja

- `README_PL_EN.txt` — opis wydania PL/EN
- `TESTER_GUIDE.txt` — wskazówki testowe
- `SOURCES.txt` — informacje o źródłach danych
- `LEGAL_NOTICE.txt` — nota prawna

Projekt nie jest zatwierdzony ani wspierany przez CD PROJEKT RED.
