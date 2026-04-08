from regex_processor import classify_with_regex
from processor_llm import classify_with_llm
from processor_bert import classify_with_bert
import pandas as pd
def classify(logs):
    labels=[]
    for source,log_msg in logs:
        label=classify_logs(source,log_msg)
        labels.append(label)
    return labels
def classify_csv(df):
    df['target_label']= classify(list(zip(df['source'],df['log_message'])))
    return df

def classify_logs(source, log_message):
    if source=='LegacyCRM':
        label=classify_with_llm(log_message)
    else:
        label=classify_with_regex(log_message)
        if label is None:
            label=classify_with_bert(log_message)
    return label

if __name__=='__main__':
    classify_csv('resources/test.csv')