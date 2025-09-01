# 🧠 AI Research Paper Scraper

This tool is a Python-based command-line application that scrapes academic research papers from **arXiv** and uses a **pretrained AI model** to automatically **classify** them by topic. It's designed to help researchers, students, and developers quickly find and categorize scholarly articles related to domains like Machine Learning, Cybersecurity, Robotics, and more.

---

## 🚀 Features

- 🔍 **Keyword Search**: Users can input any topic to find related research papers.
- 📚 **Scrapes from arXiv API**: Reliable source for up-to-date scientific articles.
- 🧠 **Zero-Shot Classification**: Automatically tags articles using a pretrained NLP model (`facebook/bart-large-mnli`) via Hugging Face’s `transformers` library.
- 📦 **JSON Output**: Stores the results in a structured, reusable JSON format.
- 🕓 **Reading Time Estimation**: Calculates how long it would take to read the summary.
- 🛠️ **Customizable Topics**: Easily edit the list of target topics to fit your domain.

---

## 🧪 Example Use Case

1. User runs the script.
2. Prompted to:
   - Enter a **search keyword**
   - Choose how many **articles** to retrieve
   - Choose whether to **append** or **overwrite** existing data
3. The tool fetches articles from arXiv, classifies each by topic using AI, and stores them into `output/arxiv_articles.json`.

---

## 🧠 AI Model

- **Model**: `facebook/bart-large-mnli`
- **Framework**: PyTorch
- **Pipeline**: `zero-shot-classification` from 🤗 [Hugging Face Transformers](https://huggingface.co/transformers/)
- **Why Zero-Shot?**: No training required. The model can predict topics from a given set of labels without needing labeled data.

---

## 📦 Output Format (JSON)

Each paper is saved in the following format:

```json
{
  "title": "Paper Title",
  "date": "2025-09-01",
  "summary": "Paper summary...",
  "internalTags": ["Machine Learning"],
  "author": {
    "name": "First Author",
    "email": "",
    "organization": ""
  },
  "publication": {
    "name": "arXiv",
    "url": "https://arxiv.org/abs/1234.56789"
  },
  "readingTime": 3,
  "sourceUrl": "https://arxiv.org/abs/1234.56789",
  "language": "en",
  "content": "<p>Paper summary in HTML</p>"
}
````

---

📁 **Download Output**:
[Google Drive Link](https://drive.google.com/file/d/1_KEGaMbHUt0Mk_cRIQyxhgC4Iu6Z2QWS/view)


