# 資料PDF格納フォルダ / Brochure PDF folder

## 日本語

資料請求ページ（`shiryou.html`）からダウンロードされるPDFをここに配置してください。

- **ファイル名 / File name**: `ORDIA_紹介資料.pdf`
- **配置パス / Path**: `assets/ORDIA_紹介資料.pdf`

このファイル名は `shiryou.html` 内の `PDF_PATH` 変数と一致させる必要があります。
ファイル名を変える場合は `shiryou.html` の `PDF_PATH` も更新してください。

### 自動メール送付を有効化する場合 / To enable automatic email delivery

`shiryou.html` の `FORM_ENDPOINT` にフォーム送信サービスのURLを設定してください。

- 例 / Example: Formspree (`https://formspree.io/f/xxxxxxxx`)、Google Apps Script、自社API 等
- 未設定の場合は、PDFの即時ダウンロードのみ動作します（メール送付なし）。
- サーバー側で「入力メールアドレス宛に資料PDFを自動添付して送信」する処理は、
  選択したフォームサービス側で設定します。

## English

Place the brochure PDF downloaded from `shiryou.html` here.

- File name: `ORDIA_紹介資料.pdf`
- Path: `assets/ORDIA_紹介資料.pdf`

The file name must match the `PDF_PATH` variable in `shiryou.html`.
To enable server-side automatic email delivery, set `FORM_ENDPOINT` in `shiryou.html`
to your form service URL (Formspree, Google Apps Script, custom API, etc.).
Without it, the page only triggers an immediate PDF download.
