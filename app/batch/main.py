import pandas as pd
from transforms import transform_functions
from olap import load_file


def main(data, context):
    bucket = data["bucket"]
    file_name = data["name"]
    df = pd.read_csv(f"{bucket}/{file_name}")

    for func in transform_functions:
        df = func(df)

    load_file(df)
