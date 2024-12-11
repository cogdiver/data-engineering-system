def clean_columns(df):
    df.columns = df.columns.str.lower()
    return df

transform_functions = [
    clean_columns
]