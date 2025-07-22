# LLM-TIKG Notebooks

This directory contains Jupyter notebooks for the LLM-TIKG (Threat Intelligence Knowledge Graph) project implementation.

## 📚 Available Notebooks

### 01_threat_intelligence_data_collection.ipynb

**Purpose**: Comprehensive threat intelligence data collection following the LLM-TIKG paper methodology.

**Key Features**:
- 🌐 **Multi-platform web scraping** for major threat intelligence sources (CISA, Symantec, Fortinet, TrendMicro)
- 🔧 **Advanced text processing** with indicator extraction and threat relevance scoring
- ✅ **Data validation pipeline** ensuring high-quality outputs
- 📊 **Multiple export formats** optimized for downstream LLM training and knowledge graph construction
- 🛡️ **Rate limiting and error handling** for ethical and robust scraping

**Contents**:
1. Environment setup and library imports
2. Configuration and logging setup
3. Core web scraping infrastructure
4. Platform-specific scrapers
5. Text processing and preprocessing
6. Data validation and quality checks
7. Data collection execution
8. Export and format conversion

**Output Formats**:
- **LLM Training Data**: JSON format ready for model fine-tuning
- **Knowledge Graph Data**: Entities and relationships for TIKG construction
- **JSONL Format**: Streaming-friendly data format
- **Quality Reports**: Comprehensive validation and statistics

## 🚀 Getting Started

### Prerequisites

```bash
# Install dependencies
pip install -r ../requirements.txt

# Ensure NLTK data is downloaded (handled automatically in notebook)
python -c "import nltk; nltk.download('punkt'); nltk.download('stopwords')"
```

### Running the Notebooks

1. **Start Jupyter Lab/Notebook**:
   ```bash
   jupyter lab
   # or
   jupyter notebook
   ```

2. **Open the data collection notebook**:
   - Navigate to `01_threat_intelligence_data_collection.ipynb`
   - Run cells sequentially for best results

3. **Configure collection parameters**:
   - Modify `COLLECTION_CONFIG` in the execution cell
   - Adjust rate limiting and target platforms as needed

### Data Flow

```
Raw Web Data → Scraping → Text Processing → Validation → Export
     ↓              ↓            ↓             ↓         ↓
Web Sources → Structured → Cleaned Text → Quality → Multiple
              Content      + Indicators    Scores   Formats
```

## 📁 Output Structure

After running the data collection notebook, you'll find:

```
../data/
├── raw/                          # Raw scraped data
│   ├── scraping.log             # Scraping activity log
│   ├── threat_intelligence_*.json  # Platform-specific data
│   └── collection_report_*.json   # Collection statistics
└── processed/                    # Processed and formatted data
    ├── llm_training_data_*.json    # Ready for LLM fine-tuning
    ├── knowledge_graph_data_*.json  # Entities and relations
    ├── threat_intelligence_*.jsonl  # Streaming format
    └── export_summary_*.json       # Export statistics
```

## 🔧 Configuration Options

### Collection Parameters

```python
COLLECTION_CONFIG = {
    'max_articles_per_platform': 50,  # Articles per source
    'platforms_to_collect': ['cisa', 'symantec'],  # Target platforms
    'enable_progress_tracking': True,
    'save_intermediate_results': True
}
```

### Rate Limiting

```python
SCRAPING_CONFIG = {
    'rate_limit': 2.0,      # Seconds between requests
    'timeout': 30,          # Request timeout
    'max_retries': 3,       # Retry attempts
}
```

### Quality Thresholds

```python
VALIDATION_RULES = {
    'min_content_length': 100,    # Minimum article length
    'min_threat_score': 0.1,     # Minimum threat relevance
    'required_fields': ['title', 'content', 'source', 'url']
}
```

## 🎯 Quality Metrics

The notebook tracks multiple quality dimensions:

- **Structure**: Required fields, content length, format validity
- **Content Quality**: Readability, vocabulary diversity, technical depth
- **Threat Relevance**: Keyword presence, technical indicators, contextual scoring
- **Source Reliability**: Platform credibility, content consistency

## 🔍 Technical Indicators Extracted

- **IP Addresses**: IPv4 patterns with geolocation context
- **Domain Names**: Malicious domains and C2 infrastructure
- **File Hashes**: MD5, SHA1, SHA256 for malware identification
- **CVE IDs**: Vulnerability references and severity scores
- **URLs**: Malicious links and phishing sites
- **Email Addresses**: Threat actor communication channels

## 📈 Next Steps

After data collection, proceed with:

1. **LLM Fine-tuning**: Use the training data format for model adaptation
2. **Knowledge Graph Construction**: Import entities and relations into graph database
3. **Threat Analysis**: Leverage extracted indicators for threat hunting
4. **Model Evaluation**: Validate knowledge graph quality and coverage

## 🤝 Contributing

When adding new notebooks:

1. Follow the naming convention: `##_descriptive_name.ipynb`
2. Include comprehensive markdown documentation
3. Add configuration sections for reproducibility
4. Implement proper error handling and logging
5. Export data in multiple formats for downstream use

## 📚 References

- LLM-TIKG Paper: [Threat Intelligence Knowledge Graph Construction Utilizing Large Language Models]
- STIX/TAXII Standards: For threat intelligence data formats
- MITRE ATT&CK Framework: For attack pattern categorization
- NIST Cybersecurity Framework: For security context and validation 