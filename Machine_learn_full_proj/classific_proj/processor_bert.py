import pickle
from sentence_transformers import SentenceTransformer

# Load models ONCE at import time
try:
    transformer_model = SentenceTransformer('all-MiniLM-L6-v2', local_files_only=True)
except Exception as e:
    print("Error loading transformer model:", e)
    transformer_model = None

try:
    with open('bert_regr_model.pkl', 'rb') as f:
        model = pickle.load(f)
except Exception as e:
    print("Error loading pickle model:", e)
    model = None


def classify_with_bert(log_message):
    if transformer_model is None or model is None:
        return "Unclassified"

    msg_embed = transformer_model.encode(log_message)

    try:
        probab = model.predict_proba([msg_embed])[0]
    except Exception:
        return "Unclassified"

    if max(probab) < 0.5:
        return "Unclassified"

    try:
        prediction = model.predict([msg_embed])[0]
    except Exception:
        return "Unclassified"

    return prediction
