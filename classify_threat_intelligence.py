#!/usr/bin/env python3
"""
Script to classify threat intelligence articles using Hugging Face transformers.
"""


def main():
    """
    Main function to run the classification pipeline.
    """
    print("🔍 THREAT INTELLIGENCE CLASSIFICATION")
    print("="*50)
    
    # Input file path
    input_file = "data/processed/merged_threat_intelligence.json"
    
    # Check if input file exists
    if not os.path.exists(input_file):
        print(f"❌ Input file not found: {input_file}")
        return
    
    # Load data
    data = load_data(input_file)
    if not data:
        return
    
    # Setup model
    pipe = setup_model()
    if not pipe:
        return
    
    # Process data
    results = process_data(data, pipe)
    
    # Save results
    save_results(results)
    
    print("\n✅ Classification completed successfully!")

if __name__ == "__main__":
    main() 