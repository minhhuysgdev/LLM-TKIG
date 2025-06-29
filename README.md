# LLM-TIKG

## Documentation

This project implements the LLM-TIKG paper for threat intelligence knowledge graph construction. The implementation details and requirements are documented in the following files:

- [Cursor AI Prompt](cursor-prompt-tikg.md) - Contains detailed implementation requirements, dataset structure, and technical specifications for integrating the LLM-TIKG dataset.

## Project Structure

The project follows a modular implementation with these components:

- **Data Acquisition Module**: Web scraping from threat intelligence sources
- **Dataset Generation Module**: GPT-3.5 annotation with prompts
- **Model Fine-tuning Module**: LoRA-based Llama2-7B fine-tuning
- **Knowledge Graph Module**: Neo4j-based graph construction
- **Evaluation Module**: Performance metrics and validation

## Source Code Structure

```
llm_tikg_integration/
│
├── data/
│   ├── loader.py
│   ├── collator.py
│   └── augmentation.py
│
├── model/
│   ├── trainer.py
│   ├── config.py
│   └── evaluation.py
│
├── graph/
│   ├── knowledge_graph.py
│   ├── neo4j_connector.py
│   └── post_process.py
│
├── config/
│   └── *.yaml
│
├── main_pipeline.py
└── utils/
    └── helper.py
```

### Key Components

1. **Dataset Loading (`dataset_loader.py`)**
   - Loads and preprocesses the LLM-TIKG dataset
   - Handles data splitting and tokenization
   - Prepares data for multi-task learning

2. **Training Configuration (`training_config.py`)**
   - Manages training hyperparameters
   - Configures LoRA fine-tuning settings
   - Handles model and optimizer settings

3. **Data Collation (`data_collator.py`)**
   - Custom data collation for instruction tuning
   - Handles padding and batching
   - Prepares input for model training

4. **Multi-task Training (`multi_task_trainer.py`)**
   - Implements multi-task learning setup
   - Manages model training and evaluation
   - Handles checkpointing and model saving

5. **Evaluation (`evaluation.py`)**
   - Implements evaluation metrics
   - Handles model performance assessment
   - Supports different task types

6. **Knowledge Graph (`knowledge_graph.py`)**
   - Manages Neo4j database connection
   - Handles graph construction
   - Implements entity and relationship creation

7. **Configuration Files**
   - `dataset_config.yaml`: Dataset paths and preprocessing settings
   - `training_config.yaml`: Training hyperparameters
   - `model_config.yaml`: Model architecture and LoRA settings
   - `neo4j_config.yaml`: Neo4j database configuration
   - `default_config.yaml`: Default settings

8. **Main Pipeline (`main_pipeline.py`)**
   - Orchestrates the entire training process
   - Manages component initialization
   - Handles the training workflow

## Getting Started

Please refer to the [Cursor AI Prompt](cursor-prompt-tikg.md) for detailed implementation requirements and technical specifications.
