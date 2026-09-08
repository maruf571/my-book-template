# আমার বই টেমপ্লেট 

Quarto দিয়ে তৈরি একটা বাংলা বই প্রজেক্ট — PDF (KDP-রেডি প্রিন্ট) এবং HTML (ওয়েব রিডিং, light/dark থিম) দুই ফরম্যাটেই আউটপুট দেয়।

## ১. প্রয়োজনীয় টুলস ইনস্টল

### Quarto
- অফিসিয়াল ইনস্টলার: https://quarto.org/docs/get-started/
- অথবা Homebrew দিয়ে: `brew install --cask quarto`
- ইনস্টলের পর ভেরিফাই করুন: `quarto --version` (এই প্রজেক্ট Quarto 1.10.18-এ টেস্ট করা)

### PDF-এর জন্য LaTeX (TinyTeX)
PDF আউটপুট `lualatex` দিয়ে তৈরি হয়। প্রথমবার একবার ইনস্টল করে নিন:

```bash
quarto install tinytex
```

### Mermaid ডায়াগ্রামের জন্য Deno
Quarto নিজেই এটা ম্যানেজ করে — আলাদা করে কিছু করার দরকার নেই। শুধু একবার চেক করে নিন সব ঠিক আছে কিনা:

```bash
quarto check
```

`Deno`, `Pandoc`, `LaTeX (TinyTex)` — সবগুলোর পাশে `[✓] OK` দেখা উচিত। কোনোটা না থাকলে `quarto install tool <name>` দিয়ে ইনস্টল করুন (যেমন `quarto install tool deno`)।

## ২. ফন্ট ইনস্টল

বাংলা টেক্সটের জন্য এই দুইটা ফন্ট সিস্টেমে ইনস্টল থাকতে হবে:

- **Noto Serif Bengali** — https://fonts.google.com/noto/specimen/Noto+Serif+Bengali
- **Noto Sans Bengali** — https://fonts.google.com/noto/specimen/Noto+Sans+Bengali

সবচেয়ে সহজ উপায়, Homebrew দিয়ে (ভবিষ্যতে `brew upgrade` দিয়ে আপডেটও সহজ):

```bash
brew install --cask font-noto-serif-bengali font-noto-sans-bengali
```

অথবা ম্যানুয়ালি: উপরের লিংক থেকে ডাউনলোড করা `.ttf`/variable font ফাইলে ডাবল-ক্লিক করে "Install Font" চাপুন (দুই পদ্ধতিই `~/Library/Fonts/`-এ ফন্ট বসায়, ফলাফল একই)। ইনস্টল হয়েছে কিনা ভেরিফাই করতে:

```bash
fc-list | grep -i bengali
```

**Latin fallback ফন্ট** (TeX Gyre Termes/Heros/Cursor — ইংরেজি টেক্সট আর কোড ব্লকের জন্য) আলাদা করে ইনস্টল করার দরকার নেই, এগুলো TinyTeX-এর সাথেই আসে।

HTML ভার্সনে বাংলা ফন্ট ব্রাউজারে Google Fonts CDN থেকে সরাসরি লোড হয় — সেখানে সিস্টেম-ফন্ট ইনস্টলের দরকার নেই, শুধু ইন্টারনেট কানেকশন লাগবে।

## ৩. প্রজেক্ট স্ট্রাকচার

```
_quarto.yml           মূল কনফিগ — ফন্ট, পেজ সাইজ (trim/margin), PDF+HTML ফরম্যাট সেটিংস
index.qmd              প্রথম পাতা (Preface)
chapters/               অধ্যায়গুলো — অর্ডার _quarto.yml-এর book.chapters লিস্টে ঠিক হয়
frontmatter/            TOC-এর আগের পেজ (উৎসর্গ, epigraph ইত্যাদি) — মার্কডাউনে লেখা
sample/                 মার্কেটিং sample PDF-এর জন্য আলাদা মিনি-প্রজেক্ট
scripts/                বিল্ড হেল্পার স্ক্রিপ্ট (অটো চলে, ম্যানুয়ালি রান করার দরকার নেই)
images/                 বইয়ের ছবি + অটো-জেনারেটেড ডায়াগ্রাম ক্যাশ
styles.css              HTML ভার্সনের রিডেবিলিটি টিউনিং (font-size, line-height)
output/                 জেনারেটেড PDF/HTML (gitignored, প্রতি রেন্ডারে নতুন করে তৈরি হয়)
```

## ৪. আউটপুট জেনারেট করা

| দরকার | কমান্ড | ফলাফল |
|---|---|---|
| পুরো বই (PDF + HTML একসাথে) | `quarto render` | `output/` |
| শুধু PDF | `quarto render --to pdf` | `output/আমার-বই.pdf` |
| শুধু HTML | `quarto render --to html` | `output/index.html` |
| মার্কেটিং sample PDF | `quarto render sample --to pdf` | `output/আমার-বই-sample.pdf` |

লেখার সময় লাইভ প্রিভিউ দেখতে (ব্রাউজারে auto-reload):

```bash
quarto preview
```

### Sample PDF-এ কোন চ্যাপ্টার থাকবে?
`sample/_quarto.yml`-এর `book.chapters` লিস্ট এডিট করুন — যেকোনো চ্যাপ্টার যোগ/বাদ দিতে পারবেন, শুধু পেজ-রেঞ্জ না, পুরো চ্যাপ্টার-লেভেল কন্ট্রোল।

## ৫. নতুন ফ্রন্ট-ম্যাটার পেজ যোগ করা (TOC-এর আগে)

`frontmatter/` ফোল্ডারে একটা নতুন `.qmd` ফাইল বানান, নামের শুরুতে নাম্বার দিন যাতে অর্ডার ঠিক থাকে (যেমন `03-about-author.qmd`)। ভেতরে সাধারণ মার্কডাউন লিখুন। পরের বার PDF রেন্ডার করলেই এটা টেবিল অফ কনটেন্টসের আগে, roman-numeral পেজ নাম্বারে (i, ii, iii...) বসে যাবে।

## ৬. Mermaid ডায়াগ্রাম

যেকোনো চ্যাপ্টারে এভাবে লিখুন:

````
```{mermaid}
flowchart LR
  A --> B
```
````

PDF ও HTML — দুই জায়গাতেই ডায়াগ্রাম দেখাবে (PDF-এ ছবি হিসেবে এমবেড হয়, HTML-এ browser-এ লাইভ রেন্ডার হয়)।

## ৭. Amazon KDP-এর জন্য

- ট্রিম সাইজ 6"×9" সেট করা আছে (`_quarto.yml`-এর `format.pdf.geometry`)।
- পেজ সংখ্যা বাড়লে গাটার (inner margin) বাড়াতে হবে — `_quarto.yml`-এ কমেন্টে KDP-র পেজ-কাউন্ট-ভিত্তিক টেবিল দেয়া আছে।
- কভার (ফ্রন্ট + স্পাইন + ব্যাক একসাথে) এই প্রজেক্ট থেকে অটো তৈরি হয় না — এটা আলাদা ডিজাইন ফাইল। KDP-র ফ্রি Cover Creator ব্যবহার করুন; স্পাইন উইথ ক্যালকুলেট করতে `output/আমার-বই.pdf`-এর পেজ-কাউন্ট লাগবে (`pdfinfo output/আমার-বই.pdf`)।
