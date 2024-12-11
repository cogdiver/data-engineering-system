import requests
from config import BATCH_URL


def main(data, context):
    bucket = data["bucket"]
    file_name = data["name"]

    requests.post(BATCH_URL, data={
        "bucket": bucket,
        "file_name": file_name,
    })
