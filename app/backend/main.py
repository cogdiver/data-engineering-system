from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {
        "message": "Welcome to Data Engineering System project"
    }

rows = [
    {'id': 1},
    {'id': 2},
    {'id': 3},
]
@app.get("/rows")
def read_rows():
    return rows
