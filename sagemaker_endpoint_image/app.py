import os, stat
import boto3
from pyllamacpp.model import Model
from flask import Flask, request, jsonify


TMP_MODEL_PATH = "/tmp/model"

# Create a local directory on the Flask server to store the model file
if not os.path.exists(TMP_MODEL_PATH):
    os.makedirs(TMP_MODEL_PATH, mode=0o755, exist_ok=True)
    os.chmod(TMP_MODEL_PATH, stat.S_IRWXG)

# Set the S3 bucket and object key for the model file. 
# Ths bucket is the one created by the account_bootstrap.py script YOU NEED TO CHANGE ITS NAME.
s3_bucket_name = "gpt4all-models-xyz"
s3_object_key = "path/to/model/model.bin"

# Download the model file from S3 to a local directory on the Flask server
s3 = boto3.client("s3")
local_model_path = f"{TMP_MODEL_PATH}/model.bin"
s3.download_file(s3_bucket_name, s3_object_key, local_model_path)

# Load the model from the local directory on the Flask server
model = Model(ggml_model=local_model_path, n_ctx=512)

app = Flask(__name__)


@app.route("/ping", methods=["GET"])
def ping():
    return "pong"


@app.route("/invocations", methods=["POST"])
def invoke():
    content = request.json
    input_text = content["input_text"]
    output_text = model.generate(input_text, n_predict=128, n_threads=8)
    return jsonify(output_text=output_text)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
